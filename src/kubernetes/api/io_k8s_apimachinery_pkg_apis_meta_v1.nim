import ../client
import ../base_types
import parsejson
import streams
import tables
import times
import asyncdispatch
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

proc dump*(self: StatusCause, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`field`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"field\":")
    self.`field`.dump(s)
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
  s.write("}")

proc isEmpty*(self: StatusCause): bool =
  if not self.`field`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  true

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

proc dump*(self: StatusDetails, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`uid`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"uid\":")
    self.`uid`.dump(s)
  if not self.`retryAfterSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"retryAfterSeconds\":")
    self.`retryAfterSeconds`.dump(s)
  if not self.`group`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"group\":")
    self.`group`.dump(s)
  if not self.`causes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"causes\":")
    self.`causes`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  s.write("}")

proc isEmpty*(self: StatusDetails): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`retryAfterSeconds`.isEmpty: return false
  if not self.`group`.isEmpty: return false
  if not self.`causes`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

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

proc dump*(self: Preconditions, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`uid`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"uid\":")
    self.`uid`.dump(s)
  if not self.`resourceVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resourceVersion\":")
    self.`resourceVersion`.dump(s)
  s.write("}")

proc isEmpty*(self: Preconditions): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`resourceVersion`.isEmpty: return false
  true

type
  Fields* = distinct Table[string,string]

proc load*(self: var Fields, parser: var JsonParser) =
  load(Table[string,string](self),parser)

proc dump*(self: Fields, s: Stream) =
  dump(Table[string,string](self),s)

proc isEmpty*(self: Fields): bool = Table[string,string](self).isEmpty

type
  Time* = distinct DateTime

proc load*(self: var Time, parser: var JsonParser) =
  load(DateTime(self),parser)

proc dump*(self: Time, s: Stream) =
  dump(DateTime(self),s)

proc isEmpty*(self: Time): bool = DateTime(self).isEmpty

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

proc dump*(self: ManagedFieldsEntry_v2, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`operation`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"operation\":")
    self.`operation`.dump(s)
  if not self.`fields`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fields\":")
    self.`fields`.dump(s)
  if not self.`time`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"time\":")
    self.`time`.dump(s)
  if not self.`manager`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"manager\":")
    self.`manager`.dump(s)
  s.write("}")

proc isEmpty*(self: ManagedFieldsEntry_v2): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`operation`.isEmpty: return false
  if not self.`fields`.isEmpty: return false
  if not self.`time`.isEmpty: return false
  if not self.`manager`.isEmpty: return false
  true

type
  Duration* = distinct string

proc load*(self: var Duration, parser: var JsonParser) =
  load(string(self),parser)

proc dump*(self: Duration, s: Stream) =
  dump(string(self),s)

proc isEmpty*(self: Duration): bool = string(self).isEmpty

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

proc dump*(self: Initializer, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: Initializer): bool =
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: StatusDetails_v2, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`uid`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"uid\":")
    self.`uid`.dump(s)
  if not self.`retryAfterSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"retryAfterSeconds\":")
    self.`retryAfterSeconds`.dump(s)
  if not self.`group`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"group\":")
    self.`group`.dump(s)
  if not self.`causes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"causes\":")
    self.`causes`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  s.write("}")

proc isEmpty*(self: StatusDetails_v2): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`retryAfterSeconds`.isEmpty: return false
  if not self.`group`.isEmpty: return false
  if not self.`causes`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

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

proc dump*(self: ListMeta_v2, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`resourceVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resourceVersion\":")
    self.`resourceVersion`.dump(s)
  if not self.`selfLink`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selfLink\":")
    self.`selfLink`.dump(s)
  if not self.`continue`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"continue\":")
    self.`continue`.dump(s)
  s.write("}")

proc isEmpty*(self: ListMeta_v2): bool =
  if not self.`resourceVersion`.isEmpty: return false
  if not self.`selfLink`.isEmpty: return false
  if not self.`continue`.isEmpty: return false
  true

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

proc dump*(self: Status_v2, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`code`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"code\":")
    self.`code`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`message`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"message\":")
    self.`message`.dump(s)
  if not self.`details`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"details\":")
    self.`details`.dump(s)
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

proc isEmpty*(self: Status_v2): bool =
  if not self.`code`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`details`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadStatus_v2(parser: var JsonParser):Status_v2 = 
  var ret: Status_v2
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Status_v2], name: string, namespace = "default"): Future[Status_v2] {.async.}=
  return await client.get("/api/v1",t,name,namespace, loadStatus_v2)

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

