import ../client
import ../base_types
import parsejson
import ../jsonstream
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch
import tables

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

proc dump*(self: ResourceAttributes, s: JsonStream) =
  s.objectStart()
  if not self.`version`.isEmpty:
    s.name("version")
    self.`version`.dump(s)
  if not self.`resource`.isEmpty:
    s.name("resource")
    self.`resource`.dump(s)
  if not self.`namespace`.isEmpty:
    s.name("namespace")
    self.`namespace`.dump(s)
  if not self.`group`.isEmpty:
    s.name("group")
    self.`group`.dump(s)
  if not self.`subresource`.isEmpty:
    s.name("subresource")
    self.`subresource`.dump(s)
  if not self.`name`.isEmpty:
    s.name("name")
    self.`name`.dump(s)
  if not self.`verb`.isEmpty:
    s.name("verb")
    self.`verb`.dump(s)
  s.objectEnd()

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

proc dump*(self: NonResourceAttributes, s: JsonStream) =
  s.objectStart()
  if not self.`path`.isEmpty:
    s.name("path")
    self.`path`.dump(s)
  if not self.`verb`.isEmpty:
    s.name("verb")
    self.`verb`.dump(s)
  s.objectEnd()

proc isEmpty*(self: NonResourceAttributes): bool =
  if not self.`path`.isEmpty: return false
  if not self.`verb`.isEmpty: return false
  true

type
  SubjectAccessReviewSpec* = object
    `uid`*: string
    `user`*: string
    `resourceAttributes`*: ResourceAttributes
    `group`*: seq[string]
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
          of "resourceAttributes":
            load(self.`resourceAttributes`,parser)
          of "group":
            load(self.`group`,parser)
          of "extra":
            load(self.`extra`,parser)
          of "nonResourceAttributes":
            load(self.`nonResourceAttributes`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: SubjectAccessReviewSpec, s: JsonStream) =
  s.objectStart()
  if not self.`uid`.isEmpty:
    s.name("uid")
    self.`uid`.dump(s)
  if not self.`user`.isEmpty:
    s.name("user")
    self.`user`.dump(s)
  if not self.`resourceAttributes`.isEmpty:
    s.name("resourceAttributes")
    self.`resourceAttributes`.dump(s)
  if not self.`group`.isEmpty:
    s.name("group")
    self.`group`.dump(s)
  if not self.`extra`.isEmpty:
    s.name("extra")
    self.`extra`.dump(s)
  if not self.`nonResourceAttributes`.isEmpty:
    s.name("nonResourceAttributes")
    self.`nonResourceAttributes`.dump(s)
  s.objectEnd()

proc isEmpty*(self: SubjectAccessReviewSpec): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`user`.isEmpty: return false
  if not self.`resourceAttributes`.isEmpty: return false
  if not self.`group`.isEmpty: return false
  if not self.`extra`.isEmpty: return false
  if not self.`nonResourceAttributes`.isEmpty: return false
  true

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

proc dump*(self: SubjectAccessReviewStatus, s: JsonStream) =
  s.objectStart()
  if not self.`denied`.isEmpty:
    s.name("denied")
    self.`denied`.dump(s)
  if not self.`evaluationError`.isEmpty:
    s.name("evaluationError")
    self.`evaluationError`.dump(s)
  if not self.`reason`.isEmpty:
    s.name("reason")
    self.`reason`.dump(s)
  s.name("allowed")
  self.`allowed`.dump(s)
  s.objectEnd()

proc isEmpty*(self: SubjectAccessReviewStatus): bool =
  if not self.`denied`.isEmpty: return false
  if not self.`evaluationError`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`allowed`.isEmpty: return false
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

