import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams

type
  DecoratorController* = distinct Table[string,string]
proc load*(self: var DecoratorController, parser: var JsonParser) =
  load(Table[string,string](self),parser)

type
  CompositeController* = distinct Table[string,string]
proc load*(self: var CompositeController, parser: var JsonParser) =
  load(Table[string,string](self),parser)

type
  CompositeControllerList* = object
    `apiVersion`*: string
    `items`*: seq[CompositeController]
    `kind`*: string
    `metadata`*: Table[string,string]

proc load*(self: var CompositeControllerList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "items":
            load(self.`items`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[CompositeControllerList], name: string, namespace = "default"): Future[CompositeControllerList] {.async.}=
  proc unmarshal(parser: var JsonParser):CompositeControllerList = 
    var ret: CompositeControllerList
    load(ret,parser)
    return ret 
  return await client.get("/apis/metacontroller.k8s.io/v1alpha1",t,name,namespace, unmarshal)

type
  ControllerRevision* = distinct Table[string,string]
proc load*(self: var ControllerRevision, parser: var JsonParser) =
  load(Table[string,string](self),parser)

type
  ControllerRevisionList* = object
    `apiVersion`*: string
    `items`*: seq[ControllerRevision]
    `kind`*: string
    `metadata`*: Table[string,string]

proc load*(self: var ControllerRevisionList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "items":
            load(self.`items`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[ControllerRevisionList], name: string, namespace = "default"): Future[ControllerRevisionList] {.async.}=
  proc unmarshal(parser: var JsonParser):ControllerRevisionList = 
    var ret: ControllerRevisionList
    load(ret,parser)
    return ret 
  return await client.get("/apis/metacontroller.k8s.io/v1alpha1",t,name,namespace, unmarshal)

type
  DecoratorControllerList* = object
    `apiVersion`*: string
    `items`*: seq[DecoratorController]
    `kind`*: string
    `metadata`*: Table[string,string]

proc load*(self: var DecoratorControllerList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "items":
            load(self.`items`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[DecoratorControllerList], name: string, namespace = "default"): Future[DecoratorControllerList] {.async.}=
  proc unmarshal(parser: var JsonParser):DecoratorControllerList = 
    var ret: DecoratorControllerList
    load(ret,parser)
    return ret 
  return await client.get("/apis/metacontroller.k8s.io/v1alpha1",t,name,namespace, unmarshal)
