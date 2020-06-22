import ../client
import ../base_types
import parsejson
import ../jsonwriter
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch
import io_k8s_api_core_v1
import io_k8s_apimachinery_pkg_util_intstr
import io_k8s_apimachinery_pkg_runtime

type
  ReplicaSetCondition* = object
    `lastTransitionTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `type`*: string
    `message`*: string
    `reason`*: string
    `status`*: string

proc load*(self: var ReplicaSetCondition, parser: var JsonParser) =
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

proc dump*(self: ReplicaSetCondition, s: JsonWriter) =
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

proc isEmpty*(self: ReplicaSetCondition): bool =
  if not self.`lastTransitionTime`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

type
  ReplicaSetStatus* = object
    `fullyLabeledReplicas`*: int
    `replicas`*: int
    `observedGeneration`*: int
    `conditions`*: seq[ReplicaSetCondition]
    `readyReplicas`*: int
    `availableReplicas`*: int

proc load*(self: var ReplicaSetStatus, parser: var JsonParser) =
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
          of "fullyLabeledReplicas":
            load(self.`fullyLabeledReplicas`,parser)
          of "replicas":
            load(self.`replicas`,parser)
          of "observedGeneration":
            load(self.`observedGeneration`,parser)
          of "conditions":
            load(self.`conditions`,parser)
          of "readyReplicas":
            load(self.`readyReplicas`,parser)
          of "availableReplicas":
            load(self.`availableReplicas`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ReplicaSetStatus, s: JsonWriter) =
  s.objectStart()
  if not self.`fullyLabeledReplicas`.isEmpty:
    s.name("fullyLabeledReplicas")
    self.`fullyLabeledReplicas`.dump(s)
  s.name("replicas")
  self.`replicas`.dump(s)
  if not self.`observedGeneration`.isEmpty:
    s.name("observedGeneration")
    self.`observedGeneration`.dump(s)
  if not self.`conditions`.isEmpty:
    s.name("conditions")
    self.`conditions`.dump(s)
  if not self.`readyReplicas`.isEmpty:
    s.name("readyReplicas")
    self.`readyReplicas`.dump(s)
  if not self.`availableReplicas`.isEmpty:
    s.name("availableReplicas")
    self.`availableReplicas`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ReplicaSetStatus): bool =
  if not self.`fullyLabeledReplicas`.isEmpty: return false
  if not self.`replicas`.isEmpty: return false
  if not self.`observedGeneration`.isEmpty: return false
  if not self.`conditions`.isEmpty: return false
  if not self.`readyReplicas`.isEmpty: return false
  if not self.`availableReplicas`.isEmpty: return false
  true

type
  RollingUpdateDaemonSet* = object
    `maxUnavailable`*: io_k8s_apimachinery_pkg_util_intstr.IntOrString

proc load*(self: var RollingUpdateDaemonSet, parser: var JsonParser) =
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
          of "maxUnavailable":
            load(self.`maxUnavailable`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: RollingUpdateDaemonSet, s: JsonWriter) =
  s.objectStart()
  if not self.`maxUnavailable`.isEmpty:
    s.name("maxUnavailable")
    self.`maxUnavailable`.dump(s)
  s.objectEnd()

proc isEmpty*(self: RollingUpdateDaemonSet): bool =
  if not self.`maxUnavailable`.isEmpty: return false
  true

type
  DaemonSetUpdateStrategy* = object
    `type`*: string
    `rollingUpdate`*: RollingUpdateDaemonSet

proc load*(self: var DaemonSetUpdateStrategy, parser: var JsonParser) =
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
          of "rollingUpdate":
            load(self.`rollingUpdate`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: DaemonSetUpdateStrategy, s: JsonWriter) =
  s.objectStart()
  if not self.`type`.isEmpty:
    s.name("type")
    self.`type`.dump(s)
  if not self.`rollingUpdate`.isEmpty:
    s.name("rollingUpdate")
    self.`rollingUpdate`.dump(s)
  s.objectEnd()

proc isEmpty*(self: DaemonSetUpdateStrategy): bool =
  if not self.`type`.isEmpty: return false
  if not self.`rollingUpdate`.isEmpty: return false
  true

type
  DaemonSetSpec* = object
    `updateStrategy`*: DaemonSetUpdateStrategy
    `template`*: io_k8s_api_core_v1.PodTemplateSpec
    `selector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `minReadySeconds`*: int
    `revisionHistoryLimit`*: int

