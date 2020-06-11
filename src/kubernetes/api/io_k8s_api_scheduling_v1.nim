import ../client
import ../base_types
import parsejson
import ../jsonstream
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

proc dump*(self: PriorityClass, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("scheduling.k8s.io/v1")
  s.name("kind"); s.value("PriorityClass")
  if not self.`globalDefault`.isEmpty:
    s.name("globalDefault")
    self.`globalDefault`.dump(s)
  if not self.`description`.isEmpty:
    s.name("description")
    self.`description`.dump(s)
  s.name("value")
  self.`value`.dump(s)
  if not self.`preemptionPolicy`.isEmpty:
    s.name("preemptionPolicy")
    self.`preemptionPolicy`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

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
  return await client.get("/apis/scheduling.k8s.io/v1", t, name, namespace, loadPriorityClass)

proc create*(client: Client, t: PriorityClass, namespace = "default"): Future[PriorityClass] {.async.}=
  return await client.create("/apis/scheduling.k8s.io/v1", t, namespace, loadPriorityClass)

proc delete*(client: Client, t: typedesc[PriorityClass], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/scheduling.k8s.io/v1", t, name, namespace)

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

proc dump*(self: PriorityClassList, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("scheduling.k8s.io/v1")
  s.name("kind"); s.value("PriorityClassList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

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
  return (await client.list("/apis/scheduling.k8s.io/v1", PriorityClassList, namespace, loadPriorityClassList)).items
