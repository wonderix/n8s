import ../client
import ../base_types
import parsejson
import streams
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch

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

proc dump*(self: ServiceReference, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`namespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespace\":")
    self.`namespace`.dump(s)
  if not self.`port`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"port\":")
    self.`port`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: ServiceReference): bool =
  if not self.`namespace`.isEmpty: return false
  if not self.`port`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: APIServiceSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`version`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"version\":")
    self.`version`.dump(s)
  if not self.`caBundle`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"caBundle\":")
    self.`caBundle`.dump(s)
  if not self.`group`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"group\":")
    self.`group`.dump(s)
  if not self.`groupPriorityMinimum`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"groupPriorityMinimum\":")
    self.`groupPriorityMinimum`.dump(s)
  if not self.`versionPriority`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"versionPriority\":")
    self.`versionPriority`.dump(s)
  if not self.`service`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"service\":")
    self.`service`.dump(s)
  if not self.`insecureSkipTLSVerify`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"insecureSkipTLSVerify\":")
    self.`insecureSkipTLSVerify`.dump(s)
  s.write("}")

proc isEmpty*(self: APIServiceSpec): bool =
  if not self.`version`.isEmpty: return false
  if not self.`caBundle`.isEmpty: return false
  if not self.`group`.isEmpty: return false
  if not self.`groupPriorityMinimum`.isEmpty: return false
  if not self.`versionPriority`.isEmpty: return false
  if not self.`service`.isEmpty: return false
  if not self.`insecureSkipTLSVerify`.isEmpty: return false
  true

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

proc dump*(self: APIServiceCondition, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`lastTransitionTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastTransitionTime\":")
    self.`lastTransitionTime`.dump(s)
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`message`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"message\":")
    self.`message`.dump(s)
  if not self.`reason`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"reason\":")
    self.`reason`.dump(s)
  if not self.`status`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"status\":")
    self.`status`.dump(s)
  s.write("}")

proc isEmpty*(self: APIServiceCondition): bool =
  if not self.`lastTransitionTime`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

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

proc dump*(self: APIServiceStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`conditions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conditions\":")
    self.`conditions`.dump(s)
  s.write("}")

proc isEmpty*(self: APIServiceStatus): bool =
  if not self.`conditions`.isEmpty: return false
  true

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

proc dump*(self: APIService, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`spec`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"spec\":")
    self.`spec`.dump(s)
  if not self.`status`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"status\":")
    self.`status`.dump(s)
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

proc isEmpty*(self: APIService): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadAPIService(parser: var JsonParser):APIService = 
  var ret: APIService
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[APIService], name: string, namespace = "default"): Future[APIService] {.async.}=
  return await client.get("/apis/apiregistration.k8s.io/v1beta1",t,name,namespace, loadAPIService)

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

proc dump*(self: APIServiceList, s: Stream) =
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

proc isEmpty*(self: APIServiceList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadAPIServiceList(parser: var JsonParser):APIServiceList = 
  var ret: APIServiceList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[APIService], namespace = "default"): Future[seq[APIService]] {.async.}=
  return (await client.list("/apis/apiregistration.k8s.io/v1beta1",APIServiceList,namespace, loadAPIServiceList)).items
