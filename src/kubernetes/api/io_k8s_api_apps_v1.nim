import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams
import io_k8s_apimachinery_pkg_apis_meta_v1
import io_k8s_apimachinery_pkg_util_intstr
import io_k8s_api_core_v1
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

proc get*(client: Client, t: typedesc[DaemonSet], name: string, namespace = "default"): Future[DaemonSet] {.async.}=
  proc unmarshal(parser: var JsonParser):DaemonSet = 
    var ret: DaemonSet
    load(ret,parser)
    return ret 
  return await client.get("/apis/apps/v1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[StatefulSet], name: string, namespace = "default"): Future[StatefulSet] {.async.}=
  proc unmarshal(parser: var JsonParser):StatefulSet = 
    var ret: StatefulSet
    load(ret,parser)
    return ret 
  return await client.get("/apis/apps/v1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[StatefulSetList], name: string, namespace = "default"): Future[StatefulSetList] {.async.}=
  proc unmarshal(parser: var JsonParser):StatefulSetList = 
    var ret: StatefulSetList
    load(ret,parser)
    return ret 
  return await client.get("/apis/apps/v1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[ReplicaSet], name: string, namespace = "default"): Future[ReplicaSet] {.async.}=
  proc unmarshal(parser: var JsonParser):ReplicaSet = 
    var ret: ReplicaSet
    load(ret,parser)
    return ret 
  return await client.get("/apis/apps/v1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[ReplicaSetList], name: string, namespace = "default"): Future[ReplicaSetList] {.async.}=
  proc unmarshal(parser: var JsonParser):ReplicaSetList = 
    var ret: ReplicaSetList
    load(ret,parser)
    return ret 
  return await client.get("/apis/apps/v1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[Deployment], name: string, namespace = "default"): Future[Deployment] {.async.}=
  proc unmarshal(parser: var JsonParser):Deployment = 
    var ret: Deployment
    load(ret,parser)
    return ret 
  return await client.get("/apis/apps/v1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[ControllerRevision], name: string, namespace = "default"): Future[ControllerRevision] {.async.}=
  proc unmarshal(parser: var JsonParser):ControllerRevision = 
    var ret: ControllerRevision
    load(ret,parser)
    return ret 
  return await client.get("/apis/apps/v1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[ControllerRevisionList], name: string, namespace = "default"): Future[ControllerRevisionList] {.async.}=
  proc unmarshal(parser: var JsonParser):ControllerRevisionList = 
    var ret: ControllerRevisionList
    load(ret,parser)
    return ret 
  return await client.get("/apis/apps/v1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[DeploymentList], name: string, namespace = "default"): Future[DeploymentList] {.async.}=
  proc unmarshal(parser: var JsonParser):DeploymentList = 
    var ret: DeploymentList
    load(ret,parser)
    return ret 
  return await client.get("/apis/apps/v1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[DaemonSetList], name: string, namespace = "default"): Future[DaemonSetList] {.async.}=
  proc unmarshal(parser: var JsonParser):DaemonSetList = 
    var ret: DaemonSetList
    load(ret,parser)
    return ret 
  return await client.get("/apis/apps/v1",t,name,namespace, unmarshal)
