import ../client
import ../base_types
import parsejson
import ../jsonwriter
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

proc dump*(self: UserInfo, s: JsonWriter) =
  s.objectStart()
  if not self.`uid`.isEmpty:
    s.name("uid")
    self.`uid`.dump(s)
  if not self.`username`.isEmpty:
    s.name("username")
    self.`username`.dump(s)
  if not self.`groups`.isEmpty:
    s.name("groups")
    self.`groups`.dump(s)
  if not self.`extra`.isEmpty:
    s.name("extra")
    self.`extra`.dump(s)
  s.objectEnd()

proc isEmpty*(self: UserInfo): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`username`.isEmpty: return false
  if not self.`groups`.isEmpty: return false
  if not self.`extra`.isEmpty: return false
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

proc dump*(self: TokenReviewStatus, s: JsonWriter) =
  s.objectStart()
  if not self.`user`.isEmpty:
    s.name("user")
    self.`user`.dump(s)
  if not self.`error`.isEmpty:
    s.name("error")
    self.`error`.dump(s)
  if not self.`authenticated`.isEmpty:
    s.name("authenticated")
    self.`authenticated`.dump(s)
  if not self.`audiences`.isEmpty:
    s.name("audiences")
    self.`audiences`.dump(s)
  s.objectEnd()

proc isEmpty*(self: TokenReviewStatus): bool =
  if not self.`user`.isEmpty: return false
  if not self.`error`.isEmpty: return false
  if not self.`authenticated`.isEmpty: return false
  if not self.`audiences`.isEmpty: return false
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

proc dump*(self: TokenReviewSpec, s: JsonWriter) =
  s.objectStart()
  if not self.`token`.isEmpty:
    s.name("token")
    self.`token`.dump(s)
  if not self.`audiences`.isEmpty:
    s.name("audiences")
    self.`audiences`.dump(s)
  s.objectEnd()

proc isEmpty*(self: TokenReviewSpec): bool =
  if not self.`token`.isEmpty: return false
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

proc dump*(self: TokenReview, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("authentication.k8s.io/v1beta1")
  s.name("kind"); s.value("TokenReview")
  s.name("spec")
  self.`spec`.dump(s)
  if not self.`status`.isEmpty:
    s.name("status")
    self.`status`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: TokenReview): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[TokenReview], name: string, namespace = "default"): Future[TokenReview] {.async.}=
  return await client.get("/apis/authentication.k8s.io/v1beta1", t, name, namespace)

proc create*(client: Client, t: TokenReview, namespace = "default"): Future[TokenReview] {.async.}=
  return await client.create("/apis/authentication.k8s.io/v1beta1", t, namespace)

proc delete*(client: Client, t: typedesc[TokenReview], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/authentication.k8s.io/v1beta1", t, name, namespace)

proc replace*(client: Client, t: TokenReview, namespace = "default"): Future[TokenReview] {.async.}=
  return await client.replace("/apis/authentication.k8s.io/v1beta1", t, t.metadata.name, namespace)

proc watch*(client: Client, t: typedesc[TokenReview], name: string, namespace = "default"): Future[FutureStream[WatchEv[TokenReview]]] {.async.}=
  return await client.watch("/apis/authentication.k8s.io/v1beta1", t, name, namespace)
