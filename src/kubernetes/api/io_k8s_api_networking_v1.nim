import ../client
import ../base_types
import parsejson
import streams
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

proc dump*(self: NetworkPolicyPort, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`protocol`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"protocol\":")
    self.`protocol`.dump(s)
  if not self.`port`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"port\":")
    self.`port`.dump(s)
  s.write("}")

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

proc dump*(self: IPBlock, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`except`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"except\":")
    self.`except`.dump(s)
  if not self.`cidr`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"cidr\":")
    self.`cidr`.dump(s)
  s.write("}")

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

proc dump*(self: NetworkPolicyPeer, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`ipBlock`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ipBlock\":")
    self.`ipBlock`.dump(s)
  if not self.`namespaceSelector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespaceSelector\":")
    self.`namespaceSelector`.dump(s)
  if not self.`podSelector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"podSelector\":")
    self.`podSelector`.dump(s)
  s.write("}")

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

proc dump*(self: NetworkPolicyEgressRule, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`ports`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ports\":")
    self.`ports`.dump(s)
  if not self.`to`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"to\":")
    self.`to`.dump(s)
  s.write("}")

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

proc dump*(self: NetworkPolicyIngressRule, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`from`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"from\":")
    self.`from`.dump(s)
  if not self.`ports`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ports\":")
    self.`ports`.dump(s)
  s.write("}")

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

proc dump*(self: NetworkPolicySpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`policyTypes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"policyTypes\":")
    self.`policyTypes`.dump(s)
  if not self.`egress`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"egress\":")
    self.`egress`.dump(s)
  if not self.`ingress`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ingress\":")
    self.`ingress`.dump(s)
  if not self.`podSelector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"podSelector\":")
    self.`podSelector`.dump(s)
  s.write("}")

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

proc dump*(self: NetworkPolicy, s: Stream) =
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
  t.apiVersion = "/apis/networking.k8s.io/v1"
  t.kind = "NetworkPolicy"
  return await client.get("/apis/networking.k8s.io/v1", t, name, namespace, loadNetworkPolicy)

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

proc dump*(self: NetworkPolicyList, s: Stream) =
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
