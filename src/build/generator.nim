import asyncdispatch
import ../kubernetes/client
import json
import tables
import options
import sets
import strutils
import sequtils
import strformat
import parseopt

type

  GroupVersionKind* = object
    group*: string
    kind*: string
    version*: string
  
  TypeSpec* = object
    `type`*: Option[string]
    `$ref`* : Option[string]
    format: Option[string]

  Property* = object
    description*: Option[string]
    `type`*: Option[string]
    `$ref`* : Option[string]
    format: Option[string]
    additionalProperties*: Option[TypeSpec]
    items*: Option[TypeSpec]
  
  ExtendedTypeSpec = object
    typ: Option[string]
    reference: Option[string]
    format: Option[string]
    additionalProperties*: Option[TypeSpec]
    items*: Option[TypeSpec]
  
  Definition* = object
    description*: Option[string]
    required*: Option[seq[string]]
    properties*: Option[Table[string,Property]]
    `type`*: Option[string]
    format: Option[string]
    `x-kubernetes-group-version-kind`*: Option[seq[GroupVersionKind]]

  Definitions* = Table[string,Definition]

  
  Module* = object
    name*: string
    definitions*: Table[string,Definition]

proc extendedTypeSpec(ts: TypeSpec): ExtendedTypeSpec =
  return ExtendedTypeSpec(typ: ts.`type`, reference: ts.`$ref`, format: ts.format, additionalProperties: none(TypeSpec),items: none(TypeSpec) )

proc extendedTypeSpec(ts: Property): ExtendedTypeSpec =
  return ExtendedTypeSpec(typ: ts.`type`, reference: ts.`$ref`, format: ts.format, additionalProperties: ts.additionalProperties,items: ts.items)

proc extendedTypeSpec(ts: Definition): ExtendedTypeSpec =
  return ExtendedTypeSpec(typ: ts.`type`, reference: none(string), format: ts.format, additionalProperties: none(TypeSpec),items: none(TypeSpec))

iterator references(definition: Definition): string =
  if definition.properties.isSome:
    for property in definition.properties.get.values:
      if property.`$ref`.isSome:
        yield property.`$ref`.get.split("/")[^1]
      elif property.items.isSome:
        let r = property.items.get()
        if r.`$ref`.isSome:
          yield r.`$ref`.get.split("/")[^1]

proc modulename(qualifiedName: string): string =
  qualifiedName.rsplit(".",1)[0].replace(".","_")

proc typename(qualifiedName: string): string =
  qualifiedName.rsplit(".",1)[1]

proc toModules(definitions: Definitions): seq[Module] =
  let modules = newTable[string,Module]()
  for name, definition in definitions.pairs:
    let moduleName = name.modulename
    if not modules.hasKey(moduleName):
      modules[moduleName] = Module(name: moduleName)
    modules[moduleName].definitions[name]=definition

  return toSeq(modules.values)

proc nimType(ts: ExtendedTypeSpec, modulename: string): string =
  if ts.typ.isSome:
    case ts.typ.get:
      of "string":
        if ts.format.isSome:
          case ts.format.get:
            of "date-time":
              return "DateTime"
            of "email":
              return "string"
            of "hostname":
              return "string"
            of "ipv4":
              return "string"
            of "ipv6":
              return "string"
            of "uri":
              return "string"
            of "byte":
              return "ByteArray"
        return "string"
      of "integer":
        return "int"
      of "float":
        return "float"
      of "boolean":
        return "bool"
      of "array":
        var subtype = "string"
        if ts.items.isSome:
          let items = ts.items.get()
          subtype = items.extendedTypeSpec.nimType(modulename)
        return ("seq[" & subtype & "]")
      of "object":
        var subtype = "string"
        if ts.additionalProperties.isSome:
          let items = ts.additionalProperties.get()
          subtype = items.extendedTypeSpec.nimType(modulename)
        return ("Table[string," & subtype & "]")
  elif ts.reference.isSome:
    let refname = ts.reference.get.split("/")[^1]
    if refname.modulename == modulename:
      return refname.typename
    else:
      return refname.modulename & "." & refname.typename
  else:
    return "string"

proc nimImport(ts: ExtendedTypeSpec, modulename: string, imports: var OrderedSet[string]) =
  if ts.typ.isSome:
    case ts.typ.get:
      of "string":
        if ts.format.isSome:
          case ts.format.get:
            of "date-time":
              imports.incl("times")
      of "array":
        if ts.items.isSome:
          let items = ts.items.get()
          items.extendedTypeSpec.nimImport(modulename,imports)
      of "object":
        imports.incl("tables")
        if ts.additionalProperties.isSome:
          let items = ts.additionalProperties.get()
          items.extendedTypeSpec.nimImport(modulename,imports)
  elif ts.reference.isSome:
    let refname = ts.reference.get.split("/")[^1]
    if refname.modulename != modulename:
      imports.incl(refname.modulename)

