import ../client
import ../base_types
import parsejson
import streams
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

proc dump*(self: SubjectAccessReviewStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`denied`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"denied\":")
    self.`denied`.dump(s)
  if not self.`evaluationError`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"evaluationError\":")
    self.`evaluationError`.dump(s)
  if not self.`reason`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"reason\":")
    self.`reason`.dump(s)
  if not self.`allowed`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allowed\":")
    self.`allowed`.dump(s)
  s.write("}")

proc isEmpty*(self: SubjectAccessReviewStatus): bool =
  if not self.`denied`.isEmpty: return false
  if not self.`evaluationError`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`allowed`.isEmpty: return false
  true

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

proc dump*(self: ResourceAttributes, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`version`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"version\":")
    self.`version`.dump(s)
  if not self.`resource`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resource\":")
    self.`resource`.dump(s)
  if not self.`namespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespace\":")
    self.`namespace`.dump(s)
  if not self.`group`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"group\":")
    self.`group`.dump(s)
  if not self.`subresource`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"subresource\":")
    self.`subresource`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`verb`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"verb\":")
    self.`verb`.dump(s)
  s.write("}")

proc isEmpty*(self: ResourceAttributes): bool =
  if not self.`version`.isEmpty: return false
  if not self.`resource`.isEmpty: return false
  if not self.`namespace`.isEmpty: return false
  if not self.`group`.isEmpty: return false
  if not self.`subresource`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`verb`.isEmpty: return false
  true

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

proc dump*(self: NonResourceAttributes, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`verb`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"verb\":")
    self.`verb`.dump(s)
  s.write("}")

proc isEmpty*(self: NonResourceAttributes): bool =
  if not self.`path`.isEmpty: return false
  if not self.`verb`.isEmpty: return false
  true

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

proc dump*(self: SelfSubjectAccessReviewSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`resourceAttributes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resourceAttributes\":")
    self.`resourceAttributes`.dump(s)
  if not self.`nonResourceAttributes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nonResourceAttributes\":")
    self.`nonResourceAttributes`.dump(s)
  s.write("}")

proc isEmpty*(self: SelfSubjectAccessReviewSpec): bool =
  if not self.`resourceAttributes`.isEmpty: return false
  if not self.`nonResourceAttributes`.isEmpty: return false
  true

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

proc dump*(self: SelfSubjectRulesReviewSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`namespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespace\":")
    self.`namespace`.dump(s)
  s.write("}")

proc isEmpty*(self: SelfSubjectRulesReviewSpec): bool =
  if not self.`namespace`.isEmpty: return false
  true

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

proc dump*(self: NonResourceRule, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`verbs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"verbs\":")
    self.`verbs`.dump(s)
  if not self.`nonResourceURLs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nonResourceURLs\":")
    self.`nonResourceURLs`.dump(s)
  s.write("}")

proc isEmpty*(self: NonResourceRule): bool =
  if not self.`verbs`.isEmpty: return false
  if not self.`nonResourceURLs`.isEmpty: return false
  true

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

