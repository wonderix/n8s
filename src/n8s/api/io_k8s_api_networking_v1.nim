import ../client
import ../base_types
import parsejson
import ../jsonwriter
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch
import io_k8s_apimachinery_pkg_util_intstr

type
  NetworkPolicyPort* = object
    `protocol`*: string
    `port`*: io_k8s_apimachinery_pkg_util_intstr.IntOrString

proc load*(self: var NetworkPolicyPort, parser: var JsonParser) =
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
          of "protocol":
            load(self.`protocol`,parser)
          of "port":
            load(self.`port`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: NetworkPolicyPort, s: JsonWriter) =
  s.objectStart()
  if not self.`protocol`.isEmpty:
    s.name("protocol")
    self.`protocol`.dump(s)
  if not self.`port`.isEmpty:
    s.name("port")
    self.`port`.dump(s)
  s.objectEnd()

proc isEmpty*(self: NetworkPolicyPort): bool =
  if not self.`protocol`.isEmpty: return false
  if not self.`port`.isEmpty: return false
  true

type
  IPBlock* = object
    `except`*: seq[string]
    `cidr`*: string

proc load*(self: var IPBlock, parser: var JsonParser) =
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
          of "except":
            load(self.`except`,parser)
          of "cidr":
            load(self.`cidr`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: IPBlock, s: JsonWriter) =
  s.objectStart()
  if not self.`except`.isEmpty:
    s.name("except")
    self.`except`.dump(s)
  s.name("cidr")
  self.`cidr`.dump(s)
  s.objectEnd()

proc isEmpty*(self: IPBlock): bool =
  if not self.`except`.isEmpty: return false
  if not self.`cidr`.isEmpty: return false
  true

type
  NetworkPolicyPeer* = object
    `ipBlock`*: IPBlock
    `namespaceSelector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `podSelector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector

proc load*(self: var NetworkPolicyPeer, parser: var JsonParser) =
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
          of "ipBlock":
            load(self.`ipBlock`,parser)
          of "namespaceSelector":
            load(self.`namespaceSelector`,parser)
          of "podSelector":
            load(self.`podSelector`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: NetworkPolicyPeer, s: JsonWriter) =
  s.objectStart()
  if not self.`ipBlock`.isEmpty:
    s.name("ipBlock")
    self.`ipBlock`.dump(s)
  if not self.`namespaceSelector`.isEmpty:
    s.name("namespaceSelector")
    self.`namespaceSelector`.dump(s)
  if not self.`podSelector`.isEmpty:
    s.name("podSelector")
    self.`podSelector`.dump(s)
  s.objectEnd()

proc isEmpty*(self: NetworkPolicyPeer): bool =
  if not self.`ipBlock`.isEmpty: return false
  if not self.`namespaceSelector`.isEmpty: return false
  if not self.`podSelector`.isEmpty: return false
  true

type
  NetworkPolicyEgressRule* = object
    `ports`*: seq[NetworkPolicyPort]
    `to`*: seq[NetworkPolicyPeer]

proc load*(self: var NetworkPolicyEgressRule, parser: var JsonParser) =
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
          of "ports":
            load(self.`ports`,parser)
          of "to":
            load(self.`to`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: NetworkPolicyEgressRule, s: JsonWriter) =
  s.objectStart()
  if not self.`ports`.isEmpty:
    s.name("ports")
    self.`ports`.dump(s)
  if not self.`to`.isEmpty:
    s.name("to")
    self.`to`.dump(s)
  s.objectEnd()

proc isEmpty*(self: NetworkPolicyEgressRule): bool =
  if not self.`ports`.isEmpty: return false
  if not self.`to`.isEmpty: return false
  true

type
  NetworkPolicyIngressRule* = object
    `from`*: seq[NetworkPolicyPeer]
    `ports`*: seq[NetworkPolicyPort]

