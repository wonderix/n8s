import ../client
import ../base_types
import parsejson
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

proc get*(client: Client, t: typedesc[ValidatingWebhookConfiguration], name: string, namespace = "default"): Future[ValidatingWebhookConfiguration] {.async.}=
  proc unmarshal(parser: var JsonParser):ValidatingWebhookConfiguration = 
    var ret: ValidatingWebhookConfiguration
    load(ret,parser)
    return ret 
  return await client.get("/apis/admissionregistration.k8s.io/v1beta1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[ValidatingWebhookConfigurationList], name: string, namespace = "default"): Future[ValidatingWebhookConfigurationList] {.async.}=
  proc unmarshal(parser: var JsonParser):ValidatingWebhookConfigurationList = 
    var ret: ValidatingWebhookConfigurationList
    load(ret,parser)
    return ret 
  return await client.get("/apis/admissionregistration.k8s.io/v1beta1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[MutatingWebhookConfiguration], name: string, namespace = "default"): Future[MutatingWebhookConfiguration] {.async.}=
  proc unmarshal(parser: var JsonParser):MutatingWebhookConfiguration = 
    var ret: MutatingWebhookConfiguration
    load(ret,parser)
    return ret 
  return await client.get("/apis/admissionregistration.k8s.io/v1beta1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[MutatingWebhookConfigurationList], name: string, namespace = "default"): Future[MutatingWebhookConfigurationList] {.async.}=
  proc unmarshal(parser: var JsonParser):MutatingWebhookConfigurationList = 
    var ret: MutatingWebhookConfigurationList
    load(ret,parser)
    return ret 
  return await client.get("/apis/admissionregistration.k8s.io/v1beta1",t,name,namespace, unmarshal)