proc dump*(self: ResourceRule, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`resources`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resources\":")
    self.`resources`.dump(s)
  if not self.`apiGroups`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiGroups\":")
    self.`apiGroups`.dump(s)
  if not self.`verbs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"verbs\":")
    self.`verbs`.dump(s)
  if not self.`resourceNames`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resourceNames\":")
    self.`resourceNames`.dump(s)
  s.write("}")

proc isEmpty*(self: ResourceRule): bool =
  if not self.`resources`.isEmpty: return false
  if not self.`apiGroups`.isEmpty: return false
  if not self.`verbs`.isEmpty: return false
  if not self.`resourceNames`.isEmpty: return false
  true

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

proc dump*(self: SubjectRulesReviewStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`nonResourceRules`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nonResourceRules\":")
    self.`nonResourceRules`.dump(s)
  if not self.`resourceRules`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resourceRules\":")
    self.`resourceRules`.dump(s)
  if not self.`incomplete`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"incomplete\":")
    self.`incomplete`.dump(s)
  if not self.`evaluationError`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"evaluationError\":")
    self.`evaluationError`.dump(s)
  s.write("}")

proc isEmpty*(self: SubjectRulesReviewStatus): bool =
  if not self.`nonResourceRules`.isEmpty: return false
  if not self.`resourceRules`.isEmpty: return false
  if not self.`incomplete`.isEmpty: return false
  if not self.`evaluationError`.isEmpty: return false
  true

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

proc dump*(self: SelfSubjectRulesReview, s: Stream) =
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

proc isEmpty*(self: SelfSubjectRulesReview): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadSelfSubjectRulesReview(parser: var JsonParser):SelfSubjectRulesReview = 
  var ret: SelfSubjectRulesReview
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[SelfSubjectRulesReview], name: string, namespace = "default"): Future[SelfSubjectRulesReview] {.async.}=
  return await client.get("/apis/authorization.k8s.io/v1", t, name, namespace, loadSelfSubjectRulesReview)

proc create*(client: Client, t: SelfSubjectRulesReview, namespace = "default"): Future[SelfSubjectRulesReview] {.async.}=
  t.apiVersion = "/apis/authorization.k8s.io/v1"
  t.kind = "SelfSubjectRulesReview"
  return await client.get("/apis/authorization.k8s.io/v1", t, name, namespace, loadSelfSubjectRulesReview)

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

proc dump*(self: SubjectAccessReviewSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`uid`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"uid\":")
    self.`uid`.dump(s)
  if not self.`user`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"user\":")
    self.`user`.dump(s)
  if not self.`groups`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"groups\":")
    self.`groups`.dump(s)
  if not self.`resourceAttributes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resourceAttributes\":")
    self.`resourceAttributes`.dump(s)
  if not self.`extra`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"extra\":")
    self.`extra`.dump(s)
  if not self.`nonResourceAttributes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nonResourceAttributes\":")
    self.`nonResourceAttributes`.dump(s)
  s.write("}")

proc isEmpty*(self: SubjectAccessReviewSpec): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`user`.isEmpty: return false
  if not self.`groups`.isEmpty: return false
  if not self.`resourceAttributes`.isEmpty: return false
  if not self.`extra`.isEmpty: return false
  if not self.`nonResourceAttributes`.isEmpty: return false
  true

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

proc dump*(self: SubjectAccessReview, s: Stream) =
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

proc isEmpty*(self: SubjectAccessReview): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadSubjectAccessReview(parser: var JsonParser):SubjectAccessReview = 
  var ret: SubjectAccessReview
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[SubjectAccessReview], name: string, namespace = "default"): Future[SubjectAccessReview] {.async.}=
  return await client.get("/apis/authorization.k8s.io/v1", t, name, namespace, loadSubjectAccessReview)

proc create*(client: Client, t: SubjectAccessReview, namespace = "default"): Future[SubjectAccessReview] {.async.}=
  t.apiVersion = "/apis/authorization.k8s.io/v1"
  t.kind = "SubjectAccessReview"
  return await client.get("/apis/authorization.k8s.io/v1", t, name, namespace, loadSubjectAccessReview)

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

proc dump*(self: SelfSubjectAccessReview, s: Stream) =
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

proc isEmpty*(self: SelfSubjectAccessReview): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadSelfSubjectAccessReview(parser: var JsonParser):SelfSubjectAccessReview = 
  var ret: SelfSubjectAccessReview
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[SelfSubjectAccessReview], name: string, namespace = "default"): Future[SelfSubjectAccessReview] {.async.}=
  return await client.get("/apis/authorization.k8s.io/v1", t, name, namespace, loadSelfSubjectAccessReview)

proc create*(client: Client, t: SelfSubjectAccessReview, namespace = "default"): Future[SelfSubjectAccessReview] {.async.}=
  t.apiVersion = "/apis/authorization.k8s.io/v1"
  t.kind = "SelfSubjectAccessReview"
  return await client.get("/apis/authorization.k8s.io/v1", t, name, namespace, loadSelfSubjectAccessReview)

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

proc dump*(self: LocalSubjectAccessReview, s: Stream) =
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

proc isEmpty*(self: LocalSubjectAccessReview): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadLocalSubjectAccessReview(parser: var JsonParser):LocalSubjectAccessReview = 
  var ret: LocalSubjectAccessReview
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[LocalSubjectAccessReview], name: string, namespace = "default"): Future[LocalSubjectAccessReview] {.async.}=
  return await client.get("/apis/authorization.k8s.io/v1", t, name, namespace, loadLocalSubjectAccessReview)

proc create*(client: Client, t: LocalSubjectAccessReview, namespace = "default"): Future[LocalSubjectAccessReview] {.async.}=
  t.apiVersion = "/apis/authorization.k8s.io/v1"
  t.kind = "LocalSubjectAccessReview"
  return await client.get("/apis/authorization.k8s.io/v1", t, name, namespace, loadLocalSubjectAccessReview)
