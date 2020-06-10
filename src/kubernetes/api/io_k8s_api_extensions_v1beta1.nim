import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams
import io_k8s_apimachinery_pkg_util_intstr
import io_k8s_api_core_v1
import io_k8s_apimachinery_pkg_apis_meta_v1

type
  IngressBackend* = object
    `serviceName`*: string
    `servicePort`*: io_k8s_apimachinery_pkg_util_intstr.IntOrString

proc load*(self: var IngressBackend, parser: var JsonParser) =
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
          of "serviceName":
            load(self.`serviceName`,parser)
          of "servicePort":
            load(self.`servicePort`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  HTTPIngressPath* = object
    `path`*: string
    `backend`*: IngressBackend

proc load*(self: var HTTPIngressPath, parser: var JsonParser) =
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
          of "backend":
            load(self.`backend`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  IngressTLS* = object
    `secretName`*: string
    `hosts`*: seq[string]

proc load*(self: var IngressTLS, parser: var JsonParser) =
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
          of "secretName":
            load(self.`secretName`,parser)
          of "hosts":
            load(self.`hosts`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  HTTPIngressRuleValue* = object
    `paths`*: seq[HTTPIngressPath]

proc load*(self: var HTTPIngressRuleValue, parser: var JsonParser) =
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
          of "paths":
            load(self.`paths`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  IngressRule* = object
    `http`*: HTTPIngressRuleValue
    `host`*: string

proc load*(self: var IngressRule, parser: var JsonParser) =
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
          of "http":
            load(self.`http`,parser)
          of "host":
            load(self.`host`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  IngressSpec* = object
    `tls`*: seq[IngressTLS]
    `rules`*: seq[IngressRule]
    `backend`*: IngressBackend

proc load*(self: var IngressSpec, parser: var JsonParser) =
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
          of "tls":
            load(self.`tls`,parser)
          of "rules":
            load(self.`rules`,parser)
          of "backend":
            load(self.`backend`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  IngressStatus* = object
    `loadBalancer`*: io_k8s_api_core_v1.LoadBalancerStatus

proc load*(self: var IngressStatus, parser: var JsonParser) =
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
          of "loadBalancer":
            load(self.`loadBalancer`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Ingress* = object
    `apiVersion`*: string
    `spec`*: IngressSpec
    `status`*: IngressStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Ingress, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[Ingress], name: string, namespace = "default"): Future[Ingress] {.async.}=
  proc unmarshal(parser: var JsonParser):Ingress = 
    var ret: Ingress
    load(ret,parser)
    return ret 
  return await client.get("/apis/extensions/v1beta1",t,name,namespace, unmarshal)

type
  IngressList* = object
    `apiVersion`*: string
    `items`*: seq[Ingress]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var IngressList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[IngressList], name: string, namespace = "default"): Future[IngressList] {.async.}=
  proc unmarshal(parser: var JsonParser):IngressList = 
    var ret: IngressList
    load(ret,parser)
    return ret 
  return await client.get("/apis/extensions/v1beta1",t,name,namespace, unmarshal)
