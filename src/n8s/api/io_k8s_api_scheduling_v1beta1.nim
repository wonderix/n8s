import ../client
import ../base_types
import parsejson
import ../jsonwriter
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

proc dump*(self: PriorityClass, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("scheduling.k8s.io/v1beta1")
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


proc get*(client: Client, t: typedesc[PriorityClass], name: string, namespace = "default"): Future[PriorityClass] {.async.}=
  return await client.get("/apis/scheduling.k8s.io/v1beta1", t, name, namespace)

proc create*(client: Client, t: PriorityClass, namespace = "default"): Future[PriorityClass] {.async.}=
  return await client.create("/apis/scheduling.k8s.io/v1beta1", t, namespace)

proc delete*(client: Client, t: typedesc[PriorityClass], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/scheduling.k8s.io/v1beta1", t, name, namespace)

proc replace*(client: Client, t: PriorityClass, namespace = "default"): Future[PriorityClass] {.async.}=
  return await client.replace("/apis/scheduling.k8s.io/v1beta1", t, t.metadata.name, namespace)

proc watch*(client: Client, t: typedesc[PriorityClass], name: string, namespace = "default"): Future[FutureStream[WatchEv[PriorityClass]]] {.async.}=
  return await client.watch("/apis/scheduling.k8s.io/v1beta1", t, name, namespace)

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

proc dump*(self: PriorityClassList, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("scheduling.k8s.io/v1beta1")
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


proc list*(client: Client, t: typedesc[PriorityClass], namespace = "default"): Future[seq[PriorityClass]] {.async.}=
  return (await client.list("/apis/scheduling.k8s.io/v1beta1", PriorityClassList, namespace)).items