proc load*(self: var DaemonSetSpec, parser: var JsonParser) =
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
          of "updateStrategy":
            load(self.`updateStrategy`,parser)
          of "template":
            load(self.`template`,parser)
          of "selector":
            load(self.`selector`,parser)
          of "minReadySeconds":
            load(self.`minReadySeconds`,parser)
          of "revisionHistoryLimit":
            load(self.`revisionHistoryLimit`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: DaemonSetSpec, s: JsonWriter) =
  s.objectStart()
  if not self.`updateStrategy`.isEmpty:
    s.name("updateStrategy")
    self.`updateStrategy`.dump(s)
  s.name("template")
  self.`template`.dump(s)
  s.name("selector")
  self.`selector`.dump(s)
  if not self.`minReadySeconds`.isEmpty:
    s.name("minReadySeconds")
    self.`minReadySeconds`.dump(s)
  if not self.`revisionHistoryLimit`.isEmpty:
    s.name("revisionHistoryLimit")
    self.`revisionHistoryLimit`.dump(s)
  s.objectEnd()

proc isEmpty*(self: DaemonSetSpec): bool =
  if not self.`updateStrategy`.isEmpty: return false
  if not self.`template`.isEmpty: return false
  if not self.`selector`.isEmpty: return false
  if not self.`minReadySeconds`.isEmpty: return false
  if not self.`revisionHistoryLimit`.isEmpty: return false
  true