proc dump*(self: SubjectAccessReview, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("authorization.k8s.io/v1beta1")
  s.name("kind"); s.value("SubjectAccessReview")
  s.name("spec")
  self.`spec`.dump(s)
  if not self.`status`.isEmpty:
    s.name("status")
    self.`status`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

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
  return await client.get("/apis/authorization.k8s.io/v1beta1", t, name, namespace, loadSubjectAccessReview)

proc create*(client: Client, t: SubjectAccessReview, namespace = "default"): Future[SubjectAccessReview] {.async.}=
  return await client.create("/apis/authorization.k8s.io/v1beta1", t, namespace, loadSubjectAccessReview)

proc delete*(client: Client, t: typedesc[SubjectAccessReview], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/authorization.k8s.io/v1beta1", t, name, namespace)

proc replace*(client: Client, t: SubjectAccessReview, namespace = "default"): Future[SubjectAccessReview] {.async.}=
  return await client.replace("/apis/authorization.k8s.io/v1beta1", t, t.metadata.name, namespace, loadSubjectAccessReview)

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

proc dump*(self: SelfSubjectAccessReviewSpec, s: JsonStream) =
  s.objectStart()
  if not self.`resourceAttributes`.isEmpty:
    s.name("resourceAttributes")
    self.`resourceAttributes`.dump(s)
  if not self.`nonResourceAttributes`.isEmpty:
    s.name("nonResourceAttributes")
    self.`nonResourceAttributes`.dump(s)
  s.objectEnd()

proc isEmpty*(self: SelfSubjectAccessReviewSpec): bool =
  if not self.`resourceAttributes`.isEmpty: return false
  if not self.`nonResourceAttributes`.isEmpty: return false
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

proc dump*(self: NonResourceRule, s: JsonStream) =
  s.objectStart()
  s.name("verbs")
  self.`verbs`.dump(s)
  if not self.`nonResourceURLs`.isEmpty:
    s.name("nonResourceURLs")
    self.`nonResourceURLs`.dump(s)
  s.objectEnd()

proc isEmpty*(self: NonResourceRule): bool =
  if not self.`verbs`.isEmpty: return false
  if not self.`nonResourceURLs`.isEmpty: return false
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

proc dump*(self: SelfSubjectRulesReviewSpec, s: JsonStream) =
  s.objectStart()
  if not self.`namespace`.isEmpty:
    s.name("namespace")
    self.`namespace`.dump(s)
  s.objectEnd()

proc isEmpty*(self: SelfSubjectRulesReviewSpec): bool =
  if not self.`namespace`.isEmpty: return false
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

proc dump*(self: ResourceRule, s: JsonStream) =
  s.objectStart()
  if not self.`resources`.isEmpty:
    s.name("resources")
    self.`resources`.dump(s)
  if not self.`apiGroups`.isEmpty:
    s.name("apiGroups")
    self.`apiGroups`.dump(s)
  s.name("verbs")
  self.`verbs`.dump(s)
  if not self.`resourceNames`.isEmpty:
    s.name("resourceNames")
    self.`resourceNames`.dump(s)
  s.objectEnd()

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

proc dump*(self: SubjectRulesReviewStatus, s: JsonStream) =
  s.objectStart()
  s.name("nonResourceRules")
  self.`nonResourceRules`.dump(s)
  s.name("resourceRules")
  self.`resourceRules`.dump(s)
  s.name("incomplete")
  self.`incomplete`.dump(s)
  if not self.`evaluationError`.isEmpty:
    s.name("evaluationError")
    self.`evaluationError`.dump(s)
  s.objectEnd()

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

proc dump*(self: SelfSubjectRulesReview, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("authorization.k8s.io/v1beta1")
  s.name("kind"); s.value("SelfSubjectRulesReview")
  s.name("spec")
  self.`spec`.dump(s)
  if not self.`status`.isEmpty:
    s.name("status")
    self.`status`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

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
  return await client.get("/apis/authorization.k8s.io/v1beta1", t, name, namespace, loadSelfSubjectRulesReview)

proc create*(client: Client, t: SelfSubjectRulesReview, namespace = "default"): Future[SelfSubjectRulesReview] {.async.}=
  return await client.create("/apis/authorization.k8s.io/v1beta1", t, namespace, loadSelfSubjectRulesReview)

proc delete*(client: Client, t: typedesc[SelfSubjectRulesReview], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/authorization.k8s.io/v1beta1", t, name, namespace)

proc replace*(client: Client, t: SelfSubjectRulesReview, namespace = "default"): Future[SelfSubjectRulesReview] {.async.}=
  return await client.replace("/apis/authorization.k8s.io/v1beta1", t, t.metadata.name, namespace, loadSelfSubjectRulesReview)

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

proc dump*(self: SelfSubjectAccessReview, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("authorization.k8s.io/v1beta1")
  s.name("kind"); s.value("SelfSubjectAccessReview")
  s.name("spec")
  self.`spec`.dump(s)
  if not self.`status`.isEmpty:
    s.name("status")
    self.`status`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

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
  return await client.get("/apis/authorization.k8s.io/v1beta1", t, name, namespace, loadSelfSubjectAccessReview)

proc create*(client: Client, t: SelfSubjectAccessReview, namespace = "default"): Future[SelfSubjectAccessReview] {.async.}=
  return await client.create("/apis/authorization.k8s.io/v1beta1", t, namespace, loadSelfSubjectAccessReview)

proc delete*(client: Client, t: typedesc[SelfSubjectAccessReview], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/authorization.k8s.io/v1beta1", t, name, namespace)

proc replace*(client: Client, t: SelfSubjectAccessReview, namespace = "default"): Future[SelfSubjectAccessReview] {.async.}=
  return await client.replace("/apis/authorization.k8s.io/v1beta1", t, t.metadata.name, namespace, loadSelfSubjectAccessReview)

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

proc dump*(self: LocalSubjectAccessReview, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("authorization.k8s.io/v1beta1")
  s.name("kind"); s.value("LocalSubjectAccessReview")
  s.name("spec")
  self.`spec`.dump(s)
  if not self.`status`.isEmpty:
    s.name("status")
    self.`status`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

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
  return await client.get("/apis/authorization.k8s.io/v1beta1", t, name, namespace, loadLocalSubjectAccessReview)

proc create*(client: Client, t: LocalSubjectAccessReview, namespace = "default"): Future[LocalSubjectAccessReview] {.async.}=
  return await client.create("/apis/authorization.k8s.io/v1beta1", t, namespace, loadLocalSubjectAccessReview)

proc delete*(client: Client, t: typedesc[LocalSubjectAccessReview], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/authorization.k8s.io/v1beta1", t, name, namespace)

proc replace*(client: Client, t: LocalSubjectAccessReview, namespace = "default"): Future[LocalSubjectAccessReview] {.async.}=
  return await client.replace("/apis/authorization.k8s.io/v1beta1", t, t.metadata.name, namespace, loadLocalSubjectAccessReview)