proc dump*(self: Initializers, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`pending`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"pending\":")
    self.`pending`.dump(s)
  if not self.`result`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"result\":")
    self.`result`.dump(s)
  s.write("}")

proc isEmpty*(self: Initializers): bool =
  if not self.`pending`.isEmpty: return false
  if not self.`result`.isEmpty: return false
  true

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

proc dump*(self: APIResource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`version`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"version\":")
    self.`version`.dump(s)
  if not self.`singularName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"singularName\":")
    self.`singularName`.dump(s)
  if not self.`shortNames`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"shortNames\":")
    self.`shortNames`.dump(s)
  if not self.`categories`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"categories\":")
    self.`categories`.dump(s)
  if not self.`group`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"group\":")
    self.`group`.dump(s)
  if not self.`namespaced`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespaced\":")
    self.`namespaced`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`verbs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"verbs\":")
    self.`verbs`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`storageVersionHash`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"storageVersionHash\":")
    self.`storageVersionHash`.dump(s)
  s.write("}")

proc isEmpty*(self: APIResource): bool =
  if not self.`version`.isEmpty: return false
  if not self.`singularName`.isEmpty: return false
  if not self.`shortNames`.isEmpty: return false
  if not self.`categories`.isEmpty: return false
  if not self.`group`.isEmpty: return false
  if not self.`namespaced`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`verbs`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`storageVersionHash`.isEmpty: return false
  true

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

proc dump*(self: ListMeta, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`remainingItemCount`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"remainingItemCount\":")
    self.`remainingItemCount`.dump(s)
  if not self.`resourceVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resourceVersion\":")
    self.`resourceVersion`.dump(s)
  if not self.`selfLink`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selfLink\":")
    self.`selfLink`.dump(s)
  if not self.`continue`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"continue\":")
    self.`continue`.dump(s)
  s.write("}")

proc isEmpty*(self: ListMeta): bool =
  if not self.`remainingItemCount`.isEmpty: return false
  if not self.`resourceVersion`.isEmpty: return false
  if not self.`selfLink`.isEmpty: return false
  if not self.`continue`.isEmpty: return false
  true

type
  FieldsV1* = distinct Table[string,string]

proc load*(self: var FieldsV1, parser: var JsonParser) =
  load(Table[string,string](self),parser)

proc dump*(self: FieldsV1, s: Stream) =
  dump(Table[string,string](self),s)

proc isEmpty*(self: FieldsV1): bool = Table[string,string](self).isEmpty

type
  MicroTime* = distinct DateTime

proc load*(self: var MicroTime, parser: var JsonParser) =
  load(DateTime(self),parser)

proc dump*(self: MicroTime, s: Stream) =
  dump(DateTime(self),s)

proc isEmpty*(self: MicroTime): bool = DateTime(self).isEmpty

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

proc dump*(self: OwnerReference_v2, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`uid`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"uid\":")
    self.`uid`.dump(s)
  if not self.`controller`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"controller\":")
    self.`controller`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`blockOwnerDeletion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"blockOwnerDeletion\":")
    self.`blockOwnerDeletion`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  s.write("}")

proc isEmpty*(self: OwnerReference_v2): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`controller`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`blockOwnerDeletion`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

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

