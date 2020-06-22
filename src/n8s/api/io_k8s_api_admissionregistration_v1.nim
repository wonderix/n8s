import ../client
import ../base_types
import parsejson
import ../jsonwriter
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch

type
  ServiceReference* = object
    `path`*: string
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
          of "path":
            load(self.`path`,parser)
          of "namespace":
            load(self.`namespace`,parser)
          of "port":
            load(self.`port`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ServiceReference, s: JsonWriter) =
  s.objectStart()
  if not self.`path`.isEmpty:
    s.name("path")
    self.`path`.dump(s)
  s.name("namespace")
  self.`namespace`.dump(s)
  if not self.`port`.isEmpty:
    s.name("port")
    self.`port`.dump(s)
  s.name("name")
  self.`name`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ServiceReference): bool =
  if not self.`path`.isEmpty: return false
  if not self.`namespace`.isEmpty: return false
  if not self.`port`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

type
  WebhookClientConfig* = object
    `caBundle`*: ByteArray
    `url`*: string
    `service`*: ServiceReference

proc load*(self: var WebhookClientConfig, parser: var JsonParser) =
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
          of "caBundle":
            load(self.`caBundle`,parser)
          of "url":
            load(self.`url`,parser)
          of "service":
            load(self.`service`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: WebhookClientConfig, s: JsonWriter) =
  s.objectStart()
  if not self.`caBundle`.isEmpty:
    s.name("caBundle")
    self.`caBundle`.dump(s)
  if not self.`url`.isEmpty:
    s.name("url")
    self.`url`.dump(s)
  if not self.`service`.isEmpty:
    s.name("service")
    self.`service`.dump(s)
  s.objectEnd()

proc isEmpty*(self: WebhookClientConfig): bool =
  if not self.`caBundle`.isEmpty: return false
  if not self.`url`.isEmpty: return false
  if not self.`service`.isEmpty: return false
  true

type
  RuleWithOperations* = object
    `operations`*: seq[string]
    `apiVersions`*: seq[string]
    `resources`*: seq[string]
    `apiGroups`*: seq[string]
    `scope`*: string

proc load*(self: var RuleWithOperations, parser: var JsonParser) =
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
          of "operations":
            load(self.`operations`,parser)
          of "apiVersions":
            load(self.`apiVersions`,parser)
          of "resources":
            load(self.`resources`,parser)
          of "apiGroups":
            load(self.`apiGroups`,parser)
          of "scope":
            load(self.`scope`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: RuleWithOperations, s: JsonWriter) =
  s.objectStart()
  if not self.`operations`.isEmpty:
    s.name("operations")
    self.`operations`.dump(s)
  if not self.`apiVersions`.isEmpty:
    s.name("apiVersions")
    self.`apiVersions`.dump(s)
  if not self.`resources`.isEmpty:
    s.name("resources")
    self.`resources`.dump(s)
  if not self.`apiGroups`.isEmpty:
    s.name("apiGroups")
    self.`apiGroups`.dump(s)
  if not self.`scope`.isEmpty:
    s.name("scope")
    self.`scope`.dump(s)
  s.objectEnd()

proc isEmpty*(self: RuleWithOperations): bool =
  if not self.`operations`.isEmpty: return false
  if not self.`apiVersions`.isEmpty: return false
  if not self.`resources`.isEmpty: return false
  if not self.`apiGroups`.isEmpty: return false
  if not self.`scope`.isEmpty: return false
  true

type
  MutatingWebhook* = object
    `objectSelector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `clientConfig`*: WebhookClientConfig
    `timeoutSeconds`*: int
    `rules`*: seq[RuleWithOperations]
    `admissionReviewVersions`*: seq[string]
    `namespaceSelector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `matchPolicy`*: string
    `name`*: string
    `failurePolicy`*: string
    `sideEffects`*: string
    `reinvocationPolicy`*: string

