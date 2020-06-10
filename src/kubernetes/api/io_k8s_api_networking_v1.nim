import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams
import io_k8s_apimachinery_pkg_util_intstr
import io_k8s_apimachinery_pkg_apis_meta_v1

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

proc get*(client: Client, t: typedesc[NetworkPolicy], name: string, namespace = "default"): Future[NetworkPolicy] {.async.}=
  proc unmarshal(parser: var JsonParser):NetworkPolicy = 
    var ret: NetworkPolicy
    load(ret,parser)
    return ret 
  return await client.get("/apis/networking.k8s.io/v1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[NetworkPolicyList], name: string, namespace = "default"): Future[NetworkPolicyList] {.async.}=
  proc unmarshal(parser: var JsonParser):NetworkPolicyList = 
    var ret: NetworkPolicyList
    load(ret,parser)
    return ret 
  return await client.get("/apis/networking.k8s.io/v1",t,name,namespace, unmarshal)
