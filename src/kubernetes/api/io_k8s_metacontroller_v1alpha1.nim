import ../client
import ../base_types
import parsejson
import streams
import tables
import asyncdispatch

type
  DecoratorController* = distinct Table[string,string]

proc load*(self: var DecoratorController, parser: var JsonParser) =
  load(Table[string,string](self),parser)

proc dump*(self: DecoratorController, s: Stream) =
  dump(Table[string,string](self),s)

proc isEmpty*(self: DecoratorController): bool = Table[string,string](self).isEmpty

type
  CompositeController* = distinct Table[string,string]

proc load*(self: var CompositeController, parser: var JsonParser) =
  load(Table[string,string](self),parser)

proc dump*(self: CompositeController, s: Stream) =
  dump(Table[string,string](self),s)

proc isEmpty*(self: CompositeController): bool = Table[string,string](self).isEmpty

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

proc dump*(self: CompositeControllerList, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: CompositeControllerList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadCompositeControllerList(parser: var JsonParser):CompositeControllerList = 
  var ret: CompositeControllerList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[CompositeController], namespace = "default"): Future[seq[CompositeController]] {.async.}=
  return (await client.list("/apis/metacontroller.k8s.io/v1alpha1",CompositeControllerList,namespace, loadCompositeControllerList)).items

type
  ControllerRevision* = distinct Table[string,string]

proc load*(self: var ControllerRevision, parser: var JsonParser) =
  load(Table[string,string](self),parser)

proc dump*(self: ControllerRevision, s: Stream) =
  dump(Table[string,string](self),s)

proc isEmpty*(self: ControllerRevision): bool = Table[string,string](self).isEmpty

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

proc dump*(self: ControllerRevisionList, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: ControllerRevisionList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadControllerRevisionList(parser: var JsonParser):ControllerRevisionList = 
  var ret: ControllerRevisionList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[ControllerRevision], namespace = "default"): Future[seq[ControllerRevision]] {.async.}=
  return (await client.list("/apis/metacontroller.k8s.io/v1alpha1",ControllerRevisionList,namespace, loadControllerRevisionList)).items

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

proc dump*(self: DecoratorControllerList, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: DecoratorControllerList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadDecoratorControllerList(parser: var JsonParser):DecoratorControllerList = 
  var ret: DecoratorControllerList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[DecoratorController], namespace = "default"): Future[seq[DecoratorController]] {.async.}=
  return (await client.list("/apis/metacontroller.k8s.io/v1alpha1",DecoratorControllerList,namespace, loadDecoratorControllerList)).items
