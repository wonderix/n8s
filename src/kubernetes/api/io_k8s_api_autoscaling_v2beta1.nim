import ../client
import ../base_types
import parsejson
import streams
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

proc dump*(self: CrossVersionObjectReference, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  s.write("}")

proc isEmpty*(self: CrossVersionObjectReference): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
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

proc dump*(self: HorizontalPodAutoscalerCondition, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`lastTransitionTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastTransitionTime\":")
    self.`lastTransitionTime`.dump(s)
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`message`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"message\":")
    self.`message`.dump(s)
  if not self.`reason`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"reason\":")
    self.`reason`.dump(s)
  if not self.`status`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"status\":")
    self.`status`.dump(s)
  s.write("}")

proc isEmpty*(self: HorizontalPodAutoscalerCondition): bool =
  if not self.`lastTransitionTime`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

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

proc dump*(self: ExternalMetricSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`targetAverageValue`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"targetAverageValue\":")
    self.`targetAverageValue`.dump(s)
  if not self.`targetValue`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"targetValue\":")
    self.`targetValue`.dump(s)
  if not self.`metricName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metricName\":")
    self.`metricName`.dump(s)
  if not self.`metricSelector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metricSelector\":")
    self.`metricSelector`.dump(s)
  s.write("}")

proc isEmpty*(self: ExternalMetricSource): bool =
  if not self.`targetAverageValue`.isEmpty: return false
  if not self.`targetValue`.isEmpty: return false
  if not self.`metricName`.isEmpty: return false
  if not self.`metricSelector`.isEmpty: return false
  true

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

proc dump*(self: ResourceMetricSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`targetAverageUtilization`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"targetAverageUtilization\":")
    self.`targetAverageUtilization`.dump(s)
  if not self.`targetAverageValue`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"targetAverageValue\":")
    self.`targetAverageValue`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: ResourceMetricSource): bool =
  if not self.`targetAverageUtilization`.isEmpty: return false
  if not self.`targetAverageValue`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: ObjectMetricSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`targetValue`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"targetValue\":")
    self.`targetValue`.dump(s)
  if not self.`averageValue`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"averageValue\":")
    self.`averageValue`.dump(s)
  if not self.`target`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"target\":")
    self.`target`.dump(s)
  if not self.`metricName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metricName\":")
    self.`metricName`.dump(s)
  if not self.`selector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selector\":")
    self.`selector`.dump(s)
  s.write("}")

proc isEmpty*(self: ObjectMetricSource): bool =
  if not self.`targetValue`.isEmpty: return false
  if not self.`averageValue`.isEmpty: return false
  if not self.`target`.isEmpty: return false
  if not self.`metricName`.isEmpty: return false
  if not self.`selector`.isEmpty: return false
  true

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

proc dump*(self: PodsMetricSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`targetAverageValue`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"targetAverageValue\":")
    self.`targetAverageValue`.dump(s)
  if not self.`metricName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metricName\":")
    self.`metricName`.dump(s)
  if not self.`selector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selector\":")
    self.`selector`.dump(s)
  s.write("}")

proc isEmpty*(self: PodsMetricSource): bool =
  if not self.`targetAverageValue`.isEmpty: return false
  if not self.`metricName`.isEmpty: return false
  if not self.`selector`.isEmpty: return false
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

proc dump*(self: MetricSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`external`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"external\":")
    self.`external`.dump(s)
  if not self.`resource`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resource\":")
    self.`resource`.dump(s)
  if not self.`object`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"object\":")
    self.`object`.dump(s)
  if not self.`pods`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"pods\":")
    self.`pods`.dump(s)
  s.write("}")

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

proc dump*(self: HorizontalPodAutoscalerSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`metrics`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metrics\":")
    self.`metrics`.dump(s)
  if not self.`maxReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"maxReplicas\":")
    self.`maxReplicas`.dump(s)
  if not self.`scaleTargetRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"scaleTargetRef\":")
    self.`scaleTargetRef`.dump(s)
  if not self.`minReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"minReplicas\":")
    self.`minReplicas`.dump(s)
  s.write("}")

proc isEmpty*(self: HorizontalPodAutoscalerSpec): bool =
  if not self.`metrics`.isEmpty: return false
  if not self.`maxReplicas`.isEmpty: return false
  if not self.`scaleTargetRef`.isEmpty: return false
  if not self.`minReplicas`.isEmpty: return false
  true

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

proc dump*(self: ExternalMetricStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`currentAverageValue`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"currentAverageValue\":")
    self.`currentAverageValue`.dump(s)
  if not self.`currentValue`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"currentValue\":")
    self.`currentValue`.dump(s)
  if not self.`metricName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metricName\":")
    self.`metricName`.dump(s)
  if not self.`metricSelector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metricSelector\":")
    self.`metricSelector`.dump(s)
  s.write("}")

