import ../client
import ../base_types
import parsejson
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

proc get*(client: Client, t: typedesc[Event], name: string, namespace = "default"): Future[Event] {.async.}=
  proc unmarshal(parser: var JsonParser):Event = 
    var ret: Event
    load(ret,parser)
    return ret 
  return await client.get("/apis/events.k8s.io/v1beta1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[EventList], name: string, namespace = "default"): Future[EventList] {.async.}=
  proc unmarshal(parser: var JsonParser):EventList = 
    var ret: EventList
    load(ret,parser)
    return ret 
  return await client.get("/apis/events.k8s.io/v1beta1",t,name,namespace, unmarshal)
