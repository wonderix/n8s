import ../client
import ../base_types
import parsejson
import ../jsonstream
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

proc dump*(self: ServiceReference, s: JsonStream) =
  s.objectStart()
  if not self.`namespace`.isEmpty:
    s.name("namespace")
    self.`namespace`.dump(s)
  if not self.`port`.isEmpty:
    s.name("port")
    self.`port`.dump(s)
  if not self.`name`.isEmpty:
    s.name("name")
    self.`name`.dump(s)
  s.objectEnd()

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

proc dump*(self: APIServiceSpec, s: JsonStream) =
  s.objectStart()
  if not self.`version`.isEmpty:
    s.name("version")
    self.`version`.dump(s)
  if not self.`caBundle`.isEmpty:
    s.name("caBundle")
    self.`caBundle`.dump(s)
  if not self.`group`.isEmpty:
    s.name("group")
    self.`group`.dump(s)
  s.name("groupPriorityMinimum")
  self.`groupPriorityMinimum`.dump(s)
  s.name("versionPriority")
  self.`versionPriority`.dump(s)
  s.name("service")
  self.`service`.dump(s)
  if not self.`insecureSkipTLSVerify`.isEmpty:
    s.name("insecureSkipTLSVerify")
    self.`insecureSkipTLSVerify`.dump(s)
  s.objectEnd()

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

proc dump*(self: APIServiceCondition, s: JsonStream) =
  s.objectStart()
  if not self.`lastTransitionTime`.isEmpty:
    s.name("lastTransitionTime")
    self.`lastTransitionTime`.dump(s)
  s.name("type")
  self.`type`.dump(s)
  if not self.`message`.isEmpty:
    s.name("message")
    self.`message`.dump(s)
  if not self.`reason`.isEmpty:
    s.name("reason")
    self.`reason`.dump(s)
  s.name("status")
  self.`status`.dump(s)
  s.objectEnd()

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

proc dump*(self: APIServiceStatus, s: JsonStream) =
  s.objectStart()
  if not self.`conditions`.isEmpty:
    s.name("conditions")
    self.`conditions`.dump(s)
  s.objectEnd()

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

proc dump*(self: APIService, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("apiregistration.k8s.io/v1")
  s.name("kind"); s.value("APIService")
  if not self.`spec`.isEmpty:
    s.name("spec")
    self.`spec`.dump(s)
  if not self.`status`.isEmpty:
    s.name("status")
    self.`status`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

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
  return await client.get("/apis/apiregistration.k8s.io/v1", t, name, namespace, loadAPIService)

proc create*(client: Client, t: APIService, namespace = "default"): Future[APIService] {.async.}=
  return await client.create("/apis/apiregistration.k8s.io/v1", t, namespace, loadAPIService)

proc delete*(client: Client, t: typedesc[APIService], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/apiregistration.k8s.io/v1", t, name, namespace)

proc replace*(client: Client, t: APIService, namespace = "default"): Future[APIService] {.async.}=
  return await client.replace("/apis/apiregistration.k8s.io/v1", t, t.metadata.name, namespace, loadAPIService)

proc watch*(client: Client, t: typedesc[APIService], name: string, namespace = "default"): Future[FutureStream[APIService]] {.async.}=
  return await client.watch("/apis/apiregistration.k8s.io/v1", t, name, namespace, loadAPIService)

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

proc dump*(self: APIServiceList, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("apiregistration.k8s.io/v1")
  s.name("kind"); s.value("APIServiceList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

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
  return (await client.list("/apis/apiregistration.k8s.io/v1", APIServiceList, namespace, loadAPIServiceList)).items
