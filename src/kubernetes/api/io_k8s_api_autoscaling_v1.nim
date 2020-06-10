import ../client
import ../base_types
import parsejson
import streams
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

proc dump*(self: HorizontalPodAutoscalerSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`maxReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"maxReplicas\":")
    self.`maxReplicas`.dump(s)
  if not self.`targetCPUUtilizationPercentage`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"targetCPUUtilizationPercentage\":")
    self.`targetCPUUtilizationPercentage`.dump(s)
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
  if not self.`maxReplicas`.isEmpty: return false
  if not self.`targetCPUUtilizationPercentage`.isEmpty: return false
  if not self.`scaleTargetRef`.isEmpty: return false
  if not self.`minReplicas`.isEmpty: return false
  true

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
  if not self.`lastScaleTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastScaleTime\":")
    self.`lastScaleTime`.dump(s)
  if not self.`currentCPUUtilizationPercentage`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"currentCPUUtilizationPercentage\":")
    self.`currentCPUUtilizationPercentage`.dump(s)
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
  if not self.`lastScaleTime`.isEmpty: return false
  if not self.`currentCPUUtilizationPercentage`.isEmpty: return false
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
  return await client.get("/apis/autoscaling/v1", t, name, namespace, loadHorizontalPodAutoscaler)

proc create*(client: Client, t: HorizontalPodAutoscaler, namespace = "default"): Future[HorizontalPodAutoscaler] {.async.}=
  t.apiVersion = "/apis/autoscaling/v1"
  t.kind = "HorizontalPodAutoscaler"
  return await client.get("/apis/autoscaling/v1", t, name, namespace, loadHorizontalPodAutoscaler)

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

proc dump*(self: ScaleSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`replicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"replicas\":")
    self.`replicas`.dump(s)
  s.write("}")

proc isEmpty*(self: ScaleSpec): bool =
  if not self.`replicas`.isEmpty: return false
  true

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

proc dump*(self: ScaleStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`replicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"replicas\":")
    self.`replicas`.dump(s)
  if not self.`selector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selector\":")
    self.`selector`.dump(s)
  s.write("}")

proc isEmpty*(self: ScaleStatus): bool =
  if not self.`replicas`.isEmpty: return false
  if not self.`selector`.isEmpty: return false
  true

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

proc dump*(self: Scale, s: Stream) =
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

proc isEmpty*(self: Scale): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadScale(parser: var JsonParser):Scale = 
  var ret: Scale
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Scale], name: string, namespace = "default"): Future[Scale] {.async.}=
  return await client.get("/apis/autoscaling/v1", t, name, namespace, loadScale)

proc create*(client: Client, t: Scale, namespace = "default"): Future[Scale] {.async.}=
  t.apiVersion = "/apis/autoscaling/v1"
  t.kind = "Scale"
  return await client.get("/apis/autoscaling/v1", t, name, namespace, loadScale)

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
  return (await client.list("/apis/autoscaling/v1", HorizontalPodAutoscalerList, namespace, loadHorizontalPodAutoscalerList)).items
