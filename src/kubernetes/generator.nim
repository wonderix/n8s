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
        if format.isSome:
          case format.get:
            of "date-time":
              f.writeLine(fmt"load({name},parser)")
            of "email":
              f.writeLine(fmt"{name} = parser.str")
              f.writeLine("parser.next")
            of "hostname":
              f.writeLine(fmt"{name} = parser.str")
              f.writeLine("parser.next")
            of "ipv4":
              f.writeLine(fmt"{name} = parser.str")
              f.writeLine("parser.next")
            of "ipv6":
              f.writeLine(fmt"{name} = parser.str")
              f.writeLine("parser.next")
            of "uri":
              f.writeLine(fmt"{name} = parser.str")
              f.writeLine("parser.next")
            of "byte":
              f.writeLine(fmt"load({name},parser)")
            else:
              f.writeLine(fmt"{name} = parser.str")
              f.writeLine("parser.next")
        else:
              f.writeLine(fmt"{name} = parser.str")
              f.writeLine("parser.next")
      of "integer":
        f.writeLine(fmt"{name} = int(parser.getInt)")
        f.writeLine("parser.next")
      of "float":
        f.writeLine(fmt"{name} = parser.getFloat")
        f.writeLine("parser.next")
      of "boolean":
        f.writeLine(fmt"{name} = parser.kind == jsonTrue")
        f.writeLine("parser.next")
      of "array":
        f.writeLine("if parser.kind != jsonArrayStart: raiseParseErr(parser,\"array start\")")
        f.writeLine("parser.next")
        f.writeLine("while true:")
        f.writeLine("  case parser.kind:")
        f.writeLine("    of jsonArrayEnd:")
        f.writeLine("      parser.next")
        f.writeLine("      break")
        f.writeLine("    else:")
        let sub = f.sub(6)
        if items.isSome:
          let items = items.get()
          sub.writeLine("var item: " & nimType(items.`type`,items.`$ref`,none(TypeSpec),none(TypeSpec),none(string),modulename))
          nimLoad("item",items.`type`,items.`$ref`,none(TypeSpec),none(TypeSpec),items.format,modulename,sub)
        else:
          sub.writeLine("let item=parser.str")
        sub.writeLine(&"{name}.add(item)")
      of "object":
        f.writeLine("if parser.kind != jsonObjectStart: raiseParseErr(parser,\"object start\")")
        f.writeLine("block load:")
        f.writeLine("  parser.next")
        f.writeLine("  while true:")
        f.writeLine("    case parser.kind:")
        f.writeLine("      of jsonObjectEnd:")
        f.writeLine("        parser.next")
        f.writeLine("        break load")
        f.writeLine("      of jsonString:")
        f.writeLine("        let key = parser.str")
        f.writeLine("        parser.next")
        let sub = f.sub(8)
        if additionalProperties.isSome:
          let items = additionalProperties.get()
          nimLoad(&"{name}[key]",items.`type`,items.`$ref`,none(TypeSpec),none(TypeSpec),items.format,modulename,sub)
        else:
          sub.writeLine(&"{name}[key] = parser.str")
        f.writeLine("      else: raiseParseErr(parser,\"string not \" & $(parser.kind))")
  elif `$ref`.isSome:
    f.writeLine(fmt"load({name},parser)")
  else:
    f.writeLine(fmt"{name} = parser.str")

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
      nimLoad(&"self.`{propertyName}`",property.`type`,property.`$ref`,property.items,property.additionalProperties,property.format,name.modulename,IndentFile(f:f,indent:12))
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
      f.writeLine("  var ret: ", name.typename)
      f.writeLine("  var parser: JsonParser")
      f.writeLine("  parser.open(await client.get(\"" & groupVersion & "\",($t).toLowerAscii() & \"s\",name,namespace),\"http\")")
      f.writeLine("  parser.next")
      f.writeLine("  load(ret, parser)")
      f.writeLine("  parser.close")
      f.writeLine("  return ret")
  else:
    if name.typename == "IntOrString":
      f.writeLine("  ", name.typename, "* = distinct base_types.IntOrString")
      f.writeLine("proc load*(self: var ", name.typename, ", parser: var JsonParser) =")
      f.writeLine("  load(base_types.IntOrString(self),parser)")
    else:
      let subtype = nimType(definition.`type`,none(string),none(TypeSpec),none(TypeSpec),definition.format,name.modulename)
      f.writeLine("  ", name.typename, "* = distinct ",subtype)
      f.writeLine("proc load*(self: var ", name.typename, ", parser: var JsonParser) =")
      nimLoad(&"{subtype}(self)", definition.`type`,none(string),none(TypeSpec),none(TypeSpec),definition.format,name.modulename,IndentFile(f:f,indent:2))



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
