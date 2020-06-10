import ../client
import ../base_types
import parsejson
import io_k8s_apimachinery_pkg_apis_meta_v1
import io_k8s_apimachinery_pkg_api_resource
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
  HorizontalPodAutoscalerCondition* = object
    `lastTransitionTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `type`*: string
    `message`*: string
    `reason`*: string
    `status`*: string

proc load*(self: var HorizontalPodAutoscalerCondition, parser: var JsonParser) =
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
          of "lastTransitionTime":
            load(self.`lastTransitionTime`,parser)
          of "type":
            load(self.`type`,parser)
          of "message":
            load(self.`message`,parser)
          of "reason":
            load(self.`reason`,parser)
          of "status":
            load(self.`status`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ExternalMetricSource* = object
    `targetAverageValue`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `targetValue`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `metricName`*: string
    `metricSelector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector

proc load*(self: var ExternalMetricSource, parser: var JsonParser) =
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
          of "targetAverageValue":
            load(self.`targetAverageValue`,parser)
          of "targetValue":
            load(self.`targetValue`,parser)
          of "metricName":
            load(self.`metricName`,parser)
          of "metricSelector":
            load(self.`metricSelector`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ResourceMetricSource* = object
    `targetAverageUtilization`*: int
    `targetAverageValue`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `name`*: string

proc load*(self: var ResourceMetricSource, parser: var JsonParser) =
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
          of "targetAverageUtilization":
            load(self.`targetAverageUtilization`,parser)
          of "targetAverageValue":
            load(self.`targetAverageValue`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ObjectMetricSource* = object
    `targetValue`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `averageValue`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `target`*: CrossVersionObjectReference
    `metricName`*: string
    `selector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector

proc load*(self: var ObjectMetricSource, parser: var JsonParser) =
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
          of "targetValue":
            load(self.`targetValue`,parser)
          of "averageValue":
            load(self.`averageValue`,parser)
          of "target":
            load(self.`target`,parser)
          of "metricName":
            load(self.`metricName`,parser)
          of "selector":
            load(self.`selector`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodsMetricSource* = object
    `targetAverageValue`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `metricName`*: string
    `selector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector

proc load*(self: var PodsMetricSource, parser: var JsonParser) =
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
          of "targetAverageValue":
            load(self.`targetAverageValue`,parser)
          of "metricName":
            load(self.`metricName`,parser)
          of "selector":
            load(self.`selector`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  MetricSpec* = object
    `type`*: string
    `external`*: ExternalMetricSource
    `resource`*: ResourceMetricSource
    `object`*: ObjectMetricSource
    `pods`*: PodsMetricSource

proc load*(self: var MetricSpec, parser: var JsonParser) =
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
          of "type":
            load(self.`type`,parser)
          of "external":
            load(self.`external`,parser)
          of "resource":
            load(self.`resource`,parser)
          of "object":
            load(self.`object`,parser)
          of "pods":
            load(self.`pods`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  HorizontalPodAutoscalerSpec* = object
    `metrics`*: seq[MetricSpec]
    `maxReplicas`*: int
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
          of "metrics":
            load(self.`metrics`,parser)
          of "maxReplicas":
            load(self.`maxReplicas`,parser)
          of "scaleTargetRef":
            load(self.`scaleTargetRef`,parser)
          of "minReplicas":
            load(self.`minReplicas`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ExternalMetricStatus* = object
    `currentAverageValue`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `currentValue`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `metricName`*: string
    `metricSelector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector

proc load*(self: var ExternalMetricStatus, parser: var JsonParser) =
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
          of "currentAverageValue":
            load(self.`currentAverageValue`,parser)
          of "currentValue":
            load(self.`currentValue`,parser)
          of "metricName":
            load(self.`metricName`,parser)
          of "metricSelector":
            load(self.`metricSelector`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ResourceMetricStatus* = object
    `currentAverageValue`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `name`*: string
    `currentAverageUtilization`*: int

proc load*(self: var ResourceMetricStatus, parser: var JsonParser) =
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
          of "currentAverageValue":
            load(self.`currentAverageValue`,parser)
          of "name":
            load(self.`name`,parser)
          of "currentAverageUtilization":
            load(self.`currentAverageUtilization`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ObjectMetricStatus* = object
    `currentValue`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `averageValue`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `target`*: CrossVersionObjectReference
    `metricName`*: string
    `selector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector

proc load*(self: var ObjectMetricStatus, parser: var JsonParser) =
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
          of "currentValue":
            load(self.`currentValue`,parser)
          of "averageValue":
            load(self.`averageValue`,parser)
          of "target":
            load(self.`target`,parser)
          of "metricName":
            load(self.`metricName`,parser)
          of "selector":
            load(self.`selector`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodsMetricStatus* = object
    `currentAverageValue`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `metricName`*: string
    `selector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector

proc load*(self: var PodsMetricStatus, parser: var JsonParser) =
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
          of "currentAverageValue":
            load(self.`currentAverageValue`,parser)
          of "metricName":
            load(self.`metricName`,parser)
          of "selector":
            load(self.`selector`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  MetricStatus* = object
    `type`*: string
    `external`*: ExternalMetricStatus
    `resource`*: ResourceMetricStatus
    `object`*: ObjectMetricStatus
    `pods`*: PodsMetricStatus

proc load*(self: var MetricStatus, parser: var JsonParser) =
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
          of "type":
            load(self.`type`,parser)
          of "external":
            load(self.`external`,parser)
          of "resource":
            load(self.`resource`,parser)
          of "object":
            load(self.`object`,parser)
          of "pods":
            load(self.`pods`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  HorizontalPodAutoscalerStatus* = object
    `desiredReplicas`*: int
    `observedGeneration`*: int
    `currentMetrics`*: seq[MetricStatus]
    `lastScaleTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `conditions`*: seq[HorizontalPodAutoscalerCondition]
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
          of "currentMetrics":
            load(self.`currentMetrics`,parser)
          of "lastScaleTime":
            load(self.`lastScaleTime`,parser)
          of "conditions":
            load(self.`conditions`,parser)
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
  return await client.get("/apis/autoscaling/v2beta1",t,name,namespace, unmarshal)

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
  return await client.get("/apis/autoscaling/v2beta1",t,name,namespace, unmarshal)
