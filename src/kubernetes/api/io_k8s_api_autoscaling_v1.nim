import ../client
import ../base_types
import parsejson
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch

type
  CrossVersionObjectReference* = object
    `apiVersion`*: string
    `name`*: string
    `kind`*: string

proc load*(self: var CrossVersionObjectReference, parser: var JsonParser) =
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
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  HorizontalPodAutoscalerSpec* = object
    `maxReplicas`*: int
    `targetCPUUtilizationPercentage`*: int
    `scaleTargetRef`*: CrossVersionObjectReference
    `minReplicas`*: int

proc load*(self: var HorizontalPodAutoscalerSpec, parser: var JsonParser) =
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
          of "maxReplicas":
            load(self.`maxReplicas`,parser)
          of "targetCPUUtilizationPercentage":
            load(self.`targetCPUUtilizationPercentage`,parser)
          of "scaleTargetRef":
            load(self.`scaleTargetRef`,parser)
          of "minReplicas":
            load(self.`minReplicas`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  HorizontalPodAutoscalerStatus* = object
    `desiredReplicas`*: int
    `observedGeneration`*: int
    `lastScaleTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `currentCPUUtilizationPercentage`*: int
    `currentReplicas`*: int

proc load*(self: var HorizontalPodAutoscalerStatus, parser: var JsonParser) =
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
          of "desiredReplicas":
            load(self.`desiredReplicas`,parser)
          of "observedGeneration":
            load(self.`observedGeneration`,parser)
          of "lastScaleTime":
            load(self.`lastScaleTime`,parser)
          of "currentCPUUtilizationPercentage":
            load(self.`currentCPUUtilizationPercentage`,parser)
          of "currentReplicas":
            load(self.`currentReplicas`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  HorizontalPodAutoscaler* = object
    `apiVersion`*: string
    `spec`*: HorizontalPodAutoscalerSpec
    `status`*: HorizontalPodAutoscalerStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var HorizontalPodAutoscaler, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[HorizontalPodAutoscaler], name: string, namespace = "default"): Future[HorizontalPodAutoscaler] {.async.}=
  proc unmarshal(parser: var JsonParser):HorizontalPodAutoscaler = 
    var ret: HorizontalPodAutoscaler
    load(ret,parser)
    return ret 
  return await client.get("/apis/autoscaling/v1",t,name,namespace, unmarshal)

type
  ScaleSpec* = object
    `replicas`*: int

proc load*(self: var ScaleSpec, parser: var JsonParser) =
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
          of "replicas":
            load(self.`replicas`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ScaleStatus* = object
    `replicas`*: int
    `selector`*: string

proc load*(self: var ScaleStatus, parser: var JsonParser) =
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
          of "replicas":
            load(self.`replicas`,parser)
          of "selector":
            load(self.`selector`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Scale* = object
    `apiVersion`*: string
    `spec`*: ScaleSpec
    `status`*: ScaleStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Scale, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[Scale], name: string, namespace = "default"): Future[Scale] {.async.}=
  proc unmarshal(parser: var JsonParser):Scale = 
    var ret: Scale
    load(ret,parser)
    return ret 
  return await client.get("/apis/autoscaling/v1",t,name,namespace, unmarshal)

type
  HorizontalPodAutoscalerList* = object
    `apiVersion`*: string
    `items`*: seq[HorizontalPodAutoscaler]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var HorizontalPodAutoscalerList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[HorizontalPodAutoscalerList], name: string, namespace = "default"): Future[HorizontalPodAutoscalerList] {.async.}=
  proc unmarshal(parser: var JsonParser):HorizontalPodAutoscalerList = 
    var ret: HorizontalPodAutoscalerList
    load(ret,parser)
    return ret 
  return await client.get("/apis/autoscaling/v1",t,name,namespace, unmarshal)
