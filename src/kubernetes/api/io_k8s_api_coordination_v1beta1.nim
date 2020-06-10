import ../client
import ../base_types
import parsejson
import streams
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch

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

proc dump*(self: LeaseSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`acquireTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"acquireTime\":")
    self.`acquireTime`.dump(s)
  if not self.`leaseDurationSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"leaseDurationSeconds\":")
    self.`leaseDurationSeconds`.dump(s)
  if not self.`renewTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"renewTime\":")
    self.`renewTime`.dump(s)
  if not self.`leaseTransitions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"leaseTransitions\":")
    self.`leaseTransitions`.dump(s)
  if not self.`holderIdentity`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"holderIdentity\":")
    self.`holderIdentity`.dump(s)
  s.write("}")

proc isEmpty*(self: LeaseSpec): bool =
  if not self.`acquireTime`.isEmpty: return false
  if not self.`leaseDurationSeconds`.isEmpty: return false
  if not self.`renewTime`.isEmpty: return false
  if not self.`leaseTransitions`.isEmpty: return false
  if not self.`holderIdentity`.isEmpty: return false
  true

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

proc dump*(self: Lease, s: Stream) =
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

proc isEmpty*(self: Lease): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadLease(parser: var JsonParser):Lease = 
  var ret: Lease
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Lease], name: string, namespace = "default"): Future[Lease] {.async.}=
  return await client.get("/apis/coordination.k8s.io/v1beta1", t, name, namespace, loadLease)

proc create*(client: Client, t: Lease, namespace = "default"): Future[Lease] {.async.}=
  t.apiVersion = "/apis/coordination.k8s.io/v1beta1"
  t.kind = "Lease"
  return await client.get("/apis/coordination.k8s.io/v1beta1", t, name, namespace, loadLease)

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

proc dump*(self: LeaseList, s: Stream) =
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

proc isEmpty*(self: LeaseList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadLeaseList(parser: var JsonParser):LeaseList = 
  var ret: LeaseList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[Lease], namespace = "default"): Future[seq[Lease]] {.async.}=
  return (await client.list("/apis/coordination.k8s.io/v1beta1", LeaseList, namespace, loadLeaseList)).items
