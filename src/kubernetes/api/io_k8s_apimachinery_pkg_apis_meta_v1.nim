import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams
import io_k8s_apimachinery_pkg_runtime

type
  StatusCause* = object
    `field`*: string
    `message`*: string
    `reason`*: string

proc load*(self: var StatusCause, parser: var JsonParser) =
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
          of "field":
            load(self.`field`,parser)
          of "message":
            load(self.`message`,parser)
          of "reason":
            load(self.`reason`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  StatusDetails* = object
    `uid`*: string
    `retryAfterSeconds`*: int
    `group`*: string
    `causes`*: seq[StatusCause]
    `name`*: string
    `kind`*: string

proc load*(self: var StatusDetails, parser: var JsonParser) =
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
          of "uid":
            load(self.`uid`,parser)
          of "retryAfterSeconds":
            load(self.`retryAfterSeconds`,parser)
          of "group":
            load(self.`group`,parser)
          of "causes":
            load(self.`causes`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Preconditions* = object
    `uid`*: string
    `resourceVersion`*: string

proc load*(self: var Preconditions, parser: var JsonParser) =
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
          of "uid":
            load(self.`uid`,parser)
          of "resourceVersion":
            load(self.`resourceVersion`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Fields* = distinct Table[string,string]
proc load*(self: var Fields, parser: var JsonParser) =
  load(Table[string,string](self),parser)

type
  Time* = distinct DateTime
proc load*(self: var Time, parser: var JsonParser) =
  load(DateTime(self),parser)

type
  ManagedFieldsEntry_v2* = object
    `apiVersion`*: string
    `operation`*: string
    `fields`*: Fields
    `time`*: Time
    `manager`*: string

proc load*(self: var ManagedFieldsEntry_v2, parser: var JsonParser) =
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
          of "operation":
            load(self.`operation`,parser)
          of "fields":
            load(self.`fields`,parser)
          of "time":
            load(self.`time`,parser)
          of "manager":
            load(self.`manager`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Duration* = distinct string
proc load*(self: var Duration, parser: var JsonParser) =
  load(string(self),parser)

type
  Initializer* = object
    `name`*: string

proc load*(self: var Initializer, parser: var JsonParser) =
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
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  StatusDetails_v2* = object
    `uid`*: string
    `retryAfterSeconds`*: int
    `group`*: string
    `causes`*: seq[StatusCause]
    `name`*: string
    `kind`*: string

proc load*(self: var StatusDetails_v2, parser: var JsonParser) =
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
          of "uid":
            load(self.`uid`,parser)
          of "retryAfterSeconds":
            load(self.`retryAfterSeconds`,parser)
          of "group":
            load(self.`group`,parser)
          of "causes":
            load(self.`causes`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ListMeta_v2* = object
    `resourceVersion`*: string
    `selfLink`*: string
    `continue`*: string

proc load*(self: var ListMeta_v2, parser: var JsonParser) =
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
          of "resourceVersion":
            load(self.`resourceVersion`,parser)
          of "selfLink":
            load(self.`selfLink`,parser)
          of "continue":
            load(self.`continue`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Status_v2* = object
    `code`*: int
    `apiVersion`*: string
    `message`*: string
    `details`*: StatusDetails_v2
    `reason`*: string
    `status`*: string
    `kind`*: string
    `metadata`*: ListMeta_v2

proc load*(self: var Status_v2, parser: var JsonParser) =
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
          of "code":
            load(self.`code`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "message":
            load(self.`message`,parser)
          of "details":
            load(self.`details`,parser)
          of "reason":
            load(self.`reason`,parser)
          of "status":
            load(self.`status`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[Status_v2], name: string, namespace = "default"): Future[Status_v2] {.async.}=
  proc unmarshal(parser: var JsonParser):Status_v2 = 
    var ret: Status_v2
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  Initializers* = object
    `pending`*: seq[Initializer]
    `result`*: Status_v2

proc load*(self: var Initializers, parser: var JsonParser) =
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
          of "pending":
            load(self.`pending`,parser)
          of "result":
            load(self.`result`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  APIResource* = object
    `version`*: string
    `singularName`*: string
    `shortNames`*: seq[string]
    `categories`*: seq[string]
    `group`*: string
    `namespaced`*: bool
    `name`*: string
    `verbs`*: seq[string]
    `kind`*: string
    `storageVersionHash`*: string

proc load*(self: var APIResource, parser: var JsonParser) =
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
          of "singularName":
            load(self.`singularName`,parser)
          of "shortNames":
            load(self.`shortNames`,parser)
          of "categories":
            load(self.`categories`,parser)
          of "group":
            load(self.`group`,parser)
          of "namespaced":
            load(self.`namespaced`,parser)
          of "name":
            load(self.`name`,parser)
          of "verbs":
            load(self.`verbs`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "storageVersionHash":
            load(self.`storageVersionHash`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ListMeta* = object
    `remainingItemCount`*: int
    `resourceVersion`*: string
    `selfLink`*: string
    `continue`*: string

proc load*(self: var ListMeta, parser: var JsonParser) =
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
          of "remainingItemCount":
            load(self.`remainingItemCount`,parser)
          of "resourceVersion":
            load(self.`resourceVersion`,parser)
          of "selfLink":
            load(self.`selfLink`,parser)
          of "continue":
            load(self.`continue`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  FieldsV1* = distinct Table[string,string]
proc load*(self: var FieldsV1, parser: var JsonParser) =
  load(Table[string,string](self),parser)

type
  MicroTime* = distinct DateTime
proc load*(self: var MicroTime, parser: var JsonParser) =
  load(DateTime(self),parser)

type
  OwnerReference_v2* = object
    `uid`*: string
    `controller`*: bool
    `apiVersion`*: string
    `blockOwnerDeletion`*: bool
    `name`*: string
    `kind`*: string

proc load*(self: var OwnerReference_v2, parser: var JsonParser) =
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
          of "uid":
            load(self.`uid`,parser)
          of "controller":
            load(self.`controller`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "blockOwnerDeletion":
            load(self.`blockOwnerDeletion`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ObjectMeta_v2* = object
    `uid`*: string
    `generateName`*: string
    `finalizers`*: seq[string]
    `deletionGracePeriodSeconds`*: int
    `creationTimestamp`*: Time
    `annotations`*: Table[string,string]
    `generation`*: int
    `labels`*: Table[string,string]
    `managedFields`*: seq[ManagedFieldsEntry_v2]
    `resourceVersion`*: string
    `selfLink`*: string
    `initializers`*: Initializers
    `clusterName`*: string
    `namespace`*: string
    `ownerReferences`*: seq[OwnerReference_v2]
    `name`*: string
    `deletionTimestamp`*: Time

proc load*(self: var ObjectMeta_v2, parser: var JsonParser) =
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
          of "uid":
            load(self.`uid`,parser)
          of "generateName":
            load(self.`generateName`,parser)
          of "finalizers":
            load(self.`finalizers`,parser)
          of "deletionGracePeriodSeconds":
            load(self.`deletionGracePeriodSeconds`,parser)
          of "creationTimestamp":
            load(self.`creationTimestamp`,parser)
          of "annotations":
            load(self.`annotations`,parser)
          of "generation":
            load(self.`generation`,parser)
          of "labels":
            load(self.`labels`,parser)
          of "managedFields":
            load(self.`managedFields`,parser)
          of "resourceVersion":
            load(self.`resourceVersion`,parser)
          of "selfLink":
            load(self.`selfLink`,parser)
          of "initializers":
            load(self.`initializers`,parser)
          of "clusterName":
            load(self.`clusterName`,parser)
          of "namespace":
            load(self.`namespace`,parser)
          of "ownerReferences":
            load(self.`ownerReferences`,parser)
          of "name":
            load(self.`name`,parser)
          of "deletionTimestamp":
            load(self.`deletionTimestamp`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  OwnerReference* = object
    `uid`*: string
    `controller`*: bool
    `apiVersion`*: string
    `blockOwnerDeletion`*: bool
    `name`*: string
    `kind`*: string

proc load*(self: var OwnerReference, parser: var JsonParser) =
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
          of "uid":
            load(self.`uid`,parser)
          of "controller":
            load(self.`controller`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "blockOwnerDeletion":
            load(self.`blockOwnerDeletion`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  APIResourceList* = object
    `apiVersion`*: string
    `groupVersion`*: string
    `resources`*: seq[APIResource]
    `kind`*: string

proc load*(self: var APIResourceList, parser: var JsonParser) =
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
          of "groupVersion":
            load(self.`groupVersion`,parser)
          of "resources":
            load(self.`resources`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[APIResourceList], name: string, namespace = "default"): Future[APIResourceList] {.async.}=
  proc unmarshal(parser: var JsonParser):APIResourceList = 
    var ret: APIResourceList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ServerAddressByClientCIDR* = object
    `serverAddress`*: string
    `clientCIDR`*: string

proc load*(self: var ServerAddressByClientCIDR, parser: var JsonParser) =
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
          of "serverAddress":
            load(self.`serverAddress`,parser)
          of "clientCIDR":
            load(self.`clientCIDR`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  GroupVersionForDiscovery* = object
    `version`*: string
    `groupVersion`*: string

proc load*(self: var GroupVersionForDiscovery, parser: var JsonParser) =
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
          of "groupVersion":
            load(self.`groupVersion`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  APIGroup* = object
    `apiVersion`*: string
    `serverAddressByClientCIDRs`*: seq[ServerAddressByClientCIDR]
    `versions`*: seq[GroupVersionForDiscovery]
    `name`*: string
    `kind`*: string
    `preferredVersion`*: GroupVersionForDiscovery

proc load*(self: var APIGroup, parser: var JsonParser) =
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
          of "serverAddressByClientCIDRs":
            load(self.`serverAddressByClientCIDRs`,parser)
          of "versions":
            load(self.`versions`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "preferredVersion":
            load(self.`preferredVersion`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[APIGroup], name: string, namespace = "default"): Future[APIGroup] {.async.}=
  proc unmarshal(parser: var JsonParser):APIGroup = 
    var ret: APIGroup
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  APIGroupList* = object
    `apiVersion`*: string
    `groups`*: seq[APIGroup]
    `kind`*: string

proc load*(self: var APIGroupList, parser: var JsonParser) =
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
          of "groups":
            load(self.`groups`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[APIGroupList], name: string, namespace = "default"): Future[APIGroupList] {.async.}=
  proc unmarshal(parser: var JsonParser):APIGroupList = 
    var ret: APIGroupList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  WatchEvent* = object
    `type`*: string
    `object`*: io_k8s_apimachinery_pkg_runtime.RawExtension

proc load*(self: var WatchEvent, parser: var JsonParser) =
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
          of "type":
            load(self.`type`,parser)
          of "object":
            load(self.`object`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[WatchEvent], name: string, namespace = "default"): Future[WatchEvent] {.async.}=
  proc unmarshal(parser: var JsonParser):WatchEvent = 
    var ret: WatchEvent
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  LabelSelectorRequirement* = object
    `key`*: string
    `values`*: seq[string]
    `operator`*: string

proc load*(self: var LabelSelectorRequirement, parser: var JsonParser) =
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
          of "key":
            load(self.`key`,parser)
          of "values":
            load(self.`values`,parser)
          of "operator":
            load(self.`operator`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  LabelSelector* = object
    `matchLabels`*: Table[string,string]
    `matchExpressions`*: seq[LabelSelectorRequirement]

proc load*(self: var LabelSelector, parser: var JsonParser) =
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
          of "matchLabels":
            load(self.`matchLabels`,parser)
          of "matchExpressions":
            load(self.`matchExpressions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  APIResourceList_v2* = object
    `apiVersion`*: string
    `groupVersion`*: string
    `resources`*: seq[APIResource]
    `kind`*: string

proc load*(self: var APIResourceList_v2, parser: var JsonParser) =
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
          of "groupVersion":
            load(self.`groupVersion`,parser)
          of "resources":
            load(self.`resources`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[APIResourceList_v2], name: string, namespace = "default"): Future[APIResourceList_v2] {.async.}=
  proc unmarshal(parser: var JsonParser):APIResourceList_v2 = 
    var ret: APIResourceList_v2
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  APIVersions* = object
    `apiVersion`*: string
    `serverAddressByClientCIDRs`*: seq[ServerAddressByClientCIDR]
    `versions`*: seq[string]
    `kind`*: string

proc load*(self: var APIVersions, parser: var JsonParser) =
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
          of "serverAddressByClientCIDRs":
            load(self.`serverAddressByClientCIDRs`,parser)
          of "versions":
            load(self.`versions`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[APIVersions], name: string, namespace = "default"): Future[APIVersions] {.async.}=
  proc unmarshal(parser: var JsonParser):APIVersions = 
    var ret: APIVersions
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  Patch* = distinct Table[string,string]
proc load*(self: var Patch, parser: var JsonParser) =
  load(Table[string,string](self),parser)

type
  APIGroup_v2* = object
    `apiVersion`*: string
    `serverAddressByClientCIDRs`*: seq[ServerAddressByClientCIDR]
    `versions`*: seq[GroupVersionForDiscovery]
    `name`*: string
    `kind`*: string
    `preferredVersion`*: GroupVersionForDiscovery

proc load*(self: var APIGroup_v2, parser: var JsonParser) =
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
          of "serverAddressByClientCIDRs":
            load(self.`serverAddressByClientCIDRs`,parser)
          of "versions":
            load(self.`versions`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "preferredVersion":
            load(self.`preferredVersion`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[APIGroup_v2], name: string, namespace = "default"): Future[APIGroup_v2] {.async.}=
  proc unmarshal(parser: var JsonParser):APIGroup_v2 = 
    var ret: APIGroup_v2
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ManagedFieldsEntry* = object
    `fieldsType`*: string
    `apiVersion`*: string
    `operation`*: string
    `fieldsV1`*: FieldsV1
    `time`*: Time
    `manager`*: string

proc load*(self: var ManagedFieldsEntry, parser: var JsonParser) =
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
          of "fieldsType":
            load(self.`fieldsType`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "operation":
            load(self.`operation`,parser)
          of "fieldsV1":
            load(self.`fieldsV1`,parser)
          of "time":
            load(self.`time`,parser)
          of "manager":
            load(self.`manager`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  DeleteOptions* = object
    `orphanDependents`*: bool
    `apiVersion`*: string
    `propagationPolicy`*: string
    `gracePeriodSeconds`*: int
    `dryRun`*: seq[string]
    `kind`*: string
    `preconditions`*: Preconditions

proc load*(self: var DeleteOptions, parser: var JsonParser) =
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
          of "orphanDependents":
            load(self.`orphanDependents`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "propagationPolicy":
            load(self.`propagationPolicy`,parser)
          of "gracePeriodSeconds":
            load(self.`gracePeriodSeconds`,parser)
          of "dryRun":
            load(self.`dryRun`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "preconditions":
            load(self.`preconditions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[DeleteOptions], name: string, namespace = "default"): Future[DeleteOptions] {.async.}=
  proc unmarshal(parser: var JsonParser):DeleteOptions = 
    var ret: DeleteOptions
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ObjectMeta* = object
    `uid`*: string
    `generateName`*: string
    `finalizers`*: seq[string]
    `deletionGracePeriodSeconds`*: int
    `creationTimestamp`*: Time
    `annotations`*: Table[string,string]
    `generation`*: int
    `labels`*: Table[string,string]
    `managedFields`*: seq[ManagedFieldsEntry]
    `resourceVersion`*: string
    `selfLink`*: string
    `clusterName`*: string
    `namespace`*: string
    `ownerReferences`*: seq[OwnerReference]
    `name`*: string
    `deletionTimestamp`*: Time

proc load*(self: var ObjectMeta, parser: var JsonParser) =
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
          of "uid":
            load(self.`uid`,parser)
          of "generateName":
            load(self.`generateName`,parser)
          of "finalizers":
            load(self.`finalizers`,parser)
          of "deletionGracePeriodSeconds":
            load(self.`deletionGracePeriodSeconds`,parser)
          of "creationTimestamp":
            load(self.`creationTimestamp`,parser)
          of "annotations":
            load(self.`annotations`,parser)
          of "generation":
            load(self.`generation`,parser)
          of "labels":
            load(self.`labels`,parser)
          of "managedFields":
            load(self.`managedFields`,parser)
          of "resourceVersion":
            load(self.`resourceVersion`,parser)
          of "selfLink":
            load(self.`selfLink`,parser)
          of "clusterName":
            load(self.`clusterName`,parser)
          of "namespace":
            load(self.`namespace`,parser)
          of "ownerReferences":
            load(self.`ownerReferences`,parser)
          of "name":
            load(self.`name`,parser)
          of "deletionTimestamp":
            load(self.`deletionTimestamp`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Status* = object
    `code`*: int
    `apiVersion`*: string
    `message`*: string
    `details`*: StatusDetails
    `reason`*: string
    `status`*: string
    `kind`*: string
    `metadata`*: ListMeta

proc load*(self: var Status, parser: var JsonParser) =
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
          of "code":
            load(self.`code`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "message":
            load(self.`message`,parser)
          of "details":
            load(self.`details`,parser)
          of "reason":
            load(self.`reason`,parser)
          of "status":
            load(self.`status`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[Status], name: string, namespace = "default"): Future[Status] {.async.}=
  proc unmarshal(parser: var JsonParser):Status = 
    var ret: Status
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)
