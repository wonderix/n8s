import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams
import io_k8s_apimachinery_pkg_apis_meta_v1

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

proc get*(client: Client, t: typedesc[TokenReview], name: string, namespace = "default"): Future[TokenReview] {.async.}=
  proc unmarshal(parser: var JsonParser):TokenReview = 
    var ret: TokenReview
    load(ret,parser)
    return ret 
  return await client.get("/apis/authentication.k8s.io/v1beta1",t,name,namespace, unmarshal)