type
  DaemonSetCondition* = object
    `lastTransitionTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `type`*: string
    `message`*: string
    `reason`*: string
    `status`*: string

proc load*(self: var DaemonSetCondition, parser: var JsonParser) =
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

proc dump*(self: DaemonSetCondition, s: JsonWriter) =
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

proc isEmpty*(self: DaemonSetCondition): bool =
  if not self.`lastTransitionTime`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

type
  DaemonSetStatus* = object
    `currentNumberScheduled`*: int
    `numberAvailable`*: int
    `observedGeneration`*: int
    `collisionCount`*: int
    `numberMisscheduled`*: int
    `desiredNumberScheduled`*: int
    `numberReady`*: int
    `updatedNumberScheduled`*: int
    `conditions`*: seq[DaemonSetCondition]
    `numberUnavailable`*: int

proc load*(self: var DaemonSetStatus, parser: var JsonParser) =
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
          of "currentNumberScheduled":
            load(self.`currentNumberScheduled`,parser)
          of "numberAvailable":
            load(self.`numberAvailable`,parser)
          of "observedGeneration":
            load(self.`observedGeneration`,parser)
          of "collisionCount":
            load(self.`collisionCount`,parser)
          of "numberMisscheduled":
            load(self.`numberMisscheduled`,parser)
          of "desiredNumberScheduled":
            load(self.`desiredNumberScheduled`,parser)
          of "numberReady":
            load(self.`numberReady`,parser)
          of "updatedNumberScheduled":
            load(self.`updatedNumberScheduled`,parser)
          of "conditions":
            load(self.`conditions`,parser)
          of "numberUnavailable":
            load(self.`numberUnavailable`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: DaemonSetStatus, s: JsonWriter) =
  s.objectStart()
  s.name("currentNumberScheduled")
  self.`currentNumberScheduled`.dump(s)
  if not self.`numberAvailable`.isEmpty:
    s.name("numberAvailable")
    self.`numberAvailable`.dump(s)
  if not self.`observedGeneration`.isEmpty:
    s.name("observedGeneration")
    self.`observedGeneration`.dump(s)
  if not self.`collisionCount`.isEmpty:
    s.name("collisionCount")
    self.`collisionCount`.dump(s)
  s.name("numberMisscheduled")
  self.`numberMisscheduled`.dump(s)
  s.name("desiredNumberScheduled")
  self.`desiredNumberScheduled`.dump(s)
  s.name("numberReady")
  self.`numberReady`.dump(s)
  if not self.`updatedNumberScheduled`.isEmpty:
    s.name("updatedNumberScheduled")
    self.`updatedNumberScheduled`.dump(s)
  if not self.`conditions`.isEmpty:
    s.name("conditions")
    self.`conditions`.dump(s)
  if not self.`numberUnavailable`.isEmpty:
    s.name("numberUnavailable")
    self.`numberUnavailable`.dump(s)
  s.objectEnd()

proc isEmpty*(self: DaemonSetStatus): bool =
  if not self.`currentNumberScheduled`.isEmpty: return false
  if not self.`numberAvailable`.isEmpty: return false
  if not self.`observedGeneration`.isEmpty: return false
  if not self.`collisionCount`.isEmpty: return false
  if not self.`numberMisscheduled`.isEmpty: return false
  if not self.`desiredNumberScheduled`.isEmpty: return false
  if not self.`numberReady`.isEmpty: return false
  if not self.`updatedNumberScheduled`.isEmpty: return false
  if not self.`conditions`.isEmpty: return false
  if not self.`numberUnavailable`.isEmpty: return false
  true

type
  DaemonSet* = object
    `apiVersion`*: string
    `spec`*: DaemonSetSpec
    `status`*: DaemonSetStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var DaemonSet, parser: var JsonParser) =
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

proc dump*(self: DaemonSet, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("apps/v1")
  s.name("kind"); s.value("DaemonSet")
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

proc isEmpty*(self: DaemonSet): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[DaemonSet], name: string, namespace = "default"): Future[DaemonSet] {.async.}=
  return await client.get("/apis/apps/v1", t, name, namespace)

proc create*(client: Client, t: DaemonSet, namespace = "default"): Future[DaemonSet] {.async.}=
  return await client.create("/apis/apps/v1", t, namespace)

proc delete*(client: Client, t: typedesc[DaemonSet], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/apps/v1", t, name, namespace)

proc replace*(client: Client, t: DaemonSet, namespace = "default"): Future[DaemonSet] {.async.}=
  return await client.replace("/apis/apps/v1", t, t.metadata.name, namespace)

proc watch*(client: Client, t: typedesc[DaemonSet], name: string, namespace = "default"): Future[FutureStream[WatchEv[DaemonSet]]] {.async.}=
  return await client.watch("/apis/apps/v1", t, name, namespace)

type
  RollingUpdateStatefulSetStrategy* = object
    `partition`*: int

proc load*(self: var RollingUpdateStatefulSetStrategy, parser: var JsonParser) =
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
          of "partition":
            load(self.`partition`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: RollingUpdateStatefulSetStrategy, s: JsonWriter) =
  s.objectStart()
  if not self.`partition`.isEmpty:
    s.name("partition")
    self.`partition`.dump(s)
  s.objectEnd()

proc isEmpty*(self: RollingUpdateStatefulSetStrategy): bool =
  if not self.`partition`.isEmpty: return false
  true

type
  StatefulSetUpdateStrategy* = object
    `type`*: string
    `rollingUpdate`*: RollingUpdateStatefulSetStrategy

proc load*(self: var StatefulSetUpdateStrategy, parser: var JsonParser) =
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
          of "rollingUpdate":
            load(self.`rollingUpdate`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: StatefulSetUpdateStrategy, s: JsonWriter) =
  s.objectStart()
  if not self.`type`.isEmpty:
    s.name("type")
    self.`type`.dump(s)
  if not self.`rollingUpdate`.isEmpty:
    s.name("rollingUpdate")
    self.`rollingUpdate`.dump(s)
  s.objectEnd()

proc isEmpty*(self: StatefulSetUpdateStrategy): bool =
  if not self.`type`.isEmpty: return false
  if not self.`rollingUpdate`.isEmpty: return false
  true

type
  StatefulSetSpec* = object
    `serviceName`*: string
    `replicas`*: int
    `updateStrategy`*: StatefulSetUpdateStrategy
    `template`*: io_k8s_api_core_v1.PodTemplateSpec
    `podManagementPolicy`*: string
    `selector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `volumeClaimTemplates`*: seq[io_k8s_api_core_v1.PersistentVolumeClaim]
    `revisionHistoryLimit`*: int