proc load*(self: var MutatingWebhook, parser: var JsonParser) =
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
          of "objectSelector":
            load(self.`objectSelector`,parser)
          of "clientConfig":
            load(self.`clientConfig`,parser)
          of "timeoutSeconds":
            load(self.`timeoutSeconds`,parser)
          of "rules":
            load(self.`rules`,parser)
          of "admissionReviewVersions":
            load(self.`admissionReviewVersions`,parser)
          of "namespaceSelector":
            load(self.`namespaceSelector`,parser)
          of "matchPolicy":
            load(self.`matchPolicy`,parser)
          of "name":
            load(self.`name`,parser)
          of "failurePolicy":
            load(self.`failurePolicy`,parser)
          of "sideEffects":
            load(self.`sideEffects`,parser)
          of "reinvocationPolicy":
            load(self.`reinvocationPolicy`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: MutatingWebhook, s: JsonWriter) =
  s.objectStart()
  if not self.`objectSelector`.isEmpty:
    s.name("objectSelector")
    self.`objectSelector`.dump(s)
  s.name("clientConfig")
  self.`clientConfig`.dump(s)
  if not self.`timeoutSeconds`.isEmpty:
    s.name("timeoutSeconds")
    self.`timeoutSeconds`.dump(s)
  if not self.`rules`.isEmpty:
    s.name("rules")
    self.`rules`.dump(s)
  s.name("admissionReviewVersions")
  self.`admissionReviewVersions`.dump(s)
  if not self.`namespaceSelector`.isEmpty:
    s.name("namespaceSelector")
    self.`namespaceSelector`.dump(s)
  if not self.`matchPolicy`.isEmpty:
    s.name("matchPolicy")
    self.`matchPolicy`.dump(s)
  s.name("name")
  self.`name`.dump(s)
  if not self.`failurePolicy`.isEmpty:
    s.name("failurePolicy")
    self.`failurePolicy`.dump(s)
  s.name("sideEffects")
  self.`sideEffects`.dump(s)
  if not self.`reinvocationPolicy`.isEmpty:
    s.name("reinvocationPolicy")
    self.`reinvocationPolicy`.dump(s)
  s.objectEnd()

proc isEmpty*(self: MutatingWebhook): bool =
  if not self.`objectSelector`.isEmpty: return false
  if not self.`clientConfig`.isEmpty: return false
  if not self.`timeoutSeconds`.isEmpty: return false
  if not self.`rules`.isEmpty: return false
  if not self.`admissionReviewVersions`.isEmpty: return false
  if not self.`namespaceSelector`.isEmpty: return false
  if not self.`matchPolicy`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`failurePolicy`.isEmpty: return false
  if not self.`sideEffects`.isEmpty: return false
  if not self.`reinvocationPolicy`.isEmpty: return false
  true

type
  MutatingWebhookConfiguration* = object
    `apiVersion`*: string
    `webhooks`*: seq[MutatingWebhook]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var MutatingWebhookConfiguration, parser: var JsonParser) =
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
          of "webhooks":
            load(self.`webhooks`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: MutatingWebhookConfiguration, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("admissionregistration.k8s.io/v1")
  s.name("kind"); s.value("MutatingWebhookConfiguration")
  if not self.`webhooks`.isEmpty:
    s.name("webhooks")
    self.`webhooks`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: MutatingWebhookConfiguration): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`webhooks`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[MutatingWebhookConfiguration], name: string, namespace = "default"): Future[MutatingWebhookConfiguration] {.async.}=
  return await client.get("/apis/admissionregistration.k8s.io/v1", t, name, namespace)

proc create*(client: Client, t: MutatingWebhookConfiguration, namespace = "default"): Future[MutatingWebhookConfiguration] {.async.}=
  return await client.create("/apis/admissionregistration.k8s.io/v1", t, namespace)

proc delete*(client: Client, t: typedesc[MutatingWebhookConfiguration], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/admissionregistration.k8s.io/v1", t, name, namespace)

proc replace*(client: Client, t: MutatingWebhookConfiguration, namespace = "default"): Future[MutatingWebhookConfiguration] {.async.}=
  return await client.replace("/apis/admissionregistration.k8s.io/v1", t, t.metadata.name, namespace)

proc watch*(client: Client, t: typedesc[MutatingWebhookConfiguration], name: string, namespace = "default"): Future[FutureStream[WatchEv[MutatingWebhookConfiguration]]] {.async.}=
  return await client.watch("/apis/admissionregistration.k8s.io/v1", t, name, namespace)

type
  MutatingWebhookConfigurationList* = object
    `apiVersion`*: string
    `items`*: seq[MutatingWebhookConfiguration]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var MutatingWebhookConfigurationList, parser: var JsonParser) =
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

