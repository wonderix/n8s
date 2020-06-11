import ../client
import ../base_types
import parsejson
import ../jsonstream
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch
import io_k8s_api_core_v1

type
  EventSeries* = object
    `count`*: int
    `lastObservedTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.MicroTime
    `state`*: string

proc load*(self: var EventSeries, parser: var JsonParser) =
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
          of "count":
            load(self.`count`,parser)
          of "lastObservedTime":
            load(self.`lastObservedTime`,parser)
          of "state":
            load(self.`state`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: EventSeries, s: JsonStream) =
  s.objectStart()
  s.name("count")
  self.`count`.dump(s)
  s.name("lastObservedTime")
  self.`lastObservedTime`.dump(s)
  s.name("state")
  self.`state`.dump(s)
  s.objectEnd()

proc isEmpty*(self: EventSeries): bool =
  if not self.`count`.isEmpty: return false
  if not self.`lastObservedTime`.isEmpty: return false
  if not self.`state`.isEmpty: return false
  true

type
  Event* = object
    `deprecatedLastTimestamp`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `apiVersion`*: string
    `deprecatedFirstTimestamp`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `reportingInstance`*: string
    `type`*: string
    `eventTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.MicroTime
    `series`*: EventSeries
    `deprecatedCount`*: int
    `note`*: string
    `action`*: string
    `deprecatedSource`*: io_k8s_api_core_v1.EventSource
    `regarding`*: io_k8s_api_core_v1.ObjectReference
    `reportingController`*: string
    `reason`*: string
    `kind`*: string
    `related`*: io_k8s_api_core_v1.ObjectReference
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Event, parser: var JsonParser) =
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
          of "deprecatedLastTimestamp":
            load(self.`deprecatedLastTimestamp`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "deprecatedFirstTimestamp":
            load(self.`deprecatedFirstTimestamp`,parser)
          of "reportingInstance":
            load(self.`reportingInstance`,parser)
          of "type":
            load(self.`type`,parser)
          of "eventTime":
            load(self.`eventTime`,parser)
          of "series":
            load(self.`series`,parser)
          of "deprecatedCount":
            load(self.`deprecatedCount`,parser)
          of "note":
            load(self.`note`,parser)
          of "action":
            load(self.`action`,parser)
          of "deprecatedSource":
            load(self.`deprecatedSource`,parser)
          of "regarding":
            load(self.`regarding`,parser)
          of "reportingController":
            load(self.`reportingController`,parser)
          of "reason":
            load(self.`reason`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "related":
            load(self.`related`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: Event, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("events.k8s.io/v1beta1")
  s.name("kind"); s.value("Event")
  if not self.`deprecatedLastTimestamp`.isEmpty:
    s.name("deprecatedLastTimestamp")
    self.`deprecatedLastTimestamp`.dump(s)
  if not self.`deprecatedFirstTimestamp`.isEmpty:
    s.name("deprecatedFirstTimestamp")
    self.`deprecatedFirstTimestamp`.dump(s)
  if not self.`reportingInstance`.isEmpty:
    s.name("reportingInstance")
    self.`reportingInstance`.dump(s)
  if not self.`type`.isEmpty:
    s.name("type")
    self.`type`.dump(s)
  s.name("eventTime")
  self.`eventTime`.dump(s)
  if not self.`series`.isEmpty:
    s.name("series")
    self.`series`.dump(s)
  if not self.`deprecatedCount`.isEmpty:
    s.name("deprecatedCount")
    self.`deprecatedCount`.dump(s)
  if not self.`note`.isEmpty:
    s.name("note")
    self.`note`.dump(s)
  if not self.`action`.isEmpty:
    s.name("action")
    self.`action`.dump(s)
  if not self.`deprecatedSource`.isEmpty:
    s.name("deprecatedSource")
    self.`deprecatedSource`.dump(s)
  if not self.`regarding`.isEmpty:
    s.name("regarding")
    self.`regarding`.dump(s)
  if not self.`reportingController`.isEmpty:
    s.name("reportingController")
    self.`reportingController`.dump(s)
  if not self.`reason`.isEmpty:
    s.name("reason")
    self.`reason`.dump(s)
  if not self.`related`.isEmpty:
    s.name("related")
    self.`related`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: Event): bool =
  if not self.`deprecatedLastTimestamp`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`deprecatedFirstTimestamp`.isEmpty: return false
  if not self.`reportingInstance`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`eventTime`.isEmpty: return false
  if not self.`series`.isEmpty: return false
  if not self.`deprecatedCount`.isEmpty: return false
  if not self.`note`.isEmpty: return false
  if not self.`action`.isEmpty: return false
  if not self.`deprecatedSource`.isEmpty: return false
  if not self.`regarding`.isEmpty: return false
  if not self.`reportingController`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`related`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadEvent(parser: var JsonParser):Event = 
  var ret: Event
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Event], name: string, namespace = "default"): Future[Event] {.async.}=
  return await client.get("/apis/events.k8s.io/v1beta1", t, name, namespace, loadEvent)

proc create*(client: Client, t: Event, namespace = "default"): Future[Event] {.async.}=
  return await client.create("/apis/events.k8s.io/v1beta1", t, namespace, loadEvent)

proc delete*(client: Client, t: typedesc[Event], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/events.k8s.io/v1beta1", t, name, namespace)

type
  EventList* = object
    `apiVersion`*: string
    `items`*: seq[Event]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var EventList, parser: var JsonParser) =
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

proc dump*(self: EventList, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("events.k8s.io/v1beta1")
  s.name("kind"); s.value("EventList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: EventList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadEventList(parser: var JsonParser):EventList = 
  var ret: EventList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[Event], namespace = "default"): Future[seq[Event]] {.async.}=
  return (await client.list("/apis/events.k8s.io/v1beta1", EventList, namespace, loadEventList)).items