proc dump*(self: ObjectMeta_v2, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`uid`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"uid\":")
    self.`uid`.dump(s)
  if not self.`generateName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"generateName\":")
    self.`generateName`.dump(s)
  if not self.`finalizers`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"finalizers\":")
    self.`finalizers`.dump(s)
  if not self.`deletionGracePeriodSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"deletionGracePeriodSeconds\":")
    self.`deletionGracePeriodSeconds`.dump(s)
  if not self.`creationTimestamp`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"creationTimestamp\":")
    self.`creationTimestamp`.dump(s)
  if not self.`annotations`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"annotations\":")
    self.`annotations`.dump(s)
  if not self.`generation`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"generation\":")
    self.`generation`.dump(s)
  if not self.`labels`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"labels\":")
    self.`labels`.dump(s)
  if not self.`managedFields`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"managedFields\":")
    self.`managedFields`.dump(s)
  if not self.`resourceVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resourceVersion\":")
    self.`resourceVersion`.dump(s)
  if not self.`selfLink`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selfLink\":")
    self.`selfLink`.dump(s)
  if not self.`initializers`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"initializers\":")
    self.`initializers`.dump(s)
  if not self.`clusterName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"clusterName\":")
    self.`clusterName`.dump(s)
  if not self.`namespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespace\":")
    self.`namespace`.dump(s)
  if not self.`ownerReferences`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ownerReferences\":")
    self.`ownerReferences`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`deletionTimestamp`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"deletionTimestamp\":")
    self.`deletionTimestamp`.dump(s)
  s.write("}")

proc isEmpty*(self: ObjectMeta_v2): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`generateName`.isEmpty: return false
  if not self.`finalizers`.isEmpty: return false
  if not self.`deletionGracePeriodSeconds`.isEmpty: return false
  if not self.`creationTimestamp`.isEmpty: return false
  if not self.`annotations`.isEmpty: return false
  if not self.`generation`.isEmpty: return false
  if not self.`labels`.isEmpty: return false
  if not self.`managedFields`.isEmpty: return false
  if not self.`resourceVersion`.isEmpty: return false
  if not self.`selfLink`.isEmpty: return false
  if not self.`initializers`.isEmpty: return false
  if not self.`clusterName`.isEmpty: return false
  if not self.`namespace`.isEmpty: return false
  if not self.`ownerReferences`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`deletionTimestamp`.isEmpty: return false
  true

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

proc dump*(self: OwnerReference, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`uid`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"uid\":")
    self.`uid`.dump(s)
  if not self.`controller`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"controller\":")
    self.`controller`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`blockOwnerDeletion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"blockOwnerDeletion\":")
    self.`blockOwnerDeletion`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  s.write("}")

proc isEmpty*(self: OwnerReference): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`controller`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`blockOwnerDeletion`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

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

proc dump*(self: APIResourceList, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`groupVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"groupVersion\":")
    self.`groupVersion`.dump(s)
  if not self.`resources`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resources\":")
    self.`resources`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  s.write("}")

proc isEmpty*(self: APIResourceList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`groupVersion`.isEmpty: return false
  if not self.`resources`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

proc loadAPIResourceList(parser: var JsonParser):APIResourceList = 
  var ret: APIResourceList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[APIResource], namespace = "default"): Future[seq[APIResource]] {.async.}=
  return (await client.list("/api/v1",APIResourceList,namespace, loadAPIResourceList)).items

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

proc dump*(self: ServerAddressByClientCIDR, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`serverAddress`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"serverAddress\":")
    self.`serverAddress`.dump(s)
  if not self.`clientCIDR`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"clientCIDR\":")
    self.`clientCIDR`.dump(s)
  s.write("}")

proc isEmpty*(self: ServerAddressByClientCIDR): bool =
  if not self.`serverAddress`.isEmpty: return false
  if not self.`clientCIDR`.isEmpty: return false
  true

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

proc dump*(self: GroupVersionForDiscovery, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`version`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"version\":")
    self.`version`.dump(s)
  if not self.`groupVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"groupVersion\":")
    self.`groupVersion`.dump(s)
  s.write("}")

proc isEmpty*(self: GroupVersionForDiscovery): bool =
  if not self.`version`.isEmpty: return false
  if not self.`groupVersion`.isEmpty: return false
  true

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