proc load*(self: var StatefulSetSpec, parser: var JsonParser) =
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
          of "serviceName":
            load(self.`serviceName`,parser)
          of "replicas":
            load(self.`replicas`,parser)
          of "updateStrategy":
            load(self.`updateStrategy`,parser)
          of "template":
            load(self.`template`,parser)
          of "podManagementPolicy":
            load(self.`podManagementPolicy`,parser)
          of "selector":
            load(self.`selector`,parser)
          of "volumeClaimTemplates":
            load(self.`volumeClaimTemplates`,parser)
          of "revisionHistoryLimit":
            load(self.`revisionHistoryLimit`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: StatefulSetSpec, s: JsonWriter) =
  s.objectStart()
  s.name("serviceName")
  self.`serviceName`.dump(s)
  if not self.`replicas`.isEmpty:
    s.name("replicas")
    self.`replicas`.dump(s)
  if not self.`updateStrategy`.isEmpty:
    s.name("updateStrategy")
    self.`updateStrategy`.dump(s)
  s.name("template")
  self.`template`.dump(s)
  if not self.`podManagementPolicy`.isEmpty:
    s.name("podManagementPolicy")
    self.`podManagementPolicy`.dump(s)
  s.name("selector")
  self.`selector`.dump(s)
  if not self.`volumeClaimTemplates`.isEmpty:
    s.name("volumeClaimTemplates")
    self.`volumeClaimTemplates`.dump(s)
  if not self.`revisionHistoryLimit`.isEmpty:
    s.name("revisionHistoryLimit")
    self.`revisionHistoryLimit`.dump(s)
  s.objectEnd()

proc isEmpty*(self: StatefulSetSpec): bool =
  if not self.`serviceName`.isEmpty: return false
  if not self.`replicas`.isEmpty: return false
  if not self.`updateStrategy`.isEmpty: return false
  if not self.`template`.isEmpty: return false
  if not self.`podManagementPolicy`.isEmpty: return false
  if not self.`selector`.isEmpty: return false
  if not self.`volumeClaimTemplates`.isEmpty: return false
  if not self.`revisionHistoryLimit`.isEmpty: return false
  true

type
  StatefulSetCondition* = object
    `lastTransitionTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `type`*: string
    `message`*: string
    `reason`*: string
    `status`*: string

proc load*(self: var StatefulSetCondition, parser: var JsonParser) =
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

proc dump*(self: StatefulSetCondition, s: JsonWriter) =
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

proc isEmpty*(self: StatefulSetCondition): bool =
  if not self.`lastTransitionTime`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

type
  StatefulSetStatus* = object
    `replicas`*: int
    `currentRevision`*: string
    `observedGeneration`*: int
    `collisionCount`*: int
    `updateRevision`*: string
    `conditions`*: seq[StatefulSetCondition]
    `updatedReplicas`*: int
    `readyReplicas`*: int
    `currentReplicas`*: int

proc load*(self: var StatefulSetStatus, parser: var JsonParser) =
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
          of "currentRevision":
            load(self.`currentRevision`,parser)
          of "observedGeneration":
            load(self.`observedGeneration`,parser)
          of "collisionCount":
            load(self.`collisionCount`,parser)
          of "updateRevision":
            load(self.`updateRevision`,parser)
          of "conditions":
            load(self.`conditions`,parser)
          of "updatedReplicas":
            load(self.`updatedReplicas`,parser)
          of "readyReplicas":
            load(self.`readyReplicas`,parser)
          of "currentReplicas":
            load(self.`currentReplicas`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: StatefulSetStatus, s: JsonWriter) =
  s.objectStart()
  s.name("replicas")
  self.`replicas`.dump(s)
  if not self.`currentRevision`.isEmpty:
    s.name("currentRevision")
    self.`currentRevision`.dump(s)
  if not self.`observedGeneration`.isEmpty:
    s.name("observedGeneration")
    self.`observedGeneration`.dump(s)
  if not self.`collisionCount`.isEmpty:
    s.name("collisionCount")
    self.`collisionCount`.dump(s)
  if not self.`updateRevision`.isEmpty:
    s.name("updateRevision")
    self.`updateRevision`.dump(s)
  if not self.`conditions`.isEmpty:
    s.name("conditions")
    self.`conditions`.dump(s)
  if not self.`updatedReplicas`.isEmpty:
    s.name("updatedReplicas")
    self.`updatedReplicas`.dump(s)
  if not self.`readyReplicas`.isEmpty:
    s.name("readyReplicas")
    self.`readyReplicas`.dump(s)
  if not self.`currentReplicas`.isEmpty:
    s.name("currentReplicas")
    self.`currentReplicas`.dump(s)
  s.objectEnd()

proc isEmpty*(self: StatefulSetStatus): bool =
  if not self.`replicas`.isEmpty: return false
  if not self.`currentRevision`.isEmpty: return false
  if not self.`observedGeneration`.isEmpty: return false
  if not self.`collisionCount`.isEmpty: return false
  if not self.`updateRevision`.isEmpty: return false
  if not self.`conditions`.isEmpty: return false
  if not self.`updatedReplicas`.isEmpty: return false
  if not self.`readyReplicas`.isEmpty: return false
  if not self.`currentReplicas`.isEmpty: return false
  true

type
  StatefulSet* = object
    `apiVersion`*: string
    `spec`*: StatefulSetSpec
    `status`*: StatefulSetStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var StatefulSet, parser: var JsonParser) =
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

proc dump*(self: StatefulSet, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("apps/v1")
  s.name("kind"); s.value("StatefulSet")
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

proc isEmpty*(self: StatefulSet): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[StatefulSet], name: string, namespace = "default"): Future[StatefulSet] {.async.}=
  return await client.get("/apis/apps/v1", t, name, namespace)

proc create*(client: Client, t: StatefulSet, namespace = "default"): Future[StatefulSet] {.async.}=
  return await client.create("/apis/apps/v1", t, namespace)

proc delete*(client: Client, t: typedesc[StatefulSet], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/apps/v1", t, name, namespace)

proc replace*(client: Client, t: StatefulSet, namespace = "default"): Future[StatefulSet] {.async.}=
  return await client.replace("/apis/apps/v1", t, t.metadata.name, namespace)

proc watch*(client: Client, t: typedesc[StatefulSet], name: string, namespace = "default"): Future[FutureStream[WatchEv[StatefulSet]]] {.async.}=
  return await client.watch("/apis/apps/v1", t, name, namespace)

type
  StatefulSetList* = object
    `apiVersion`*: string
    `items`*: seq[StatefulSet]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var StatefulSetList, parser: var JsonParser) =
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

proc dump*(self: StatefulSetList, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("apps/v1")
  s.name("kind"); s.value("StatefulSetList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: StatefulSetList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc list*(client: Client, t: typedesc[StatefulSet], namespace = "default"): Future[seq[StatefulSet]] {.async.}=
  return (await client.list("/apis/apps/v1", StatefulSetList, namespace)).items

type
  ReplicaSetSpec* = object
    `replicas`*: int
    `template`*: io_k8s_api_core_v1.PodTemplateSpec
    `selector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `minReadySeconds`*: int