proc isEmpty*(self: ExternalMetricStatus): bool =
  if not self.`currentAverageValue`.isEmpty: return false
  if not self.`currentValue`.isEmpty: return false
  if not self.`metricName`.isEmpty: return false
  if not self.`metricSelector`.isEmpty: return false
  true

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

proc dump*(self: ResourceMetricStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`currentAverageValue`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"currentAverageValue\":")
    self.`currentAverageValue`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`currentAverageUtilization`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"currentAverageUtilization\":")
    self.`currentAverageUtilization`.dump(s)
  s.write("}")

proc isEmpty*(self: ResourceMetricStatus): bool =
  if not self.`currentAverageValue`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`currentAverageUtilization`.isEmpty: return false
  true

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

proc dump*(self: ObjectMetricStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`currentValue`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"currentValue\":")
    self.`currentValue`.dump(s)
  if not self.`averageValue`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"averageValue\":")
    self.`averageValue`.dump(s)
  if not self.`target`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"target\":")
    self.`target`.dump(s)
  if not self.`metricName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metricName\":")
    self.`metricName`.dump(s)
  if not self.`selector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selector\":")
    self.`selector`.dump(s)
  s.write("}")

proc isEmpty*(self: ObjectMetricStatus): bool =
  if not self.`currentValue`.isEmpty: return false
  if not self.`averageValue`.isEmpty: return false
  if not self.`target`.isEmpty: return false
  if not self.`metricName`.isEmpty: return false
  if not self.`selector`.isEmpty: return false
  true

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

proc dump*(self: PodsMetricStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`currentAverageValue`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"currentAverageValue\":")
    self.`currentAverageValue`.dump(s)
  if not self.`metricName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metricName\":")
    self.`metricName`.dump(s)
  if not self.`selector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selector\":")
    self.`selector`.dump(s)
  s.write("}")

proc isEmpty*(self: PodsMetricStatus): bool =
  if not self.`currentAverageValue`.isEmpty: return false
  if not self.`metricName`.isEmpty: return false
  if not self.`selector`.isEmpty: return false
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

proc dump*(self: MetricStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`external`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"external\":")
    self.`external`.dump(s)
  if not self.`resource`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resource\":")
    self.`resource`.dump(s)
  if not self.`object`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"object\":")
    self.`object`.dump(s)
  if not self.`pods`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"pods\":")
    self.`pods`.dump(s)
  s.write("}")

proc isEmpty*(self: MetricStatus): bool =
  if not self.`type`.isEmpty: return false
  if not self.`external`.isEmpty: return false
  if not self.`resource`.isEmpty: return false
  if not self.`object`.isEmpty: return false
  if not self.`pods`.isEmpty: return false
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

proc dump*(self: HorizontalPodAutoscalerStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`desiredReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"desiredReplicas\":")
    self.`desiredReplicas`.dump(s)
  if not self.`observedGeneration`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"observedGeneration\":")
    self.`observedGeneration`.dump(s)
  if not self.`currentMetrics`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"currentMetrics\":")
    self.`currentMetrics`.dump(s)
  if not self.`lastScaleTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastScaleTime\":")
    self.`lastScaleTime`.dump(s)
  if not self.`conditions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conditions\":")
    self.`conditions`.dump(s)
  if not self.`currentReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"currentReplicas\":")
    self.`currentReplicas`.dump(s)
  s.write("}")

proc isEmpty*(self: HorizontalPodAutoscalerStatus): bool =
  if not self.`desiredReplicas`.isEmpty: return false
  if not self.`observedGeneration`.isEmpty: return false
  if not self.`currentMetrics`.isEmpty: return false
  if not self.`lastScaleTime`.isEmpty: return false
  if not self.`conditions`.isEmpty: return false
  if not self.`currentReplicas`.isEmpty: return false
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

proc dump*(self: HorizontalPodAutoscaler, s: Stream) =
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
  if not self.`status`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"status\":")
    self.`status`.dump(s)
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
  return await client.get("/apis/autoscaling/v2beta1", t, name, namespace, loadHorizontalPodAutoscaler)

proc create*(client: Client, t: HorizontalPodAutoscaler, namespace = "default"): Future[HorizontalPodAutoscaler] {.async.}=
  t.apiVersion = "/apis/autoscaling/v2beta1"
  t.kind = "HorizontalPodAutoscaler"
  return await client.get("/apis/autoscaling/v2beta1", t, name, namespace, loadHorizontalPodAutoscaler)

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

proc dump*(self: HorizontalPodAutoscalerList, s: Stream) =
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
  return (await client.list("/apis/autoscaling/v2beta1", HorizontalPodAutoscalerList, namespace, loadHorizontalPodAutoscalerList)).items