proc dump*(self: APIGroup, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`serverAddressByClientCIDRs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"serverAddressByClientCIDRs\":")
    self.`serverAddressByClientCIDRs`.dump(s)
  if not self.`versions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"versions\":")
    self.`versions`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`preferredVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"preferredVersion\":")
    self.`preferredVersion`.dump(s)
  s.write("}")

proc isEmpty*(self: APIGroup): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`serverAddressByClientCIDRs`.isEmpty: return false
  if not self.`versions`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`preferredVersion`.isEmpty: return false
  true

proc loadAPIGroup(parser: var JsonParser):APIGroup = 
  var ret: APIGroup
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[APIGroup], name: string, namespace = "default"): Future[APIGroup] {.async.}=
  return await client.get("/api/v1",t,name,namespace, loadAPIGroup)

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

proc dump*(self: APIGroupList, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`groups`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"groups\":")
    self.`groups`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  s.write("}")

proc isEmpty*(self: APIGroupList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`groups`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

proc loadAPIGroupList(parser: var JsonParser):APIGroupList = 
  var ret: APIGroupList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[APIGroup], namespace = "default"): Future[seq[APIGroup]] {.async.}=
  return (await client.list("/api/v1",APIGroupList,namespace, loadAPIGroupList)).items

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

proc dump*(self: WatchEvent, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`object`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"object\":")
    self.`object`.dump(s)
  s.write("}")

proc isEmpty*(self: WatchEvent): bool =
  if not self.`type`.isEmpty: return false
  if not self.`object`.isEmpty: return false
  true

proc loadWatchEvent(parser: var JsonParser):WatchEvent = 
  var ret: WatchEvent
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[WatchEvent], name: string, namespace = "default"): Future[WatchEvent] {.async.}=
  return await client.get("/api/v1",t,name,namespace, loadWatchEvent)

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

proc dump*(self: LabelSelectorRequirement, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`key`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"key\":")
    self.`key`.dump(s)
  if not self.`values`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"values\":")
    self.`values`.dump(s)
  if not self.`operator`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"operator\":")
    self.`operator`.dump(s)
  s.write("}")

proc isEmpty*(self: LabelSelectorRequirement): bool =
  if not self.`key`.isEmpty: return false
  if not self.`values`.isEmpty: return false
  if not self.`operator`.isEmpty: return false
  true

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

proc dump*(self: LabelSelector, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`matchLabels`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"matchLabels\":")
    self.`matchLabels`.dump(s)
  if not self.`matchExpressions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"matchExpressions\":")
    self.`matchExpressions`.dump(s)
  s.write("}")

proc isEmpty*(self: LabelSelector): bool =
  if not self.`matchLabels`.isEmpty: return false
  if not self.`matchExpressions`.isEmpty: return false
  true

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

proc dump*(self: APIResourceList_v2, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`groupVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"groupVersion\":")
    self.`groupVersion`.dump(s)
  if not self.`resources`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resources\":")
    self.`resources`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  s.write("}")

proc isEmpty*(self: APIResourceList_v2): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`groupVersion`.isEmpty: return false
  if not self.`resources`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

proc loadAPIResourceList_v2(parser: var JsonParser):APIResourceList_v2 = 
  var ret: APIResourceList_v2
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[APIResourceList_v2], name: string, namespace = "default"): Future[APIResourceList_v2] {.async.}=
  return await client.get("/api/v1",t,name,namespace, loadAPIResourceList_v2)

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

proc dump*(self: APIVersions, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`serverAddressByClientCIDRs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"serverAddressByClientCIDRs\":")
    self.`serverAddressByClientCIDRs`.dump(s)
  if not self.`versions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"versions\":")
    self.`versions`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  s.write("}")

proc isEmpty*(self: APIVersions): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`serverAddressByClientCIDRs`.isEmpty: return false
  if not self.`versions`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

proc loadAPIVersions(parser: var JsonParser):APIVersions = 
  var ret: APIVersions
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[APIVersions], name: string, namespace = "default"): Future[APIVersions] {.async.}=
  return await client.get("/api/v1",t,name,namespace, loadAPIVersions)

type
  Patch* = distinct Table[string,string]

proc load*(self: var Patch, parser: var JsonParser) =
  load(Table[string,string](self),parser)

proc dump*(self: Patch, s: Stream) =
  dump(Table[string,string](self),s)

proc isEmpty*(self: Patch): bool = Table[string,string](self).isEmpty

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

proc dump*(self: APIGroup_v2, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`serverAddressByClientCIDRs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"serverAddressByClientCIDRs\":")
    self.`serverAddressByClientCIDRs`.dump(s)
  if not self.`versions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"versions\":")
    self.`versions`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`preferredVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"preferredVersion\":")
    self.`preferredVersion`.dump(s)
  s.write("}")

proc isEmpty*(self: APIGroup_v2): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`serverAddressByClientCIDRs`.isEmpty: return false
  if not self.`versions`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`preferredVersion`.isEmpty: return false
  true

proc loadAPIGroup_v2(parser: var JsonParser):APIGroup_v2 = 
  var ret: APIGroup_v2
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[APIGroup_v2], name: string, namespace = "default"): Future[APIGroup_v2] {.async.}=
  return await client.get("/api/v1",t,name,namespace, loadAPIGroup_v2)

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