proc load*(self: var ReplicaSetSpec, parser: var JsonParser) =
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
          of "template":
            load(self.`template`,parser)
          of "selector":
            load(self.`selector`,parser)
          of "minReadySeconds":
            load(self.`minReadySeconds`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ReplicaSetSpec, s: JsonWriter) =
  s.objectStart()
  if not self.`replicas`.isEmpty:
    s.name("replicas")
    self.`replicas`.dump(s)
  if not self.`template`.isEmpty:
    s.name("template")
    self.`template`.dump(s)
  s.name("selector")
  self.`selector`.dump(s)
  if not self.`minReadySeconds`.isEmpty:
    s.name("minReadySeconds")
    self.`minReadySeconds`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ReplicaSetSpec): bool =
  if not self.`replicas`.isEmpty: return false
  if not self.`template`.isEmpty: return false
  if not self.`selector`.isEmpty: return false
  if not self.`minReadySeconds`.isEmpty: return false
  true

type
  ReplicaSet* = object
    `apiVersion`*: string
    `spec`*: ReplicaSetSpec
    `status`*: ReplicaSetStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var ReplicaSet, parser: var JsonParser) =
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

proc dump*(self: ReplicaSet, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("apps/v1")
  s.name("kind"); s.value("ReplicaSet")
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

proc isEmpty*(self: ReplicaSet): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[ReplicaSet], name: string, namespace = "default"): Future[ReplicaSet] {.async.}=
  return await client.get("/apis/apps/v1", t, name, namespace)

proc create*(client: Client, t: ReplicaSet, namespace = "default"): Future[ReplicaSet] {.async.}=
  return await client.create("/apis/apps/v1", t, namespace)

