import ../client
import ../base_types
import parsejson
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch
import tables

type
  SubjectAccessReviewStatus* = object
    `denied`*: bool
    `evaluationError`*: string
    `reason`*: string
    `allowed`*: bool

proc load*(self: var SubjectAccessReviewStatus, parser: var JsonParser) =
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
          of "denied":
            load(self.`denied`,parser)
          of "evaluationError":
            load(self.`evaluationError`,parser)
          of "reason":
            load(self.`reason`,parser)
          of "allowed":
            load(self.`allowed`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ResourceAttributes* = object
    `version`*: string
    `resource`*: string
    `namespace`*: string
    `group`*: string
    `subresource`*: string
    `name`*: string
    `verb`*: string

proc load*(self: var ResourceAttributes, parser: var JsonParser) =
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
          of "resource":
            load(self.`resource`,parser)
          of "namespace":
            load(self.`namespace`,parser)
          of "group":
            load(self.`group`,parser)
          of "subresource":
            load(self.`subresource`,parser)
          of "name":
            load(self.`name`,parser)
          of "verb":
            load(self.`verb`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  NonResourceAttributes* = object
    `path`*: string
    `verb`*: string

proc load*(self: var NonResourceAttributes, parser: var JsonParser) =
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
          of "path":
            load(self.`path`,parser)
          of "verb":
            load(self.`verb`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  SelfSubjectAccessReviewSpec* = object
    `resourceAttributes`*: ResourceAttributes
    `nonResourceAttributes`*: NonResourceAttributes

proc load*(self: var SelfSubjectAccessReviewSpec, parser: var JsonParser) =
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
          of "resourceAttributes":
            load(self.`resourceAttributes`,parser)
          of "nonResourceAttributes":
            load(self.`nonResourceAttributes`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  SelfSubjectRulesReviewSpec* = object
    `namespace`*: string

proc load*(self: var SelfSubjectRulesReviewSpec, parser: var JsonParser) =
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
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  NonResourceRule* = object
    `verbs`*: seq[string]
    `nonResourceURLs`*: seq[string]

proc load*(self: var NonResourceRule, parser: var JsonParser) =
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
          of "verbs":
            load(self.`verbs`,parser)
          of "nonResourceURLs":
            load(self.`nonResourceURLs`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ResourceRule* = object
    `resources`*: seq[string]
    `apiGroups`*: seq[string]
    `verbs`*: seq[string]
    `resourceNames`*: seq[string]

proc load*(self: var ResourceRule, parser: var JsonParser) =
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
          of "resources":
            load(self.`resources`,parser)
          of "apiGroups":
            load(self.`apiGroups`,parser)
          of "verbs":
            load(self.`verbs`,parser)
          of "resourceNames":
            load(self.`resourceNames`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  SubjectRulesReviewStatus* = object
    `nonResourceRules`*: seq[NonResourceRule]
    `resourceRules`*: seq[ResourceRule]
    `incomplete`*: bool
    `evaluationError`*: string

proc load*(self: var SubjectRulesReviewStatus, parser: var JsonParser) =
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
          of "nonResourceRules":
            load(self.`nonResourceRules`,parser)
          of "resourceRules":
            load(self.`resourceRules`,parser)
          of "incomplete":
            load(self.`incomplete`,parser)
          of "evaluationError":
            load(self.`evaluationError`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  SelfSubjectRulesReview* = object
    `apiVersion`*: string
    `spec`*: SelfSubjectRulesReviewSpec
    `status`*: SubjectRulesReviewStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var SelfSubjectRulesReview, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[SelfSubjectRulesReview], name: string, namespace = "default"): Future[SelfSubjectRulesReview] {.async.}=
  proc unmarshal(parser: var JsonParser):SelfSubjectRulesReview = 
    var ret: SelfSubjectRulesReview
    load(ret,parser)
    return ret 
  return await client.get("/apis/authorization.k8s.io/v1",t,name,namespace, unmarshal)

type
  SubjectAccessReviewSpec* = object
    `uid`*: string
    `user`*: string
    `groups`*: seq[string]
    `resourceAttributes`*: ResourceAttributes
    `extra`*: Table[string,seq[string]]
    `nonResourceAttributes`*: NonResourceAttributes

proc load*(self: var SubjectAccessReviewSpec, parser: var JsonParser) =
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
          of "user":
            load(self.`user`,parser)
          of "groups":
            load(self.`groups`,parser)
          of "resourceAttributes":
            load(self.`resourceAttributes`,parser)
          of "extra":
            load(self.`extra`,parser)
          of "nonResourceAttributes":
            load(self.`nonResourceAttributes`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  SubjectAccessReview* = object
    `apiVersion`*: string
    `spec`*: SubjectAccessReviewSpec
    `status`*: SubjectAccessReviewStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var SubjectAccessReview, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[SubjectAccessReview], name: string, namespace = "default"): Future[SubjectAccessReview] {.async.}=
  proc unmarshal(parser: var JsonParser):SubjectAccessReview = 
    var ret: SubjectAccessReview
    load(ret,parser)
    return ret 
  return await client.get("/apis/authorization.k8s.io/v1",t,name,namespace, unmarshal)

type
  SelfSubjectAccessReview* = object
    `apiVersion`*: string
    `spec`*: SelfSubjectAccessReviewSpec
    `status`*: SubjectAccessReviewStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var SelfSubjectAccessReview, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[SelfSubjectAccessReview], name: string, namespace = "default"): Future[SelfSubjectAccessReview] {.async.}=
  proc unmarshal(parser: var JsonParser):SelfSubjectAccessReview = 
    var ret: SelfSubjectAccessReview
    load(ret,parser)
    return ret 
  return await client.get("/apis/authorization.k8s.io/v1",t,name,namespace, unmarshal)

type
  LocalSubjectAccessReview* = object
    `apiVersion`*: string
    `spec`*: SubjectAccessReviewSpec
    `status`*: SubjectAccessReviewStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var LocalSubjectAccessReview, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[LocalSubjectAccessReview], name: string, namespace = "default"): Future[LocalSubjectAccessReview] {.async.}=
  proc unmarshal(parser: var JsonParser):LocalSubjectAccessReview = 
    var ret: LocalSubjectAccessReview
    load(ret,parser)
    return ret 
  return await client.get("/apis/authorization.k8s.io/v1",t,name,namespace, unmarshal)
