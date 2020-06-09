import asyncdispatch
import client
import json
import tables
import options
import sets
import strutils
import sequtils
import strformat

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

  IndentFile = ref object 
    f: File
    indent: int

proc writeLine(self: IndentFile, str: string) =
  self.f.writeLine(str.indent(self.indent))

proc sub(self: IndentFile, indent: int): IndentFile =
  result = IndentFile(f:self.f,indent: self.indent + indent)

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

proc nimType(`type`: Option[string], `$ref`: Option[string], items: Option[TypeSpec], additionalProperties: Option[TypeSpec], format: Option[string], modulename: string): string =
  if `type`.isSome:
    case `type`.get:
      of "string":
        if format.isSome:
          case format.get:
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
        if items.isSome:
          let items = items.get()
          subtype = nimType(items.`type`,items.`$ref`,none(TypeSpec),none(TypeSpec),items.format,modulename)
        return ("seq[" & subtype & "]")
      of "object":
        var subtype = "string"
        if additionalProperties.isSome:
          let items = additionalProperties.get()
          subtype = nimType(items.`type`,items.`$ref`,none(TypeSpec),none(TypeSpec),items.format,modulename)
        return ("Table[string," & subtype & "]")
  elif `$ref`.isSome:
    let refname = `$ref`.get.split("/")[^1]
    if refname.modulename == modulename:
      return refname.typename
    else:
      return refname.modulename & "." & refname.typename
  else:
    return "string"

proc nimLoad(name: string,`type`: Option[string], `$ref`: Option[string], items: Option[TypeSpec], additionalProperties: Option[TypeSpec], format: Option[string], modulename: string, f: IndentFile) =
  if `type`.isSome:
    case `type`.get:
      of "string":
        f.writeLine(fmt"load({name},parser)")
      of "integer":
        f.writeLine(fmt"load({name},parser)")
      of "float":
        f.writeLine(fmt"load({name},parser)")
      of "boolean":
        f.writeLine(fmt"load({name},parser)")
      of "array":
        f.writeLine(fmt"load({name},parser)")
      of "object":
        f.writeLine(fmt"load({name},parser)")
  elif `$ref`.isSome:
    f.writeLine(fmt"load({name},parser)")
  else:
    f.writeLine(fmt"load({name},parser)")

proc generate(definition: Definition, name: string, f: File) =
  let required = definition.required.get(@[]).toOrderedSet
  f.writeLine("")
  f.writeLine("type")
  if definition.properties.isSome:
    f.writeLine("  ", name.typename, "* = object")
    for propertyName, property in definition.properties.get.pairs:
      var t = nimType(property.`type`,property.`$ref`,property.items,property.additionalProperties,property.format,name.modulename)
      f.writeLine("    `",propertyName,"`*: ", t)
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

    if definition.`x-kubernetes-group-version-kind`.isSome:
      let groupVersionKind = definition.`x-kubernetes-group-version-kind`.get[0]
      var groupVersion: string
      if groupVersionKind.group == "": 
        groupVersion = "/api/" & groupVersionKind.version
      else:
        groupVersion =  "/apis/" & groupVersionKind.group & "/" & groupVersionKind.version
      f.writeLine("")
      f.writeLine("proc get*(client: Client, t: typedesc[", name.typename, "], name: string, namespace = \"default\"): Future[", name.typename, "] {.async.}=")
      f.writeLine("  proc unmarshal(parser: var JsonParser):", name.typename," = ")
      f.writeLine("    var ret: ", name.typename, "")
      f.writeLine("    load(ret,parser)")
      f.writeLine("    return ret ")
      f.writeLine("  return await client.get(\"" & groupVersion & "\",t,name,namespace, unmarshal)")
  else:
    if name.typename == "IntOrString":
      f.writeLine("  ", name.typename, "* = distinct base_types.IntOrString")
      f.writeLine("proc load*(self: var ", name.typename, ", parser: var JsonParser) =")
      f.writeLine("  load(base_types.IntOrString(self),parser)")
    else:
      let subtype = nimType(definition.`type`,none(string),none(TypeSpec),none(TypeSpec),definition.format,name.modulename)
      f.writeLine("  ", name.typename, "* = distinct ",subtype)
      f.writeLine("proc load*(self: var ", name.typename, ", parser: var JsonParser) =")
      f.writeLine(fmt"  load({subtype}(self),parser)")




proc fillReferences(name: string, definitions: Table[string,Definition], refs: var OrderedSet[string], imports: var OrderedSet[string]) =
  if refs.contains(name):
    return
  if not definitions.hasKey(name):
    imports.incl(name.modulename)
    return
  let definition = definitions[name]
  for reference in definition.references:
    if reference != name:
      fillReferences(reference,definitions,refs,imports)
  refs.incl(name)



proc generate(self: Module) =
  let f = open("test/" & self.name & ".nim",fmWrite)
  var refs = initOrderedSet[string]()
  var imports = initOrderedSet[string]()
  for name, definition in self.definitions.pairs:
    fillReferences(name,self.definitions,refs, imports)

  f.writeLine("import ../src/kubernetes/client, ../src/kubernetes/base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams")
  for i in imports:
    f.writeLine("import ",i)

  for definition in refs:
    self.definitions[definition].generate(definition,f)
  f.close()

when isMainModule: 
  proc generate() {.async.} = 
    let client = newClient()

    let json = await client.openapi()
    let definitions = json["definitions"]
    writeFile("api.json",pretty(definitions))
    let schema = to(definitions,Definitions)
    let modules = schema.toModules()
    for module in modules:
      module.generate()

  waitFor generate()