proc apiPath(definition: Definition): Option[string] =
  proc mapper(gvk: seq[GroupVersionKind]):string =
    if gvk[0].group == "": 
      return "/api/" & gvk[0].version
    else:
      return  "/apis/" & gvk[0].group & "/" & gvk[0].version
  definition.`x-kubernetes-group-version-kind`.map(mapper) 

proc apiVersion(definition: Definition): Option[string] =
  proc mapper(gvk: seq[GroupVersionKind]):string =
    if gvk[0].group == "": 
      return gvk[0].version
    else:
      return  gvk[0].group & "/" & gvk[0].version
  definition.`x-kubernetes-group-version-kind`.map(mapper) 

proc generateType(definition: Definition, name: string, f: File) =
  f.writeLine("")
  f.writeLine("type")
  f.writeLine("  ", name.typename, "* = object")
  for propertyName, property in definition.properties.get.pairs:
    var t = nimType(property.extendedTypeSpec,name.modulename)
    f.writeLine("    `",propertyName,"`*: ", t)

proc generateLoad(definition: Definition, name: string, f: File) =
  f.writeLine("")
  f.writeLine("proc load*(self: var ", name.typename, ", parser: var JsonParser) =")
  f.writeLine("  if parser.kind != jsonObjectStart: raiseParseErr(parser,\"object start\")")
  f.writeLine("  parser.next")
  f.writeLine("  while true:")
  f.writeLine("    case parser.kind:")
  f.writeLine("      of jsonObjectEnd:")
  f.writeLine("        parser.next")
  f.writeLine("        return")
  f.writeLine("      of jsonString:")
  f.writeLine("        let key = parser.str")
  f.writeLine("        parser.next")
  f.writeLine("        case key:")
  for propertyName, property in definition.properties.get.pairs:
    f.writeLine(&"""          of "{propertyName}":""")
    f.writeLine(fmt"            load(self.`{propertyName}`,parser)")
  f.writeLine("      else: raiseParseErr(parser,\"string not \" & $(parser.kind))")


proc generateDump(definition: Definition, name: string, f: File) =
  f.writeLine("")
  f.writeLine("proc dump*(self: ", name.typename, ", s: JsonStream) =")
  f.writeLine("  s.objectStart()")
  let apiVersion = definition.apiVersion
  if apiVersion.isSome:
    f.writeLine(&"""  s.name("apiVersion"); s.value("{apiVersion.get}")""")
    f.writeLine(&"""  s.name("kind"); s.value("{name.typename}")""")
  let required = toHashSet(definition.required.get(@[]))
  for propertyName, property in definition.properties.get.pairs:
    if apiVersion.isSome and (propertyName == "kind" or propertyName == "apiVersion"):
      continue
    if not required.contains(propertyName):
      f.writeLine(&"""  if not self.`{propertyName}`.isEmpty:""")
      f.writeLine(&"""    s.name("{propertyName}")""")
      f.writeLine(&"""    self.`{propertyName}`.dump(s)""")
    else:
      f.writeLine(&"""  s.name("{propertyName}")""")
      f.writeLine(&"""  self.`{propertyName}`.dump(s)""")
  f.writeLine("  s.objectEnd()")

proc generateIsEmpty(definition: Definition, name: string, f: File) =
  f.writeLine("")
  f.writeLine("proc isEmpty*(self: ", name.typename, "): bool =")
  for propertyName, property in definition.properties.get.pairs:
    f.writeLine(&"""  if not self.`{propertyName}`.isEmpty: return false""")
  f.writeLine(&"""  true""")

proc generateApi(definition: Definition, name: string, apiPath: string, f: File) =
  f.writeLine("")
  f.writeLine("proc load", name.typename, "(parser: var JsonParser):", name.typename, " = ")
  f.writeLine("  var ret: ", name.typename, "")
  f.writeLine("  load(ret,parser)")
  f.writeLine("  return ret ")
  if name.endsWith("List"):
    let itemName = name.typename[0..^5]
    f.writeLine("")
    f.writeLine("proc list*(client: Client, t: typedesc[", itemName, "], namespace = \"default\"): Future[seq[", itemName, "]] {.async.}=")
    f.writeLine("  return (await client.list(\"" & apiPath & "\", ", name.typename, ", namespace, load", name.typename, ")).items")
  else:
    f.writeLine("")
    f.writeLine("proc get*(client: Client, t: typedesc[", name.typename, "], name: string, namespace = \"default\"): Future[", name.typename, "] {.async.}=")
    f.writeLine("  return await client.get(\"" & apiPath & "\", t, name, namespace, load", name.typename, ")")
    f.writeLine("")
    f.writeLine("proc create*(client: Client, t: ", name.typename, ", namespace = \"default\"): Future[", name.typename, "] {.async.}=")
    f.writeLine("  return await client.create(\"" & apiPath & "\", t, namespace, load", name.typename, ")")
    f.writeLine("")
    f.writeLine("proc delete*(client: Client, t: typedesc[", name.typename, "], name: string, namespace = \"default\") {.async.}=")
    f.writeLine("  await client.delete(\"" & apiPath & "\", t, name, namespace)")

