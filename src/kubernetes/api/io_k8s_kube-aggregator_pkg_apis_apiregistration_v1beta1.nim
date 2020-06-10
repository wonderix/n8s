import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams
import io_k8s_apimachinery_pkg_apis_meta_v1

type
  ServiceReference* = object
    `namespace`*: string
    `port`*: int
    `name`*: string

proc load*(self: var ServiceReference, parser: var JsonParser) =
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
          of "namespace":
            load(self.`namespace`,parser)
          of "port":
            load(self.`port`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  APIServiceSpec* = object
    `version`*: string
    `caBundle`*: ByteArray
    `group`*: string
    `groupPriorityMinimum`*: int
    `versionPriority`*: int
    `service`*: ServiceReference
    `insecureSkipTLSVerify`*: bool

proc load*(self: var APIServiceSpec, parser: var JsonParser) =
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
          of "version":
            load(self.`version`,parser)
          of "caBundle":
            load(self.`caBundle`,parser)
          of "group":
            load(self.`group`,parser)
          of "groupPriorityMinimum":
            load(self.`groupPriorityMinimum`,parser)
          of "versionPriority":
            load(self.`versionPriority`,parser)
          of "service":
            load(self.`service`,parser)
          of "insecureSkipTLSVerify":
            load(self.`insecureSkipTLSVerify`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  APIServiceCondition* = object
    `lastTransitionTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `type`*: string
    `message`*: string
    `reason`*: string
    `status`*: string

proc load*(self: var APIServiceCondition, parser: var JsonParser) =
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
          of "lastTransitionTime":
            load(self.`lastTransitionTime`,parser)
          of "type":
            load(self.`type`,parser)
          of "message":
            load(self.`message`,parser)
          of "reason":
            load(self.`reason`,parser)
          of "status":
            load(self.`status`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  APIServiceStatus* = object
    `conditions`*: seq[APIServiceCondition]

proc load*(self: var APIServiceStatus, parser: var JsonParser) =
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
          of "conditions":
            load(self.`conditions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  APIService* = object
    `apiVersion`*: string
    `spec`*: APIServiceSpec
    `status`*: APIServiceStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var APIService, parser: var JsonParser) =
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
          of "spec":
            load(self.`spec`,parser)
          of "status":
            load(self.`status`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[APIService], name: string, namespace = "default"): Future[APIService] {.async.}=
  proc unmarshal(parser: var JsonParser):APIService = 
    var ret: APIService
    load(ret,parser)
    return ret 
  return await client.get("/apis/apiregistration.k8s.io/v1beta1",t,name,namespace, unmarshal)

type
  APIServiceList* = object
    `apiVersion`*: string
    `items`*: seq[APIService]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var APIServiceList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[APIServiceList], name: string, namespace = "default"): Future[APIServiceList] {.async.}=
  proc unmarshal(parser: var JsonParser):APIServiceList = 
    var ret: APIServiceList
    load(ret,parser)
    return ret 
  return await client.get("/apis/apiregistration.k8s.io/v1beta1",t,name,namespace, unmarshal)
