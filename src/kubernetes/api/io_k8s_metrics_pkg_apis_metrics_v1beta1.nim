import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams
import io_k8s_apimachinery_pkg_apis_meta_v1

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

proc get*(client: Client, t: typedesc[PodMetrics], name: string, namespace = "default"): Future[PodMetrics] {.async.}=
  proc unmarshal(parser: var JsonParser):PodMetrics = 
    var ret: PodMetrics
    load(ret,parser)
    return ret 
  return await client.get("/apis/metrics.k8s.io/v1beta1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[PodMetricsList], name: string, namespace = "default"): Future[PodMetricsList] {.async.}=
  proc unmarshal(parser: var JsonParser):PodMetricsList = 
    var ret: PodMetricsList
    load(ret,parser)
    return ret 
  return await client.get("/apis/metrics.k8s.io/v1beta1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[NodeMetrics], name: string, namespace = "default"): Future[NodeMetrics] {.async.}=
  proc unmarshal(parser: var JsonParser):NodeMetrics = 
    var ret: NodeMetrics
    load(ret,parser)
    return ret 
  return await client.get("/apis/metrics.k8s.io/v1beta1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[NodeMetricsList], name: string, namespace = "default"): Future[NodeMetricsList] {.async.}=
  proc unmarshal(parser: var JsonParser):NodeMetricsList = 
    var ret: NodeMetricsList
    load(ret,parser)
    return ret 
  return await client.get("/apis/metrics.k8s.io/v1beta1",t,name,namespace, unmarshal)
