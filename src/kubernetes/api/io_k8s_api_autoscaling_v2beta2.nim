import ../client
import ../base_types
import parsejson
import ../jsonstream
import io_k8s_apimachinery_pkg_api_resource
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

proc dump*(self: CrossVersionObjectReference, s: JsonStream) =
  s.objectStart()
  if not self.`apiVersion`.isEmpty:
    s.name("apiVersion")
    self.`apiVersion`.dump(s)
  s.name("name")
  self.`name`.dump(s)
  s.name("kind")
  self.`kind`.dump(s)
  s.objectEnd()

proc isEmpty*(self: CrossVersionObjectReference): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

type
  MetricValueStatus* = object
    `averageValue`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `value`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `averageUtilization`*: int

proc load*(self: var MetricValueStatus, parser: var JsonParser) =
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
          of "averageValue":
            load(self.`averageValue`,parser)
          of "value":
            load(self.`value`,parser)
          of "averageUtilization":
            load(self.`averageUtilization`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: MetricValueStatus, s: JsonStream) =
  s.objectStart()
  if not self.`averageValue`.isEmpty:
    s.name("averageValue")
    self.`averageValue`.dump(s)
  if not self.`value`.isEmpty:
    s.name("value")
    self.`value`.dump(s)
  if not self.`averageUtilization`.isEmpty:
    s.name("averageUtilization")
    self.`averageUtilization`.dump(s)
  s.objectEnd()

proc isEmpty*(self: MetricValueStatus): bool =
  if not self.`averageValue`.isEmpty: return false
  if not self.`value`.isEmpty: return false
  if not self.`averageUtilization`.isEmpty: return false
  true

