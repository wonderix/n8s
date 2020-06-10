import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams
import io_k8s_apimachinery_pkg_apis_meta_v1

type
  LeaseSpec* = object
    `acquireTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.MicroTime
    `leaseDurationSeconds`*: int
    `renewTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.MicroTime
    `leaseTransitions`*: int
    `holderIdentity`*: string

proc load*(self: var LeaseSpec, parser: var JsonParser) =
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
          of "acquireTime":
            load(self.`acquireTime`,parser)
          of "leaseDurationSeconds":
            load(self.`leaseDurationSeconds`,parser)
          of "renewTime":
            load(self.`renewTime`,parser)
          of "leaseTransitions":
            load(self.`leaseTransitions`,parser)
          of "holderIdentity":
            load(self.`holderIdentity`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Lease* = object
    `apiVersion`*: string
    `spec`*: LeaseSpec
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Lease, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[Lease], name: string, namespace = "default"): Future[Lease] {.async.}=
  proc unmarshal(parser: var JsonParser):Lease = 
    var ret: Lease
    load(ret,parser)
    return ret 
  return await client.get("/apis/coordination.k8s.io/v1beta1",t,name,namespace, unmarshal)

type
  LeaseList* = object
    `apiVersion`*: string
    `items`*: seq[Lease]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var LeaseList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[LeaseList], name: string, namespace = "default"): Future[LeaseList] {.async.}=
  proc unmarshal(parser: var JsonParser):LeaseList = 
    var ret: LeaseList
    load(ret,parser)
    return ret 
  return await client.get("/apis/coordination.k8s.io/v1beta1",t,name,namespace, unmarshal)
