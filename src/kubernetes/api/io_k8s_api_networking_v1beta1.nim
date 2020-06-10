import ../client
import ../base_types
import parsejson
import streams
import io_k8s_apimachinery_pkg_util_intstr
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch
import io_k8s_api_core_v1

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

proc dump*(self: IngressTLS, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`secretName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretName\":")
    self.`secretName`.dump(s)
  if not self.`hosts`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hosts\":")
    self.`hosts`.dump(s)
  s.write("}")

proc isEmpty*(self: IngressTLS): bool =
  if not self.`secretName`.isEmpty: return false
  if not self.`hosts`.isEmpty: return false
  true

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

proc dump*(self: IngressBackend, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`serviceName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"serviceName\":")
    self.`serviceName`.dump(s)
  if not self.`servicePort`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"servicePort\":")
    self.`servicePort`.dump(s)
  s.write("}")

proc isEmpty*(self: IngressBackend): bool =
  if not self.`serviceName`.isEmpty: return false
  if not self.`servicePort`.isEmpty: return false
  true

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

proc dump*(self: HTTPIngressPath, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`backend`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"backend\":")
    self.`backend`.dump(s)
  s.write("}")

proc isEmpty*(self: HTTPIngressPath): bool =
  if not self.`path`.isEmpty: return false
  if not self.`backend`.isEmpty: return false
  true

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

proc dump*(self: HTTPIngressRuleValue, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`paths`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"paths\":")
    self.`paths`.dump(s)
  s.write("}")

proc isEmpty*(self: HTTPIngressRuleValue): bool =
  if not self.`paths`.isEmpty: return false
  true

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

proc dump*(self: IngressRule, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`http`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"http\":")
    self.`http`.dump(s)
  if not self.`host`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"host\":")
    self.`host`.dump(s)
  s.write("}")

proc isEmpty*(self: IngressRule): bool =
  if not self.`http`.isEmpty: return false
  if not self.`host`.isEmpty: return false
  true

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

proc dump*(self: IngressSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`tls`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"tls\":")
    self.`tls`.dump(s)
  if not self.`rules`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rules\":")
    self.`rules`.dump(s)
  if not self.`backend`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"backend\":")
    self.`backend`.dump(s)
  s.write("}")

proc isEmpty*(self: IngressSpec): bool =
  if not self.`tls`.isEmpty: return false
  if not self.`rules`.isEmpty: return false
  if not self.`backend`.isEmpty: return false
  true

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

proc dump*(self: IngressStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`loadBalancer`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"loadBalancer\":")
    self.`loadBalancer`.dump(s)
  s.write("}")

proc isEmpty*(self: IngressStatus): bool =
  if not self.`loadBalancer`.isEmpty: return false
  true

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

proc dump*(self: Ingress, s: Stream) =
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

proc isEmpty*(self: Ingress): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadIngress(parser: var JsonParser):Ingress = 
  var ret: Ingress
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Ingress], name: string, namespace = "default"): Future[Ingress] {.async.}=
  return await client.get("/apis/networking.k8s.io/v1beta1", t, name, namespace, loadIngress)

proc create*(client: Client, t: Ingress, namespace = "default"): Future[Ingress] {.async.}=
  t.apiVersion = "/apis/networking.k8s.io/v1beta1"
  t.kind = "Ingress"
  return await client.get("/apis/networking.k8s.io/v1beta1", t, name, namespace, loadIngress)

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

proc dump*(self: IngressList, s: Stream) =
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

proc isEmpty*(self: IngressList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadIngressList(parser: var JsonParser):IngressList = 
  var ret: IngressList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[Ingress], namespace = "default"): Future[seq[Ingress]] {.async.}=
  return (await client.list("/apis/networking.k8s.io/v1beta1", IngressList, namespace, loadIngressList)).items