type
  MetricIdentifier* = object
    `selector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `name`*: string

proc load*(self: var MetricIdentifier, parser: var JsonParser) =
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
          of "selector":
            load(self.`selector`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: MetricIdentifier, s: JsonStream) =
  s.objectStart()
  if not self.`selector`.isEmpty:
    s.name("selector")
    self.`selector`.dump(s)
  s.name("name")
  self.`name`.dump(s)
  s.objectEnd()

proc isEmpty*(self: MetricIdentifier): bool =
  if not self.`selector`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

type
  ObjectMetricStatus* = object
    `describedObject`*: CrossVersionObjectReference
    `current`*: MetricValueStatus
    `metric`*: MetricIdentifier

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
          of "describedObject":
            load(self.`describedObject`,parser)
          of "current":
            load(self.`current`,parser)
          of "metric":
            load(self.`metric`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ObjectMetricStatus, s: JsonStream) =
  s.objectStart()
  s.name("describedObject")
  self.`describedObject`.dump(s)
  s.name("current")
  self.`current`.dump(s)
  s.name("metric")
  self.`metric`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ObjectMetricStatus): bool =
  if not self.`describedObject`.isEmpty: return false
  if not self.`current`.isEmpty: return false
  if not self.`metric`.isEmpty: return false
  true

type
  ExternalMetricStatus* = object
    `current`*: MetricValueStatus
    `metric`*: MetricIdentifier

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
          of "current":
            load(self.`current`,parser)
          of "metric":
            load(self.`metric`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ExternalMetricStatus, s: JsonStream) =
  s.objectStart()
  s.name("current")
  self.`current`.dump(s)
  s.name("metric")
  self.`metric`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ExternalMetricStatus): bool =
  if not self.`current`.isEmpty: return false
  if not self.`metric`.isEmpty: return false
  true

type
  ResourceMetricStatus* = object
    `current`*: MetricValueStatus
    `name`*: string

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
          of "current":
            load(self.`current`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ResourceMetricStatus, s: JsonStream) =
  s.objectStart()
  s.name("current")
  self.`current`.dump(s)
  s.name("name")
  self.`name`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ResourceMetricStatus): bool =
  if not self.`current`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

type
  PodsMetricStatus* = object
    `current`*: MetricValueStatus
    `metric`*: MetricIdentifier

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
          of "current":
            load(self.`current`,parser)
          of "metric":
            load(self.`metric`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: PodsMetricStatus, s: JsonStream) =
  s.objectStart()
  s.name("current")
  self.`current`.dump(s)
  s.name("metric")
  self.`metric`.dump(s)
  s.objectEnd()

proc isEmpty*(self: PodsMetricStatus): bool =
  if not self.`current`.isEmpty: return false
  if not self.`metric`.isEmpty: return false
  true

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

proc dump*(self: MetricStatus, s: JsonStream) =
  s.objectStart()
  s.name("type")
  self.`type`.dump(s)
  if not self.`external`.isEmpty:
    s.name("external")
    self.`external`.dump(s)
  if not self.`resource`.isEmpty:
    s.name("resource")
    self.`resource`.dump(s)
  if not self.`object`.isEmpty:
    s.name("object")
    self.`object`.dump(s)
  if not self.`pods`.isEmpty:
    s.name("pods")
    self.`pods`.dump(s)
  s.objectEnd()

proc isEmpty*(self: MetricStatus): bool =
  if not self.`type`.isEmpty: return false
  if not self.`external`.isEmpty: return false
  if not self.`resource`.isEmpty: return false
  if not self.`object`.isEmpty: return false
  if not self.`pods`.isEmpty: return false
  true

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

proc dump*(self: HorizontalPodAutoscalerCondition, s: JsonStream) =
  s.objectStart()
  if not self.`lastTransitionTime`.isEmpty:
    s.name("lastTransitionTime")
    self.`lastTransitionTime`.dump(s)
  s.name("type")
  self.`type`.dump(s)
  if not self.`message`.isEmpty:
    s.name("message")
    self.`message`.dump(s)
  if not self.`reason`.isEmpty:
    s.name("reason")
    self.`reason`.dump(s)
  s.name("status")
  self.`status`.dump(s)
  s.objectEnd()

proc isEmpty*(self: HorizontalPodAutoscalerCondition): bool =
  if not self.`lastTransitionTime`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

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

proc dump*(self: HorizontalPodAutoscalerStatus, s: JsonStream) =
  s.objectStart()
  s.name("desiredReplicas")
  self.`desiredReplicas`.dump(s)
  if not self.`observedGeneration`.isEmpty:
    s.name("observedGeneration")
    self.`observedGeneration`.dump(s)
  if not self.`currentMetrics`.isEmpty:
    s.name("currentMetrics")
    self.`currentMetrics`.dump(s)
  if not self.`lastScaleTime`.isEmpty:
    s.name("lastScaleTime")
    self.`lastScaleTime`.dump(s)
  s.name("conditions")
  self.`conditions`.dump(s)
  s.name("currentReplicas")
  self.`currentReplicas`.dump(s)
  s.objectEnd()

proc isEmpty*(self: HorizontalPodAutoscalerStatus): bool =
  if not self.`desiredReplicas`.isEmpty: return false
  if not self.`observedGeneration`.isEmpty: return false
  if not self.`currentMetrics`.isEmpty: return false
  if not self.`lastScaleTime`.isEmpty: return false
  if not self.`conditions`.isEmpty: return false
  if not self.`currentReplicas`.isEmpty: return false
  true

type
  MetricTarget* = object
    `type`*: string
    `averageValue`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `value`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `averageUtilization`*: int

proc load*(self: var MetricTarget, parser: var JsonParser) =
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
          of "averageValue":
            load(self.`averageValue`,parser)
          of "value":
            load(self.`value`,parser)
          of "averageUtilization":
            load(self.`averageUtilization`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: MetricTarget, s: JsonStream) =
  s.objectStart()
  s.name("type")
  self.`type`.dump(s)
  if not self.`averageValue`.isEmpty:
    s.name("averageValue")
    self.`averageValue`.dump(s)
  if not self.`value`.isEmpty:
    s.name("value")
    self.`value`.dump(s)
  if not self.`averageUtilization`.isEmpty:
    s.name("averageUtilization")
    self.`averageUtilization`.dump(s)
  s.objectEnd()

proc isEmpty*(self: MetricTarget): bool =
  if not self.`type`.isEmpty: return false
  if not self.`averageValue`.isEmpty: return false
  if not self.`value`.isEmpty: return false
  if not self.`averageUtilization`.isEmpty: return false
  true

type
  ExternalMetricSource* = object
    `target`*: MetricTarget
    `metric`*: MetricIdentifier

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
          of "target":
            load(self.`target`,parser)
          of "metric":
            load(self.`metric`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ExternalMetricSource, s: JsonStream) =
  s.objectStart()
  s.name("target")
  self.`target`.dump(s)
  s.name("metric")
  self.`metric`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ExternalMetricSource): bool =
  if not self.`target`.isEmpty: return false
  if not self.`metric`.isEmpty: return false
  true

type
  ResourceMetricSource* = object
    `target`*: MetricTarget
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
          of "target":
            load(self.`target`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ResourceMetricSource, s: JsonStream) =
  s.objectStart()
  s.name("target")
  self.`target`.dump(s)
  s.name("name")
  self.`name`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ResourceMetricSource): bool =
  if not self.`target`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

type
  ObjectMetricSource* = object
    `target`*: MetricTarget
    `describedObject`*: CrossVersionObjectReference
    `metric`*: MetricIdentifier

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
          of "target":
            load(self.`target`,parser)
          of "describedObject":
            load(self.`describedObject`,parser)
          of "metric":
            load(self.`metric`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ObjectMetricSource, s: JsonStream) =
  s.objectStart()
  s.name("target")
  self.`target`.dump(s)
  s.name("describedObject")
  self.`describedObject`.dump(s)
  s.name("metric")
  self.`metric`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ObjectMetricSource): bool =
  if not self.`target`.isEmpty: return false
  if not self.`describedObject`.isEmpty: return false
  if not self.`metric`.isEmpty: return false
  true

type
  PodsMetricSource* = object
    `target`*: MetricTarget
    `metric`*: MetricIdentifier

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
          of "target":
            load(self.`target`,parser)
          of "metric":
            load(self.`metric`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: PodsMetricSource, s: JsonStream) =
  s.objectStart()
  s.name("target")
  self.`target`.dump(s)
  s.name("metric")
  self.`metric`.dump(s)
  s.objectEnd()

proc isEmpty*(self: PodsMetricSource): bool =
  if not self.`target`.isEmpty: return false
  if not self.`metric`.isEmpty: return false
  true

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

proc dump*(self: MetricSpec, s: JsonStream) =
  s.objectStart()
  s.name("type")
  self.`type`.dump(s)
  if not self.`external`.isEmpty:
    s.name("external")
    self.`external`.dump(s)
  if not self.`resource`.isEmpty:
    s.name("resource")
    self.`resource`.dump(s)
  if not self.`object`.isEmpty:
    s.name("object")
    self.`object`.dump(s)
  if not self.`pods`.isEmpty:
    s.name("pods")
    self.`pods`.dump(s)
  s.objectEnd()

proc isEmpty*(self: MetricSpec): bool =
  if not self.`type`.isEmpty: return false
  if not self.`external`.isEmpty: return false
  if not self.`resource`.isEmpty: return false
  if not self.`object`.isEmpty: return false
  if not self.`pods`.isEmpty: return false
  true

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

proc dump*(self: HorizontalPodAutoscalerSpec, s: JsonStream) =
  s.objectStart()
  if not self.`metrics`.isEmpty:
    s.name("metrics")
    self.`metrics`.dump(s)
  s.name("maxReplicas")
  self.`maxReplicas`.dump(s)
  s.name("scaleTargetRef")
  self.`scaleTargetRef`.dump(s)
  if not self.`minReplicas`.isEmpty:
    s.name("minReplicas")
    self.`minReplicas`.dump(s)
  s.objectEnd()

proc isEmpty*(self: HorizontalPodAutoscalerSpec): bool =
  if not self.`metrics`.isEmpty: return false
  if not self.`maxReplicas`.isEmpty: return false
  if not self.`scaleTargetRef`.isEmpty: return false
  if not self.`minReplicas`.isEmpty: return false
  true

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

proc dump*(self: HorizontalPodAutoscaler, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("autoscaling/v2beta2")
  s.name("kind"); s.value("HorizontalPodAutoscaler")
  if not self.`spec`.isEmpty:
    s.name("spec")
    self.`spec`.dump(s)
  if not self.`status`.isEmpty:
    s.name("status")
    self.`status`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: HorizontalPodAutoscaler): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadHorizontalPodAutoscaler(parser: var JsonParser):HorizontalPodAutoscaler = 
  var ret: HorizontalPodAutoscaler
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[HorizontalPodAutoscaler], name: string, namespace = "default"): Future[HorizontalPodAutoscaler] {.async.}=
  return await client.get("/apis/autoscaling/v2beta2", t, name, namespace, loadHorizontalPodAutoscaler)

proc create*(client: Client, t: HorizontalPodAutoscaler, namespace = "default"): Future[HorizontalPodAutoscaler] {.async.}=
  return await client.create("/apis/autoscaling/v2beta2", t, namespace, loadHorizontalPodAutoscaler)

proc delete*(client: Client, t: typedesc[HorizontalPodAutoscaler], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/autoscaling/v2beta2", t, name, namespace)

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

proc dump*(self: HorizontalPodAutoscalerList, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("autoscaling/v2beta2")
  s.name("kind"); s.value("HorizontalPodAutoscalerList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: HorizontalPodAutoscalerList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadHorizontalPodAutoscalerList(parser: var JsonParser):HorizontalPodAutoscalerList = 
  var ret: HorizontalPodAutoscalerList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[HorizontalPodAutoscaler], namespace = "default"): Future[seq[HorizontalPodAutoscaler]] {.async.}=
  return (await client.list("/apis/autoscaling/v2beta2", HorizontalPodAutoscalerList, namespace, loadHorizontalPodAutoscalerList)).items