proc generateIntOrString(name: string, f: File) =
  f.writeLine("")
  f.writeLine("type")
  f.writeLine("  ", name.typename, "* = distinct base_types.IntOrString")
  f.writeLine("")
  f.writeLine("proc load*(self: var ", name.typename, ", parser: var JsonParser) =")
  f.writeLine("  load(base_types.IntOrString(self),parser)")
  f.writeLine("")
  f.writeLine("proc dump*(self: ", name.typename, ", s: JsonStream) =")
  f.writeLine("  dump(base_types.IntOrString(self),s)")
  f.writeLine("")
  f.writeLine("proc isEmpty*(self: ", name.typename, "): bool = base_types.IntOrString(self).isEmpty")

proc generateTypedef(definition: Definition, name: string, f: File) =
  f.writeLine("")
  f.writeLine("type")
  let subtype = definition.extendedTypeSpec.nimType(name.modulename)
  f.writeLine("  ", name.typename, "* = distinct ",subtype)
  f.writeLine("")
  f.writeLine("proc load*(self: var ", name.typename, ", parser: var JsonParser) =")
  f.writeLine(fmt"  load({subtype}(self),parser)")
  f.writeLine("")
  f.writeLine("proc dump*(self: ", name.typename, ", s: JsonStream) =")
  f.writeLine(fmt"  dump({subtype}(self),s)")
  f.writeLine("")
  f.writeLine("proc isEmpty*(self: ", name.typename, "): bool = ",subtype,"(self).isEmpty")

proc generate(definition: Definition, name: string, f: File) =
  if definition.properties.isSome:
    definition.generateType(name,f)
    definition.generateLoad(name,f)
    definition.generateDump(name,f)
    definition.generateIsEmpty(name,f)

    let apiPath = definition.apiPath
    if apiPath.isSome:
      definition.generateApi(name,apiPath.get,f)

  else:
    if name.typename == "IntOrString":
      generateIntOrString(name,f)
    else:
      definition.generateTypedef(name,f)



proc fillReferences(name: string, definitions: Table[string,Definition], refs: var OrderedSet[string], imports: var OrderedSet[string]) =
  if refs.contains(name):
    return
  if not definitions.hasKey(name):
    imports.incl(name.modulename)
    return
  let definition = definitions[name]
  if definition.properties.isSome:
    for propertyName, property in definition.properties.get.pairs:
      property.extendedTypeSpec.nimImport(name.modulename,imports)
  elif definition.`type`.isSome:
    definition.extendedTypeSpec.nimImport(name.modulename,imports)
  if definition.`x-kubernetes-group-version-kind`.isSome:
    imports.incl("asyncdispatch")
  for reference in definition.references:
    if reference != name:
      fillReferences(reference,definitions,refs,imports)
  refs.incl(name)



proc generate(self: Module, output: string) =
  let f = open(output & "/" & self.name & ".nim",fmWrite)
  var refs = initOrderedSet[string]()
  var imports = initOrderedSet[string]()
  imports.incl("../client")
  imports.incl("../base_types")
  imports.incl("parsejson")
  imports.incl("../jsonstream")
  for name, definition in self.definitions.pairs:
    fillReferences(name,self.definitions,refs, imports)

  for i in imports:
    f.writeLine("import ",i)

  for definition in refs:
    self.definitions[definition].generate(definition,f)
  f.close()

when isMainModule: 
  proc generate(output: string, kubeconfig: string, inc: string) {.async.} = 
    let client = newClient(kubeconfig)

    let json = await client.openapi()
    let definitions = json["definitions"]
    # writeFile("api.json",pretty(definitions))
    let schema = to(definitions,Definitions)
    let modules = schema.toModules()
    for module in modules:
      if module.name.startsWith(inc):
        module.generate(output)

  proc usage() = 
    echo "Usage: generator --kubeconfig=config --output=dir  --include=startmodule"
    quit(0)

  var p = initOptParser(@[])
  var output = "."
  var kubeconfig = ""
  var inc = ""
  for kind, key, val in p.getopt():
    case kind
    of cmdLongOption, cmdShortOption:
      case key
      of "help", "h": usage()
      of "output" : output = val
      of "kubeconfig" : kubeconfig = val
      of "include" : inc = val
    of cmdEnd: assert(false) # cannot happen
    else: usage()
  waitFor generate(output,kubeconfig,inc)
