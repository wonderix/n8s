import ../client
import ../base_types
import parsejson
import streams
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

proc dump*(self: ReplicaSetCondition, s: Stream) =
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

proc dump*(self: ReplicaSetStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`fullyLabeledReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fullyLabeledReplicas\":")
    self.`fullyLabeledReplicas`.dump(s)
  if not self.`replicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"replicas\":")
    self.`replicas`.dump(s)
  if not self.`observedGeneration`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"observedGeneration\":")
    self.`observedGeneration`.dump(s)
  if not self.`conditions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conditions\":")
    self.`conditions`.dump(s)
  if not self.`readyReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readyReplicas\":")
    self.`readyReplicas`.dump(s)
  if not self.`availableReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"availableReplicas\":")
    self.`availableReplicas`.dump(s)
  s.write("}")

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

proc dump*(self: RollingUpdateDaemonSet, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`maxUnavailable`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"maxUnavailable\":")
    self.`maxUnavailable`.dump(s)
  s.write("}")

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

proc dump*(self: DaemonSetUpdateStrategy, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`rollingUpdate`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rollingUpdate\":")
    self.`rollingUpdate`.dump(s)
  s.write("}")

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

proc dump*(self: DaemonSetSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`updateStrategy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"updateStrategy\":")
    self.`updateStrategy`.dump(s)
  if not self.`template`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"template\":")
    self.`template`.dump(s)
  if not self.`selector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selector\":")
    self.`selector`.dump(s)
  if not self.`minReadySeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"minReadySeconds\":")
    self.`minReadySeconds`.dump(s)
  if not self.`revisionHistoryLimit`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"revisionHistoryLimit\":")
    self.`revisionHistoryLimit`.dump(s)
  s.write("}")

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

proc dump*(self: DaemonSetCondition, s: Stream) =
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

proc dump*(self: DaemonSetStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`currentNumberScheduled`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"currentNumberScheduled\":")
    self.`currentNumberScheduled`.dump(s)
  if not self.`numberAvailable`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"numberAvailable\":")
    self.`numberAvailable`.dump(s)
  if not self.`observedGeneration`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"observedGeneration\":")
    self.`observedGeneration`.dump(s)
  if not self.`collisionCount`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"collisionCount\":")
    self.`collisionCount`.dump(s)
  if not self.`numberMisscheduled`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"numberMisscheduled\":")
    self.`numberMisscheduled`.dump(s)
  if not self.`desiredNumberScheduled`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"desiredNumberScheduled\":")
    self.`desiredNumberScheduled`.dump(s)
  if not self.`numberReady`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"numberReady\":")
    self.`numberReady`.dump(s)
  if not self.`updatedNumberScheduled`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"updatedNumberScheduled\":")
    self.`updatedNumberScheduled`.dump(s)
  if not self.`conditions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conditions\":")
    self.`conditions`.dump(s)
  if not self.`numberUnavailable`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"numberUnavailable\":")
    self.`numberUnavailable`.dump(s)
  s.write("}")

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

proc dump*(self: DaemonSet, s: Stream) =
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

proc isEmpty*(self: DaemonSet): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadDaemonSet(parser: var JsonParser):DaemonSet = 
  var ret: DaemonSet
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[DaemonSet], name: string, namespace = "default"): Future[DaemonSet] {.async.}=
  return await client.get("/apis/apps/v1",t,name,namespace, loadDaemonSet)

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

proc dump*(self: RollingUpdateStatefulSetStrategy, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`partition`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"partition\":")
    self.`partition`.dump(s)
  s.write("}")

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

proc dump*(self: StatefulSetUpdateStrategy, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`rollingUpdate`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rollingUpdate\":")
    self.`rollingUpdate`.dump(s)
  s.write("}")

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

proc dump*(self: StatefulSetSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`serviceName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"serviceName\":")
    self.`serviceName`.dump(s)
  if not self.`replicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"replicas\":")
    self.`replicas`.dump(s)
  if not self.`updateStrategy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"updateStrategy\":")
    self.`updateStrategy`.dump(s)
  if not self.`template`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"template\":")
    self.`template`.dump(s)
  if not self.`podManagementPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"podManagementPolicy\":")
    self.`podManagementPolicy`.dump(s)
  if not self.`selector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selector\":")
    self.`selector`.dump(s)
  if not self.`volumeClaimTemplates`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeClaimTemplates\":")
    self.`volumeClaimTemplates`.dump(s)
  if not self.`revisionHistoryLimit`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"revisionHistoryLimit\":")
    self.`revisionHistoryLimit`.dump(s)
  s.write("}")

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

