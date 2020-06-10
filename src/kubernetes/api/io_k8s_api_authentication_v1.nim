import ../client
import ../base_types
import parsejson
import streams
import tables
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch

type
  UserInfo* = object
    `uid`*: string
    `username`*: string
    `groups`*: seq[string]
    `extra`*: Table[string,seq[string]]

proc load*(self: var UserInfo, parser: var JsonParser) =
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
          of "username":
            load(self.`username`,parser)
          of "groups":
            load(self.`groups`,parser)
          of "extra":
            load(self.`extra`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: UserInfo, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`uid`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"uid\":")
    self.`uid`.dump(s)
  if not self.`username`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"username\":")
    self.`username`.dump(s)
  if not self.`groups`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"groups\":")
    self.`groups`.dump(s)
  if not self.`extra`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"extra\":")
    self.`extra`.dump(s)
  s.write("}")

proc isEmpty*(self: UserInfo): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`username`.isEmpty: return false
  if not self.`groups`.isEmpty: return false
  if not self.`extra`.isEmpty: return false
  true

type
  TokenReviewSpec* = object
    `token`*: string
    `audiences`*: seq[string]

proc load*(self: var TokenReviewSpec, parser: var JsonParser) =
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
          of "token":
            load(self.`token`,parser)
          of "audiences":
            load(self.`audiences`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: TokenReviewSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`token`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"token\":")
    self.`token`.dump(s)
  if not self.`audiences`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"audiences\":")
    self.`audiences`.dump(s)
  s.write("}")

proc isEmpty*(self: TokenReviewSpec): bool =
  if not self.`token`.isEmpty: return false
  if not self.`audiences`.isEmpty: return false
  true

type
  TokenReviewStatus* = object
    `user`*: UserInfo
    `error`*: string
    `authenticated`*: bool
    `audiences`*: seq[string]

proc load*(self: var TokenReviewStatus, parser: var JsonParser) =
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
          of "user":
            load(self.`user`,parser)
          of "error":
            load(self.`error`,parser)
          of "authenticated":
            load(self.`authenticated`,parser)
          of "audiences":
            load(self.`audiences`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: TokenReviewStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`user`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"user\":")
    self.`user`.dump(s)
  if not self.`error`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"error\":")
    self.`error`.dump(s)
  if not self.`authenticated`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"authenticated\":")
    self.`authenticated`.dump(s)
  if not self.`audiences`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"audiences\":")
    self.`audiences`.dump(s)
  s.write("}")

proc isEmpty*(self: TokenReviewStatus): bool =
  if not self.`user`.isEmpty: return false
  if not self.`error`.isEmpty: return false
  if not self.`authenticated`.isEmpty: return false
  if not self.`audiences`.isEmpty: return false
  true

type
  TokenReview* = object
    `apiVersion`*: string
    `spec`*: TokenReviewSpec
    `status`*: TokenReviewStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var TokenReview, parser: var JsonParser) =
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

proc dump*(self: TokenReview, s: Stream) =
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

proc isEmpty*(self: TokenReview): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadTokenReview(parser: var JsonParser):TokenReview = 
  var ret: TokenReview
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[TokenReview], name: string, namespace = "default"): Future[TokenReview] {.async.}=
  return await client.get("/apis/authentication.k8s.io/v1",t,name,namespace, loadTokenReview)

type
  BoundObjectReference* = object
    `uid`*: string
    `apiVersion`*: string
    `name`*: string
    `kind`*: string

proc load*(self: var BoundObjectReference, parser: var JsonParser) =
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
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: BoundObjectReference, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`uid`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"uid\":")
    self.`uid`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
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

proc isEmpty*(self: BoundObjectReference): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

type
  TokenRequestSpec* = object
    `expirationSeconds`*: int
    `boundObjectRef`*: BoundObjectReference
    `audiences`*: seq[string]

proc load*(self: var TokenRequestSpec, parser: var JsonParser) =
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
          of "expirationSeconds":
            load(self.`expirationSeconds`,parser)
          of "boundObjectRef":
            load(self.`boundObjectRef`,parser)
          of "audiences":
            load(self.`audiences`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: TokenRequestSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`expirationSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"expirationSeconds\":")
    self.`expirationSeconds`.dump(s)
  if not self.`boundObjectRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"boundObjectRef\":")
    self.`boundObjectRef`.dump(s)
  if not self.`audiences`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"audiences\":")
    self.`audiences`.dump(s)
  s.write("}")

proc isEmpty*(self: TokenRequestSpec): bool =
  if not self.`expirationSeconds`.isEmpty: return false
  if not self.`boundObjectRef`.isEmpty: return false
  if not self.`audiences`.isEmpty: return false
  true

type
  TokenRequestStatus* = object
    `token`*: string
    `expirationTimestamp`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time

proc load*(self: var TokenRequestStatus, parser: var JsonParser) =
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
          of "token":
            load(self.`token`,parser)
          of "expirationTimestamp":
            load(self.`expirationTimestamp`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: TokenRequestStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`token`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"token\":")
    self.`token`.dump(s)
  if not self.`expirationTimestamp`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"expirationTimestamp\":")
    self.`expirationTimestamp`.dump(s)
  s.write("}")

proc isEmpty*(self: TokenRequestStatus): bool =
  if not self.`token`.isEmpty: return false
  if not self.`expirationTimestamp`.isEmpty: return false
  true

type
  TokenRequest* = object
    `apiVersion`*: string
    `spec`*: TokenRequestSpec
    `status`*: TokenRequestStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var TokenRequest, parser: var JsonParser) =
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

proc dump*(self: TokenRequest, s: Stream) =
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

proc isEmpty*(self: TokenRequest): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadTokenRequest(parser: var JsonParser):TokenRequest = 
  var ret: TokenRequest
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[TokenRequest], name: string, namespace = "default"): Future[TokenRequest] {.async.}=
  return await client.get("/apis/authentication.k8s.io/v1",t,name,namespace, loadTokenRequest)