proc dump*(self: MutatingWebhookConfigurationList, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("admissionregistration.k8s.io/v1")
  s.name("kind"); s.value("MutatingWebhookConfigurationList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: MutatingWebhookConfigurationList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc list*(client: Client, t: typedesc[MutatingWebhookConfiguration], namespace = "default"): Future[seq[MutatingWebhookConfiguration]] {.async.}=
  return (await client.list("/apis/admissionregistration.k8s.io/v1", MutatingWebhookConfigurationList, namespace)).items

type
  ValidatingWebhook* = object
    `objectSelector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `clientConfig`*: WebhookClientConfig
    `timeoutSeconds`*: int
    `rules`*: seq[RuleWithOperations]
    `admissionReviewVersions`*: seq[string]
    `namespaceSelector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `matchPolicy`*: string
    `name`*: string
    `failurePolicy`*: string
    `sideEffects`*: string

proc load*(self: var ValidatingWebhook, parser: var JsonParser) =
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
          of "objectSelector":
            load(self.`objectSelector`,parser)
          of "clientConfig":
            load(self.`clientConfig`,parser)
          of "timeoutSeconds":
            load(self.`timeoutSeconds`,parser)
          of "rules":
            load(self.`rules`,parser)
          of "admissionReviewVersions":
            load(self.`admissionReviewVersions`,parser)
          of "namespaceSelector":
            load(self.`namespaceSelector`,parser)
          of "matchPolicy":
            load(self.`matchPolicy`,parser)
          of "name":
            load(self.`name`,parser)
          of "failurePolicy":
            load(self.`failurePolicy`,parser)
          of "sideEffects":
            load(self.`sideEffects`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ValidatingWebhook, s: JsonWriter) =
  s.objectStart()
  if not self.`objectSelector`.isEmpty:
    s.name("objectSelector")
    self.`objectSelector`.dump(s)
  s.name("clientConfig")
  self.`clientConfig`.dump(s)
  if not self.`timeoutSeconds`.isEmpty:
    s.name("timeoutSeconds")
    self.`timeoutSeconds`.dump(s)
  if not self.`rules`.isEmpty:
    s.name("rules")
    self.`rules`.dump(s)
  s.name("admissionReviewVersions")
  self.`admissionReviewVersions`.dump(s)
  if not self.`namespaceSelector`.isEmpty:
    s.name("namespaceSelector")
    self.`namespaceSelector`.dump(s)
  if not self.`matchPolicy`.isEmpty:
    s.name("matchPolicy")
    self.`matchPolicy`.dump(s)
  s.name("name")
  self.`name`.dump(s)
  if not self.`failurePolicy`.isEmpty:
    s.name("failurePolicy")
    self.`failurePolicy`.dump(s)
  s.name("sideEffects")
  self.`sideEffects`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ValidatingWebhook): bool =
  if not self.`objectSelector`.isEmpty: return false
  if not self.`clientConfig`.isEmpty: return false
  if not self.`timeoutSeconds`.isEmpty: return false
  if not self.`rules`.isEmpty: return false
  if not self.`admissionReviewVersions`.isEmpty: return false
  if not self.`namespaceSelector`.isEmpty: return false
  if not self.`matchPolicy`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`failurePolicy`.isEmpty: return false
  if not self.`sideEffects`.isEmpty: return false
  true

type
  ValidatingWebhookConfiguration* = object
    `apiVersion`*: string
    `webhooks`*: seq[ValidatingWebhook]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var ValidatingWebhookConfiguration, parser: var JsonParser) =
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
          of "webhooks":
            load(self.`webhooks`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ValidatingWebhookConfiguration, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("admissionregistration.k8s.io/v1")
  s.name("kind"); s.value("ValidatingWebhookConfiguration")
  if not self.`webhooks`.isEmpty:
    s.name("webhooks")
    self.`webhooks`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ValidatingWebhookConfiguration): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`webhooks`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[ValidatingWebhookConfiguration], name: string, namespace = "default"): Future[ValidatingWebhookConfiguration] {.async.}=
  return await client.get("/apis/admissionregistration.k8s.io/v1", t, name, namespace)

proc create*(client: Client, t: ValidatingWebhookConfiguration, namespace = "default"): Future[ValidatingWebhookConfiguration] {.async.}=
  return await client.create("/apis/admissionregistration.k8s.io/v1", t, namespace)

proc delete*(client: Client, t: typedesc[ValidatingWebhookConfiguration], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/admissionregistration.k8s.io/v1", t, name, namespace)

proc replace*(client: Client, t: ValidatingWebhookConfiguration, namespace = "default"): Future[ValidatingWebhookConfiguration] {.async.}=
  return await client.replace("/apis/admissionregistration.k8s.io/v1", t, t.metadata.name, namespace)

proc watch*(client: Client, t: typedesc[ValidatingWebhookConfiguration], name: string, namespace = "default"): Future[FutureStream[WatchEv[ValidatingWebhookConfiguration]]] {.async.}=
  return await client.watch("/apis/admissionregistration.k8s.io/v1", t, name, namespace)

type
  ValidatingWebhookConfigurationList* = object
    `apiVersion`*: string
    `items`*: seq[ValidatingWebhookConfiguration]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var ValidatingWebhookConfigurationList, parser: var JsonParser) =
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

proc dump*(self: ValidatingWebhookConfigurationList, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("admissionregistration.k8s.io/v1")
  s.name("kind"); s.value("ValidatingWebhookConfigurationList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ValidatingWebhookConfigurationList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc list*(client: Client, t: typedesc[ValidatingWebhookConfiguration], namespace = "default"): Future[seq[ValidatingWebhookConfiguration]] {.async.}=
  return (await client.list("/apis/admissionregistration.k8s.io/v1", ValidatingWebhookConfigurationList, namespace)).items