proc dump*(self: StatefulSetCondition, s: Stream) =
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

proc dump*(self: StatefulSetStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`replicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"replicas\":")
    self.`replicas`.dump(s)
  if not self.`currentRevision`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"currentRevision\":")
    self.`currentRevision`.dump(s)
  if not self.`observedGeneration`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"observedGeneration\":")
    self.`observedGeneration`.dump(s)
  if not self.`collisionCount`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"collisionCount\":")
    self.`collisionCount`.dump(s)
  if not self.`updateRevision`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"updateRevision\":")
    self.`updateRevision`.dump(s)
  if not self.`conditions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conditions\":")
    self.`conditions`.dump(s)
  if not self.`updatedReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"updatedReplicas\":")
    self.`updatedReplicas`.dump(s)
  if not self.`readyReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readyReplicas\":")
    self.`readyReplicas`.dump(s)
  if not self.`currentReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"currentReplicas\":")
    self.`currentReplicas`.dump(s)
  s.write("}")

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

proc dump*(self: StatefulSet, s: Stream) =
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

proc isEmpty*(self: StatefulSet): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadStatefulSet(parser: var JsonParser):StatefulSet = 
  var ret: StatefulSet
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[StatefulSet], name: string, namespace = "default"): Future[StatefulSet] {.async.}=
  return await client.get("/apis/apps/v1",t,name,namespace, loadStatefulSet)

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

proc dump*(self: StatefulSetList, s: Stream) =
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

proc isEmpty*(self: StatefulSetList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadStatefulSetList(parser: var JsonParser):StatefulSetList = 
  var ret: StatefulSetList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[StatefulSet], namespace = "default"): Future[seq[StatefulSet]] {.async.}=
  return (await client.list("/apis/apps/v1",StatefulSetList,namespace, loadStatefulSetList)).items

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

proc dump*(self: ReplicaSetSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`replicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"replicas\":")
    self.`replicas`.dump(s)
  if not self.`template`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"template\":")
    self.`template`.dump(s)
  if not self.`selector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selector\":")
    self.`selector`.dump(s)
  if not self.`minReadySeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"minReadySeconds\":")
    self.`minReadySeconds`.dump(s)
  s.write("}")

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

proc dump*(self: ReplicaSet, s: Stream) =
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

proc isEmpty*(self: ReplicaSet): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadReplicaSet(parser: var JsonParser):ReplicaSet = 
  var ret: ReplicaSet
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[ReplicaSet], name: string, namespace = "default"): Future[ReplicaSet] {.async.}=
  return await client.get("/apis/apps/v1",t,name,namespace, loadReplicaSet)

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

proc dump*(self: ReplicaSetList, s: Stream) =
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

proc isEmpty*(self: ReplicaSetList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadReplicaSetList(parser: var JsonParser):ReplicaSetList = 
  var ret: ReplicaSetList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[ReplicaSet], namespace = "default"): Future[seq[ReplicaSet]] {.async.}=
  return (await client.list("/apis/apps/v1",ReplicaSetList,namespace, loadReplicaSetList)).items

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

proc dump*(self: RollingUpdateDeployment, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`maxUnavailable`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"maxUnavailable\":")
    self.`maxUnavailable`.dump(s)
  if not self.`maxSurge`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"maxSurge\":")
    self.`maxSurge`.dump(s)
  s.write("}")

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

proc dump*(self: DeploymentStrategy, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`rollingUpdate`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rollingUpdate\":")
    self.`rollingUpdate`.dump(s)
  s.write("}")

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

