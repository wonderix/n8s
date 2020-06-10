import ../client
import ../base_types
import parsejson
import streams
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

proc dump*(self: ServiceReference, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`namespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespace\":")
    self.`namespace`.dump(s)
  if not self.`port`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"port\":")
    self.`port`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

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

proc dump*(self: WebhookClientConfig, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`caBundle`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"caBundle\":")
    self.`caBundle`.dump(s)
  if not self.`url`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"url\":")
    self.`url`.dump(s)
  if not self.`service`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"service\":")
    self.`service`.dump(s)
  s.write("}")

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

proc dump*(self: RuleWithOperations, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`operations`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"operations\":")
    self.`operations`.dump(s)
  if not self.`apiVersions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersions\":")
    self.`apiVersions`.dump(s)
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
  if not self.`scope`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"scope\":")
    self.`scope`.dump(s)
  s.write("}")

proc isEmpty*(self: RuleWithOperations): bool =
  if not self.`operations`.isEmpty: return false
  if not self.`apiVersions`.isEmpty: return false
  if not self.`resources`.isEmpty: return false
  if not self.`apiGroups`.isEmpty: return false
  if not self.`scope`.isEmpty: return false
  true

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

proc dump*(self: ValidatingWebhook, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`objectSelector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"objectSelector\":")
    self.`objectSelector`.dump(s)
  if not self.`clientConfig`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"clientConfig\":")
    self.`clientConfig`.dump(s)
  if not self.`timeoutSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"timeoutSeconds\":")
    self.`timeoutSeconds`.dump(s)
  if not self.`rules`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rules\":")
    self.`rules`.dump(s)
  if not self.`admissionReviewVersions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"admissionReviewVersions\":")
    self.`admissionReviewVersions`.dump(s)
  if not self.`namespaceSelector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespaceSelector\":")
    self.`namespaceSelector`.dump(s)
  if not self.`matchPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"matchPolicy\":")
    self.`matchPolicy`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`failurePolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"failurePolicy\":")
    self.`failurePolicy`.dump(s)
  if not self.`sideEffects`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"sideEffects\":")
    self.`sideEffects`.dump(s)
  s.write("}")

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

proc dump*(self: ValidatingWebhookConfiguration, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`webhooks`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"webhooks\":")
    self.`webhooks`.dump(s)
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

proc isEmpty*(self: ValidatingWebhookConfiguration): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`webhooks`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadValidatingWebhookConfiguration(parser: var JsonParser):ValidatingWebhookConfiguration = 
  var ret: ValidatingWebhookConfiguration
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[ValidatingWebhookConfiguration], name: string, namespace = "default"): Future[ValidatingWebhookConfiguration] {.async.}=
  return await client.get("/apis/admissionregistration.k8s.io/v1beta1",t,name,namespace, loadValidatingWebhookConfiguration)

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

proc dump*(self: ValidatingWebhookConfigurationList, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
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

proc isEmpty*(self: ValidatingWebhookConfigurationList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadValidatingWebhookConfigurationList(parser: var JsonParser):ValidatingWebhookConfigurationList = 
  var ret: ValidatingWebhookConfigurationList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[ValidatingWebhookConfiguration], namespace = "default"): Future[seq[ValidatingWebhookConfiguration]] {.async.}=
  return (await client.list("/apis/admissionregistration.k8s.io/v1beta1",ValidatingWebhookConfigurationList,namespace, loadValidatingWebhookConfigurationList)).items

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

proc dump*(self: MutatingWebhook, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`objectSelector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"objectSelector\":")
    self.`objectSelector`.dump(s)
  if not self.`clientConfig`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"clientConfig\":")
    self.`clientConfig`.dump(s)
  if not self.`timeoutSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"timeoutSeconds\":")
    self.`timeoutSeconds`.dump(s)
  if not self.`rules`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rules\":")
    self.`rules`.dump(s)
  if not self.`admissionReviewVersions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"admissionReviewVersions\":")
    self.`admissionReviewVersions`.dump(s)
  if not self.`namespaceSelector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespaceSelector\":")
    self.`namespaceSelector`.dump(s)
  if not self.`matchPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"matchPolicy\":")
    self.`matchPolicy`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`failurePolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"failurePolicy\":")
    self.`failurePolicy`.dump(s)
  if not self.`sideEffects`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"sideEffects\":")
    self.`sideEffects`.dump(s)
  if not self.`reinvocationPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"reinvocationPolicy\":")
    self.`reinvocationPolicy`.dump(s)
  s.write("}")

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

proc dump*(self: MutatingWebhookConfiguration, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`webhooks`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"webhooks\":")
    self.`webhooks`.dump(s)
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

proc isEmpty*(self: MutatingWebhookConfiguration): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`webhooks`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadMutatingWebhookConfiguration(parser: var JsonParser):MutatingWebhookConfiguration = 
  var ret: MutatingWebhookConfiguration
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[MutatingWebhookConfiguration], name: string, namespace = "default"): Future[MutatingWebhookConfiguration] {.async.}=
  return await client.get("/apis/admissionregistration.k8s.io/v1beta1",t,name,namespace, loadMutatingWebhookConfiguration)

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

proc dump*(self: MutatingWebhookConfigurationList, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
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

proc isEmpty*(self: MutatingWebhookConfigurationList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadMutatingWebhookConfigurationList(parser: var JsonParser):MutatingWebhookConfigurationList = 
  var ret: MutatingWebhookConfigurationList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[MutatingWebhookConfiguration], namespace = "default"): Future[seq[MutatingWebhookConfiguration]] {.async.}=
  return (await client.list("/apis/admissionregistration.k8s.io/v1beta1",MutatingWebhookConfigurationList,namespace, loadMutatingWebhookConfigurationList)).items
