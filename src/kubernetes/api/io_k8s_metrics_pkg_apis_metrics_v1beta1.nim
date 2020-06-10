import ../client
import ../base_types
import parsejson
import streams
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch
import tables
import io_k8s_apimachinery_pkg_api_resource

type
  ContainerMetrics* = object
    `usage`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity_v2]
    `name`*: string

proc load*(self: var ContainerMetrics, parser: var JsonParser) =
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
          of "usage":
            load(self.`usage`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ContainerMetrics, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`usage`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"usage\":")
    self.`usage`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: ContainerMetrics): bool =
  if not self.`usage`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

type
  PodMetrics* = object
    `timestamp`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `apiVersion`*: string
    `containers`*: seq[ContainerMetrics]
    `window`*: io_k8s_apimachinery_pkg_apis_meta_v1.Duration
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta_v2

proc load*(self: var PodMetrics, parser: var JsonParser) =
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
          of "timestamp":
            load(self.`timestamp`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "containers":
            load(self.`containers`,parser)
          of "window":
            load(self.`window`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: PodMetrics, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`timestamp`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"timestamp\":")
    self.`timestamp`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`containers`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"containers\":")
    self.`containers`.dump(s)
  if not self.`window`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"window\":")
    self.`window`.dump(s)
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

proc isEmpty*(self: PodMetrics): bool =
  if not self.`timestamp`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`containers`.isEmpty: return false
  if not self.`window`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPodMetrics(parser: var JsonParser):PodMetrics = 
  var ret: PodMetrics
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[PodMetrics], name: string, namespace = "default"): Future[PodMetrics] {.async.}=
  return await client.get("/apis/metrics.k8s.io/v1beta1",t,name,namespace, loadPodMetrics)

type
  PodMetricsList* = object
    `apiVersion`*: string
    `items`*: seq[PodMetrics]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta_v2

proc load*(self: var PodMetricsList, parser: var JsonParser) =
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

proc dump*(self: PodMetricsList, s: Stream) =
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

proc isEmpty*(self: PodMetricsList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPodMetricsList(parser: var JsonParser):PodMetricsList = 
  var ret: PodMetricsList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[PodMetrics], namespace = "default"): Future[seq[PodMetrics]] {.async.}=
  return (await client.list("/apis/metrics.k8s.io/v1beta1",PodMetricsList,namespace, loadPodMetricsList)).items

type
  NodeMetrics* = object
    `timestamp`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `apiVersion`*: string
    `usage`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity_v2]
    `window`*: io_k8s_apimachinery_pkg_apis_meta_v1.Duration
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta_v2

proc load*(self: var NodeMetrics, parser: var JsonParser) =
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
          of "timestamp":
            load(self.`timestamp`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "usage":
            load(self.`usage`,parser)
          of "window":
            load(self.`window`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: NodeMetrics, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`timestamp`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"timestamp\":")
    self.`timestamp`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`usage`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"usage\":")
    self.`usage`.dump(s)
  if not self.`window`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"window\":")
    self.`window`.dump(s)
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

proc isEmpty*(self: NodeMetrics): bool =
  if not self.`timestamp`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`usage`.isEmpty: return false
  if not self.`window`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadNodeMetrics(parser: var JsonParser):NodeMetrics = 
  var ret: NodeMetrics
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[NodeMetrics], name: string, namespace = "default"): Future[NodeMetrics] {.async.}=
  return await client.get("/apis/metrics.k8s.io/v1beta1",t,name,namespace, loadNodeMetrics)

type
  NodeMetricsList* = object
    `apiVersion`*: string
    `items`*: seq[NodeMetrics]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta_v2

proc load*(self: var NodeMetricsList, parser: var JsonParser) =
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

proc dump*(self: NodeMetricsList, s: Stream) =
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

proc isEmpty*(self: NodeMetricsList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadNodeMetricsList(parser: var JsonParser):NodeMetricsList = 
  var ret: NodeMetricsList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[NodeMetrics], namespace = "default"): Future[seq[NodeMetrics]] {.async.}=
  return (await client.list("/apis/metrics.k8s.io/v1beta1",NodeMetricsList,namespace, loadNodeMetricsList)).items