proc dump*(self: ManagedFieldsEntry, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`fieldsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fieldsType\":")
    self.`fieldsType`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`operation`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"operation\":")
    self.`operation`.dump(s)
  if not self.`fieldsV1`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fieldsV1\":")
    self.`fieldsV1`.dump(s)
  if not self.`time`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"time\":")
    self.`time`.dump(s)
  if not self.`manager`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"manager\":")
    self.`manager`.dump(s)
  s.write("}")

proc isEmpty*(self: ManagedFieldsEntry): bool =
  if not self.`fieldsType`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`operation`.isEmpty: return false
  if not self.`fieldsV1`.isEmpty: return false
  if not self.`time`.isEmpty: return false
  if not self.`manager`.isEmpty: return false
  true

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

proc dump*(self: DeleteOptions, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`orphanDependents`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"orphanDependents\":")
    self.`orphanDependents`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`propagationPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"propagationPolicy\":")
    self.`propagationPolicy`.dump(s)
  if not self.`gracePeriodSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"gracePeriodSeconds\":")
    self.`gracePeriodSeconds`.dump(s)
  if not self.`dryRun`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"dryRun\":")
    self.`dryRun`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`preconditions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"preconditions\":")
    self.`preconditions`.dump(s)
  s.write("}")

proc isEmpty*(self: DeleteOptions): bool =
  if not self.`orphanDependents`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`propagationPolicy`.isEmpty: return false
  if not self.`gracePeriodSeconds`.isEmpty: return false
  if not self.`dryRun`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`preconditions`.isEmpty: return false
  true

proc loadDeleteOptions(parser: var JsonParser):DeleteOptions = 
  var ret: DeleteOptions
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[DeleteOptions], name: string, namespace = "default"): Future[DeleteOptions] {.async.}=
  return await client.get("/api/v1",t,name,namespace, loadDeleteOptions)

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

proc dump*(self: ObjectMeta, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`uid`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"uid\":")
    self.`uid`.dump(s)
  if not self.`generateName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"generateName\":")
    self.`generateName`.dump(s)
  if not self.`finalizers`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"finalizers\":")
    self.`finalizers`.dump(s)
  if not self.`deletionGracePeriodSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"deletionGracePeriodSeconds\":")
    self.`deletionGracePeriodSeconds`.dump(s)
  if not self.`creationTimestamp`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"creationTimestamp\":")
    self.`creationTimestamp`.dump(s)
  if not self.`annotations`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"annotations\":")
    self.`annotations`.dump(s)
  if not self.`generation`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"generation\":")
    self.`generation`.dump(s)
  if not self.`labels`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"labels\":")
    self.`labels`.dump(s)
  if not self.`managedFields`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"managedFields\":")
    self.`managedFields`.dump(s)
  if not self.`resourceVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resourceVersion\":")
    self.`resourceVersion`.dump(s)
  if not self.`selfLink`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selfLink\":")
    self.`selfLink`.dump(s)
  if not self.`clusterName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"clusterName\":")
    self.`clusterName`.dump(s)
  if not self.`namespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespace\":")
    self.`namespace`.dump(s)
  if not self.`ownerReferences`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ownerReferences\":")
    self.`ownerReferences`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`deletionTimestamp`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"deletionTimestamp\":")
    self.`deletionTimestamp`.dump(s)
  s.write("}")

proc isEmpty*(self: ObjectMeta): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`generateName`.isEmpty: return false
  if not self.`finalizers`.isEmpty: return false
  if not self.`deletionGracePeriodSeconds`.isEmpty: return false
  if not self.`creationTimestamp`.isEmpty: return false
  if not self.`annotations`.isEmpty: return false
  if not self.`generation`.isEmpty: return false
  if not self.`labels`.isEmpty: return false
  if not self.`managedFields`.isEmpty: return false
  if not self.`resourceVersion`.isEmpty: return false
  if not self.`selfLink`.isEmpty: return false
  if not self.`clusterName`.isEmpty: return false
  if not self.`namespace`.isEmpty: return false
  if not self.`ownerReferences`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`deletionTimestamp`.isEmpty: return false
  true

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

proc dump*(self: Status, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`code`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"code\":")
    self.`code`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`message`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"message\":")
    self.`message`.dump(s)
  if not self.`details`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"details\":")
    self.`details`.dump(s)
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

proc isEmpty*(self: Status): bool =
  if not self.`code`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`details`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadStatus(parser: var JsonParser):Status = 
  var ret: Status
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Status], name: string, namespace = "default"): Future[Status] {.async.}=
  return await client.get("/api/v1",t,name,namespace, loadStatus)