proc dump*(self: DeploymentSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`replicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"replicas\":")
    self.`replicas`.dump(s)
  if not self.`paused`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"paused\":")
    self.`paused`.dump(s)
  if not self.`strategy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"strategy\":")
    self.`strategy`.dump(s)
  if not self.`progressDeadlineSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"progressDeadlineSeconds\":")
    self.`progressDeadlineSeconds`.dump(s)
  if not self.`template`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"template\":")
    self.`template`.dump(s)
  if not self.`selector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selector\":")
    self.`selector`.dump(s)
  if not self.`minReadySeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"minReadySeconds\":")
    self.`minReadySeconds`.dump(s)
  if not self.`revisionHistoryLimit`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"revisionHistoryLimit\":")
    self.`revisionHistoryLimit`.dump(s)
  s.write("}")

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

proc dump*(self: DeploymentCondition, s: Stream) =
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
  if not self.`lastUpdateTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastUpdateTime\":")
    self.`lastUpdateTime`.dump(s)
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

proc dump*(self: DeploymentStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`replicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"replicas\":")
    self.`replicas`.dump(s)
  if not self.`observedGeneration`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"observedGeneration\":")
    self.`observedGeneration`.dump(s)
  if not self.`collisionCount`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"collisionCount\":")
    self.`collisionCount`.dump(s)
  if not self.`conditions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conditions\":")
    self.`conditions`.dump(s)
  if not self.`updatedReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"updatedReplicas\":")
    self.`updatedReplicas`.dump(s)
  if not self.`unavailableReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"unavailableReplicas\":")
    self.`unavailableReplicas`.dump(s)
  if not self.`readyReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readyReplicas\":")
    self.`readyReplicas`.dump(s)
  if not self.`availableReplicas`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"availableReplicas\":")
    self.`availableReplicas`.dump(s)
  s.write("}")

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

proc dump*(self: Deployment, s: Stream) =
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

proc isEmpty*(self: Deployment): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadDeployment(parser: var JsonParser):Deployment = 
  var ret: Deployment
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Deployment], name: string, namespace = "default"): Future[Deployment] {.async.}=
  return await client.get("/apis/apps/v1",t,name,namespace, loadDeployment)

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

proc dump*(self: ControllerRevision, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`data`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"data\":")
    self.`data`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`revision`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"revision\":")
    self.`revision`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: ControllerRevision): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`data`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`revision`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadControllerRevision(parser: var JsonParser):ControllerRevision = 
  var ret: ControllerRevision
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[ControllerRevision], name: string, namespace = "default"): Future[ControllerRevision] {.async.}=
  return await client.get("/apis/apps/v1",t,name,namespace, loadControllerRevision)

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

proc dump*(self: ControllerRevisionList, s: Stream) =
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

proc isEmpty*(self: ControllerRevisionList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadControllerRevisionList(parser: var JsonParser):ControllerRevisionList = 
  var ret: ControllerRevisionList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[ControllerRevision], namespace = "default"): Future[seq[ControllerRevision]] {.async.}=
  return (await client.list("/apis/apps/v1",ControllerRevisionList,namespace, loadControllerRevisionList)).items

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

proc dump*(self: DeploymentList, s: Stream) =
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

proc isEmpty*(self: DeploymentList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadDeploymentList(parser: var JsonParser):DeploymentList = 
  var ret: DeploymentList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[Deployment], namespace = "default"): Future[seq[Deployment]] {.async.}=
  return (await client.list("/apis/apps/v1",DeploymentList,namespace, loadDeploymentList)).items

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

proc dump*(self: DaemonSetList, s: Stream) =
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

proc isEmpty*(self: DaemonSetList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadDaemonSetList(parser: var JsonParser):DaemonSetList = 
  var ret: DaemonSetList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[DaemonSet], namespace = "default"): Future[seq[DaemonSet]] {.async.}=
  return (await client.list("/apis/apps/v1",DaemonSetList,namespace, loadDaemonSetList)).items
