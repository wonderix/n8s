import ../client
import ../base_types
import parsejson
import streams
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch

type
  PriorityClass* = object
    `globalDefault`*: bool
    `apiVersion`*: string
    `description`*: string
    `value`*: int
    `preemptionPolicy`*: string
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var PriorityClass, parser: var JsonParser) =
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
          of "globalDefault":
            load(self.`globalDefault`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "description":
            load(self.`description`,parser)
          of "value":
            load(self.`value`,parser)
          of "preemptionPolicy":
            load(self.`preemptionPolicy`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: PriorityClass, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`globalDefault`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"globalDefault\":")
    self.`globalDefault`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`description`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"description\":")
    self.`description`.dump(s)
  if not self.`value`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"value\":")
    self.`value`.dump(s)
  if not self.`preemptionPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"preemptionPolicy\":")
    self.`preemptionPolicy`.dump(s)
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

proc isEmpty*(self: PriorityClass): bool =
  if not self.`globalDefault`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`description`.isEmpty: return false
  if not self.`value`.isEmpty: return false
  if not self.`preemptionPolicy`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPriorityClass(parser: var JsonParser):PriorityClass = 
  var ret: PriorityClass
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[PriorityClass], name: string, namespace = "default"): Future[PriorityClass] {.async.}=
  return await client.get("/apis/scheduling.k8s.io/v1beta1",t,name,namespace, loadPriorityClass)

type
  PriorityClassList* = object
    `apiVersion`*: string
    `items`*: seq[PriorityClass]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var PriorityClassList, parser: var JsonParser) =
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

proc dump*(self: PriorityClassList, s: Stream) =
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

proc isEmpty*(self: PriorityClassList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPriorityClassList(parser: var JsonParser):PriorityClassList = 
  var ret: PriorityClassList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[PriorityClass], namespace = "default"): Future[seq[PriorityClass]] {.async.}=
  return (await client.list("/apis/scheduling.k8s.io/v1beta1",PriorityClassList,namespace, loadPriorityClassList)).items