proc load*(self: var NetworkPolicyIngressRule, parser: var JsonParser) =
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
          of "from":
            load(self.`from`,parser)
          of "ports":
            load(self.`ports`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: NetworkPolicyIngressRule, s: JsonWriter) =
  s.objectStart()
  if not self.`from`.isEmpty:
    s.name("from")
    self.`from`.dump(s)
  if not self.`ports`.isEmpty:
    s.name("ports")
    self.`ports`.dump(s)
  s.objectEnd()

proc isEmpty*(self: NetworkPolicyIngressRule): bool =
  if not self.`from`.isEmpty: return false
  if not self.`ports`.isEmpty: return false
  true

type
  NetworkPolicySpec* = object
    `policyTypes`*: seq[string]
    `egress`*: seq[NetworkPolicyEgressRule]
    `ingress`*: seq[NetworkPolicyIngressRule]
    `podSelector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector

proc load*(self: var NetworkPolicySpec, parser: var JsonParser) =
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
          of "policyTypes":
            load(self.`policyTypes`,parser)
          of "egress":
            load(self.`egress`,parser)
          of "ingress":
            load(self.`ingress`,parser)
          of "podSelector":
            load(self.`podSelector`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: NetworkPolicySpec, s: JsonWriter) =
  s.objectStart()
  if not self.`policyTypes`.isEmpty:
    s.name("policyTypes")
    self.`policyTypes`.dump(s)
  if not self.`egress`.isEmpty:
    s.name("egress")
    self.`egress`.dump(s)
  if not self.`ingress`.isEmpty:
    s.name("ingress")
    self.`ingress`.dump(s)
  s.name("podSelector")
  self.`podSelector`.dump(s)
  s.objectEnd()

proc isEmpty*(self: NetworkPolicySpec): bool =
  if not self.`policyTypes`.isEmpty: return false
  if not self.`egress`.isEmpty: return false
  if not self.`ingress`.isEmpty: return false
  if not self.`podSelector`.isEmpty: return false
  true

type
  NetworkPolicy* = object
    `apiVersion`*: string
    `spec`*: NetworkPolicySpec
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var NetworkPolicy, parser: var JsonParser) =
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
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: NetworkPolicy, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("networking.k8s.io/v1")
  s.name("kind"); s.value("NetworkPolicy")
  if not self.`spec`.isEmpty:
    s.name("spec")
    self.`spec`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: NetworkPolicy): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadNetworkPolicy(parser: var JsonParser):NetworkPolicy = 
  var ret: NetworkPolicy
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[NetworkPolicy], name: string, namespace = "default"): Future[NetworkPolicy] {.async.}=
  return await client.get("/apis/networking.k8s.io/v1", t, name, namespace, loadNetworkPolicy)

proc create*(client: Client, t: NetworkPolicy, namespace = "default"): Future[NetworkPolicy] {.async.}=
  return await client.create("/apis/networking.k8s.io/v1", t, namespace, loadNetworkPolicy)

proc delete*(client: Client, t: typedesc[NetworkPolicy], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/networking.k8s.io/v1", t, name, namespace)

proc replace*(client: Client, t: NetworkPolicy, namespace = "default"): Future[NetworkPolicy] {.async.}=
  return await client.replace("/apis/networking.k8s.io/v1", t, t.metadata.name, namespace, loadNetworkPolicy)

proc watch*(client: Client, t: typedesc[NetworkPolicy], name: string, namespace = "default"): Future[FutureStream[NetworkPolicy]] {.async.}=
  return await client.watch("/apis/networking.k8s.io/v1", t, name, namespace, loadNetworkPolicy)

type
  NetworkPolicyList* = object
    `apiVersion`*: string
    `items`*: seq[NetworkPolicy]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var NetworkPolicyList, parser: var JsonParser) =
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

proc dump*(self: NetworkPolicyList, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("networking.k8s.io/v1")
  s.name("kind"); s.value("NetworkPolicyList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: NetworkPolicyList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadNetworkPolicyList(parser: var JsonParser):NetworkPolicyList = 
  var ret: NetworkPolicyList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[NetworkPolicy], namespace = "default"): Future[seq[NetworkPolicy]] {.async.}=
  return (await client.list("/apis/networking.k8s.io/v1", NetworkPolicyList, namespace, loadNetworkPolicyList)).items