proc delete*(client: Client, t: typedesc[ReplicaSet], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/apps/v1", t, name, namespace)

proc replace*(client: Client, t: ReplicaSet, namespace = "default"): Future[ReplicaSet] {.async.}=
  return await client.replace("/apis/apps/v1", t, t.metadata.name, namespace)

proc watch*(client: Client, t: typedesc[ReplicaSet], name: string, namespace = "default"): Future[FutureStream[WatchEv[ReplicaSet]]] {.async.}=
  return await client.watch("/apis/apps/v1", t, name, namespace)

type
  ReplicaSetList* = object
    `apiVersion`*: string
    `items`*: seq[ReplicaSet]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var ReplicaSetList, parser: var JsonParser) =
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

proc dump*(self: ReplicaSetList, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("apps/v1")
  s.name("kind"); s.value("ReplicaSetList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ReplicaSetList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc list*(client: Client, t: typedesc[ReplicaSet], namespace = "default"): Future[seq[ReplicaSet]] {.async.}=
  return (await client.list("/apis/apps/v1", ReplicaSetList, namespace)).items

type
  RollingUpdateDeployment* = object
    `maxUnavailable`*: io_k8s_apimachinery_pkg_util_intstr.IntOrString
    `maxSurge`*: io_k8s_apimachinery_pkg_util_intstr.IntOrString

proc load*(self: var RollingUpdateDeployment, parser: var JsonParser) =
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
          of "maxUnavailable":
            load(self.`maxUnavailable`,parser)
          of "maxSurge":
            load(self.`maxSurge`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: RollingUpdateDeployment, s: JsonWriter) =
  s.objectStart()
  if not self.`maxUnavailable`.isEmpty:
    s.name("maxUnavailable")
    self.`maxUnavailable`.dump(s)
  if not self.`maxSurge`.isEmpty:
    s.name("maxSurge")
    self.`maxSurge`.dump(s)
  s.objectEnd()

proc isEmpty*(self: RollingUpdateDeployment): bool =
  if not self.`maxUnavailable`.isEmpty: return false
  if not self.`maxSurge`.isEmpty: return false
  true

type
  DeploymentStrategy* = object
    `type`*: string
    `rollingUpdate`*: RollingUpdateDeployment

proc load*(self: var DeploymentStrategy, parser: var JsonParser) =
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
          of "rollingUpdate":
            load(self.`rollingUpdate`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: DeploymentStrategy, s: JsonWriter) =
  s.objectStart()
  if not self.`type`.isEmpty:
    s.name("type")
    self.`type`.dump(s)
  if not self.`rollingUpdate`.isEmpty:
    s.name("rollingUpdate")
    self.`rollingUpdate`.dump(s)
  s.objectEnd()

proc isEmpty*(self: DeploymentStrategy): bool =
  if not self.`type`.isEmpty: return false
  if not self.`rollingUpdate`.isEmpty: return false
  true

type
  DeploymentSpec* = object
    `replicas`*: int
    `paused`*: bool
    `strategy`*: DeploymentStrategy
    `progressDeadlineSeconds`*: int
    `template`*: io_k8s_api_core_v1.PodTemplateSpec
    `selector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `minReadySeconds`*: int
    `revisionHistoryLimit`*: int

proc load*(self: var DeploymentSpec, parser: var JsonParser) =
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
          of "paused":
            load(self.`paused`,parser)
          of "strategy":
            load(self.`strategy`,parser)
          of "progressDeadlineSeconds":
            load(self.`progressDeadlineSeconds`,parser)
          of "template":
            load(self.`template`,parser)
          of "selector":
            load(self.`selector`,parser)
          of "minReadySeconds":
            load(self.`minReadySeconds`,parser)
          of "revisionHistoryLimit":
            load(self.`revisionHistoryLimit`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: DeploymentSpec, s: JsonWriter) =
  s.objectStart()
  if not self.`replicas`.isEmpty:
    s.name("replicas")
    self.`replicas`.dump(s)
  if not self.`paused`.isEmpty:
    s.name("paused")
    self.`paused`.dump(s)
  if not self.`strategy`.isEmpty:
    s.name("strategy")
    self.`strategy`.dump(s)
  if not self.`progressDeadlineSeconds`.isEmpty:
    s.name("progressDeadlineSeconds")
    self.`progressDeadlineSeconds`.dump(s)
  s.name("template")
  self.`template`.dump(s)
  s.name("selector")
  self.`selector`.dump(s)
  if not self.`minReadySeconds`.isEmpty:
    s.name("minReadySeconds")
    self.`minReadySeconds`.dump(s)
  if not self.`revisionHistoryLimit`.isEmpty:
    s.name("revisionHistoryLimit")
    self.`revisionHistoryLimit`.dump(s)
  s.objectEnd()

proc isEmpty*(self: DeploymentSpec): bool =
  if not self.`replicas`.isEmpty: return false
  if not self.`paused`.isEmpty: return false
  if not self.`strategy`.isEmpty: return false
  if not self.`progressDeadlineSeconds`.isEmpty: return false
  if not self.`template`.isEmpty: return false
  if not self.`selector`.isEmpty: return false
  if not self.`minReadySeconds`.isEmpty: return false
  if not self.`revisionHistoryLimit`.isEmpty: return false
  true

type
  DeploymentCondition* = object
    `lastTransitionTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `type`*: string
    `message`*: string
    `lastUpdateTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `reason`*: string
    `status`*: string

proc load*(self: var DeploymentCondition, parser: var JsonParser) =
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
          of "lastUpdateTime":
            load(self.`lastUpdateTime`,parser)
          of "reason":
            load(self.`reason`,parser)
          of "status":
            load(self.`status`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: DeploymentCondition, s: JsonWriter) =
  s.objectStart()
  if not self.`lastTransitionTime`.isEmpty:
    s.name("lastTransitionTime")
    self.`lastTransitionTime`.dump(s)
  s.name("type")
  self.`type`.dump(s)
  if not self.`message`.isEmpty:
    s.name("message")
    self.`message`.dump(s)
  if not self.`lastUpdateTime`.isEmpty:
    s.name("lastUpdateTime")
    self.`lastUpdateTime`.dump(s)
  if not self.`reason`.isEmpty:
    s.name("reason")
    self.`reason`.dump(s)
  s.name("status")
  self.`status`.dump(s)
  s.objectEnd()

proc isEmpty*(self: DeploymentCondition): bool =
  if not self.`lastTransitionTime`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`lastUpdateTime`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

type
  DeploymentStatus* = object
    `replicas`*: int
    `observedGeneration`*: int
    `collisionCount`*: int
    `conditions`*: seq[DeploymentCondition]
    `updatedReplicas`*: int
    `unavailableReplicas`*: int
    `readyReplicas`*: int
    `availableReplicas`*: int

proc load*(self: var DeploymentStatus, parser: var JsonParser) =
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
          of "observedGeneration":
            load(self.`observedGeneration`,parser)
          of "collisionCount":
            load(self.`collisionCount`,parser)
          of "conditions":
            load(self.`conditions`,parser)
          of "updatedReplicas":
            load(self.`updatedReplicas`,parser)
          of "unavailableReplicas":
            load(self.`unavailableReplicas`,parser)
          of "readyReplicas":
            load(self.`readyReplicas`,parser)
          of "availableReplicas":
            load(self.`availableReplicas`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: DeploymentStatus, s: JsonWriter) =
  s.objectStart()
  if not self.`replicas`.isEmpty:
    s.name("replicas")
    self.`replicas`.dump(s)
  if not self.`observedGeneration`.isEmpty:
    s.name("observedGeneration")
    self.`observedGeneration`.dump(s)
  if not self.`collisionCount`.isEmpty:
    s.name("collisionCount")
    self.`collisionCount`.dump(s)
  if not self.`conditions`.isEmpty:
    s.name("conditions")
    self.`conditions`.dump(s)
  if not self.`updatedReplicas`.isEmpty:
    s.name("updatedReplicas")
    self.`updatedReplicas`.dump(s)
  if not self.`unavailableReplicas`.isEmpty:
    s.name("unavailableReplicas")
    self.`unavailableReplicas`.dump(s)
  if not self.`readyReplicas`.isEmpty:
    s.name("readyReplicas")
    self.`readyReplicas`.dump(s)
  if not self.`availableReplicas`.isEmpty:
    s.name("availableReplicas")
    self.`availableReplicas`.dump(s)
  s.objectEnd()

proc isEmpty*(self: DeploymentStatus): bool =
  if not self.`replicas`.isEmpty: return false
  if not self.`observedGeneration`.isEmpty: return false
  if not self.`collisionCount`.isEmpty: return false
  if not self.`conditions`.isEmpty: return false
  if not self.`updatedReplicas`.isEmpty: return false
  if not self.`unavailableReplicas`.isEmpty: return false
  if not self.`readyReplicas`.isEmpty: return false
  if not self.`availableReplicas`.isEmpty: return false
  true

type
  Deployment* = object
    `apiVersion`*: string
    `spec`*: DeploymentSpec
    `status`*: DeploymentStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Deployment, parser: var JsonParser) =
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

proc dump*(self: Deployment, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("apps/v1")
  s.name("kind"); s.value("Deployment")
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

proc isEmpty*(self: Deployment): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[Deployment], name: string, namespace = "default"): Future[Deployment] {.async.}=
  return await client.get("/apis/apps/v1", t, name, namespace)

proc create*(client: Client, t: Deployment, namespace = "default"): Future[Deployment] {.async.}=
  return await client.create("/apis/apps/v1", t, namespace)

proc delete*(client: Client, t: typedesc[Deployment], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/apps/v1", t, name, namespace)

proc replace*(client: Client, t: Deployment, namespace = "default"): Future[Deployment] {.async.}=
  return await client.replace("/apis/apps/v1", t, t.metadata.name, namespace)

proc watch*(client: Client, t: typedesc[Deployment], name: string, namespace = "default"): Future[FutureStream[WatchEv[Deployment]]] {.async.}=
  return await client.watch("/apis/apps/v1", t, name, namespace)

type
  ControllerRevision* = object
    `apiVersion`*: string
    `data`*: io_k8s_apimachinery_pkg_runtime.RawExtension
    `kind`*: string
    `revision`*: int
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var ControllerRevision, parser: var JsonParser) =
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
          of "data":
            load(self.`data`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "revision":
            load(self.`revision`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ControllerRevision, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("apps/v1")
  s.name("kind"); s.value("ControllerRevision")
  if not self.`data`.isEmpty:
    s.name("data")
    self.`data`.dump(s)
  s.name("revision")
  self.`revision`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ControllerRevision): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`data`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`revision`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[ControllerRevision], name: string, namespace = "default"): Future[ControllerRevision] {.async.}=
  return await client.get("/apis/apps/v1", t, name, namespace)

proc create*(client: Client, t: ControllerRevision, namespace = "default"): Future[ControllerRevision] {.async.}=
  return await client.create("/apis/apps/v1", t, namespace)

proc delete*(client: Client, t: typedesc[ControllerRevision], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/apps/v1", t, name, namespace)

proc replace*(client: Client, t: ControllerRevision, namespace = "default"): Future[ControllerRevision] {.async.}=
  return await client.replace("/apis/apps/v1", t, t.metadata.name, namespace)

proc watch*(client: Client, t: typedesc[ControllerRevision], name: string, namespace = "default"): Future[FutureStream[WatchEv[ControllerRevision]]] {.async.}=
  return await client.watch("/apis/apps/v1", t, name, namespace)

type
  ControllerRevisionList* = object
    `apiVersion`*: string
    `items`*: seq[ControllerRevision]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var ControllerRevisionList, parser: var JsonParser) =
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

proc dump*(self: ControllerRevisionList, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("apps/v1")
  s.name("kind"); s.value("ControllerRevisionList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ControllerRevisionList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc list*(client: Client, t: typedesc[ControllerRevision], namespace = "default"): Future[seq[ControllerRevision]] {.async.}=
  return (await client.list("/apis/apps/v1", ControllerRevisionList, namespace)).items

type
  DeploymentList* = object
    `apiVersion`*: string
    `items`*: seq[Deployment]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var DeploymentList, parser: var JsonParser) =
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

proc dump*(self: DeploymentList, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("apps/v1")
  s.name("kind"); s.value("DeploymentList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: DeploymentList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc list*(client: Client, t: typedesc[Deployment], namespace = "default"): Future[seq[Deployment]] {.async.}=
  return (await client.list("/apis/apps/v1", DeploymentList, namespace)).items

type
  DaemonSetList* = object
    `apiVersion`*: string
    `items`*: seq[DaemonSet]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var DaemonSetList, parser: var JsonParser) =
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

proc dump*(self: DaemonSetList, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("apps/v1")
  s.name("kind"); s.value("DaemonSetList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: DaemonSetList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc list*(client: Client, t: typedesc[DaemonSet], namespace = "default"): Future[seq[DaemonSet]] {.async.}=
  return (await client.list("/apis/apps/v1", DaemonSetList, namespace)).items
