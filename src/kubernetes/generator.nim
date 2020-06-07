import asyncdispatch
import client
import json
import tables
import options
import sets
import strutils
import sequtils

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

proc nimType(`type`: Option[string], `$ref`: Option[string], items: Option[TypeSpec], format: Option[string], modulename: string): string =
  if `type`.isSome:
    case `type`.get:
      of "string":
        if format.isSome:
          case format.get:
            of "date-time":
              return "string"
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
        return "string"
      of "integer":
        return "int"
      of "boolean":
        return "bool"
      of "array":
        let items = items.get()
        let subtype = nimType(items.`type`,items.`$ref`,none(TypeSpec),none(string),modulename)
        return ("seq[" & subtype & "]")
      of "object":
        var subtype = "string"
        if items.isSome:
          let items = items.get()
          subtype = nimType(items.`type`,items.`$ref`,none(TypeSpec),items.format,modulename)
        return ("Table[string," & subtype & "]")
  elif `$ref`.isSome:
    let refname = `$ref`.get.split("/")[^1]
    if refname.modulename == modulename:
      return refname.typename
    else:
      return refname.modulename & "." & refname.typename
  else:
    return "string"
  
proc generate(definition: Definition, name: string, f: File) =
  let required = definition.required.get(@[]).toOrderedSet
  f.writeLine("")
  f.writeLine("type")
  if definition.properties.isSome:
    f.writeLine("  ", name.typename, "* = object")
    for propertyName, property in definition.properties.get.pairs:
      var t = nimType(property.`type`,property.`$ref`,property.items,property.format,name.modulename)
      if not required.contains(propertyName):
        t = "Option[" & t & "]"
      f.writeLine("    `",propertyName,"`*: ", t)
    if definition.`x-kubernetes-group-version-kind`.isSome:
      let groupVersionKind = definition.`x-kubernetes-group-version-kind`.get[0]
      var groupVersion: string
      if groupVersionKind.group == "": 
        groupVersion = "/api/" & groupVersionKind.version
      else:
        groupVersion =  "/apis/" & groupVersionKind.group & "/" & groupVersionKind.version
      f.writeLine("")
      f.writeLine("proc get*(client: Client, t: typedesc[", name.typename, "], name: string, namespace = \"default\"): Future[", name.typename, "] {.async.}=")
      f.writeLine("  return to(await client.get(\"" & groupVersion & "\",($t).toLowerAscii() & \"s\",name,namespace),", name.typename, ")")
  else:
    if name.typename == "IntOrString":
      f.writeLine("  ", name.typename, "* = int")
    else:
      f.writeLine("  ", name.typename, "* = distinct ",nimType(definition.`type`,none(string),none(TypeSpec),definition.format,name.modulename))



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

  f.writeLine("import ../src/kubernetes/client, sets, tables, options, times, asyncdispatch, json, strutils")
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
    # writeFile("api.json",pretty(definitions))
    let schema = to(definitions,Definitions)
    let modules = schema.toModules()
    for module in modules:
      module.generate()

  waitFor generate()
