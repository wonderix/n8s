import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams
import io_k8s_apimachinery_pkg_apis_meta_v1
import io_k8s_apimachinery_pkg_util_intstr
import io_k8s_apimachinery_pkg_api_resource

type
  NodeCondition* = object
    `lastTransitionTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `type`*: string
    `message`*: string
    `reason`*: string
    `status`*: string
    `lastHeartbeatTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time

proc load*(self: var NodeCondition, parser: var JsonParser) =
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
          of "lastHeartbeatTime":
            load(self.`lastHeartbeatTime`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  NodeAddress* = object
    `type`*: string
    `address`*: string

proc load*(self: var NodeAddress, parser: var JsonParser) =
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
          of "address":
            load(self.`address`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ConfigMapNodeConfigSource* = object
    `uid`*: string
    `kubeletConfigKey`*: string
    `resourceVersion`*: string
    `namespace`*: string
    `name`*: string

proc load*(self: var ConfigMapNodeConfigSource, parser: var JsonParser) =
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
          of "uid":
            load(self.`uid`,parser)
          of "kubeletConfigKey":
            load(self.`kubeletConfigKey`,parser)
          of "resourceVersion":
            load(self.`resourceVersion`,parser)
          of "namespace":
            load(self.`namespace`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  NodeConfigSource* = object
    `configMap`*: ConfigMapNodeConfigSource

proc load*(self: var NodeConfigSource, parser: var JsonParser) =
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
          of "configMap":
            load(self.`configMap`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  NodeConfigStatus* = object
    `lastKnownGood`*: NodeConfigSource
    `error`*: string
    `active`*: NodeConfigSource
    `assigned`*: NodeConfigSource

proc load*(self: var NodeConfigStatus, parser: var JsonParser) =
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
          of "lastKnownGood":
            load(self.`lastKnownGood`,parser)
          of "error":
            load(self.`error`,parser)
          of "active":
            load(self.`active`,parser)
          of "assigned":
            load(self.`assigned`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  DaemonEndpoint* = object
    `Port`*: int

proc load*(self: var DaemonEndpoint, parser: var JsonParser) =
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
          of "Port":
            load(self.`Port`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  NodeDaemonEndpoints* = object
    `kubeletEndpoint`*: DaemonEndpoint

proc load*(self: var NodeDaemonEndpoints, parser: var JsonParser) =
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
          of "kubeletEndpoint":
            load(self.`kubeletEndpoint`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  NodeSystemInfo* = object
    `machineID`*: string
    `kernelVersion`*: string
    `osImage`*: string
    `systemUUID`*: string
    `bootID`*: string
    `containerRuntimeVersion`*: string
    `kubeletVersion`*: string
    `kubeProxyVersion`*: string
    `architecture`*: string
    `operatingSystem`*: string

proc load*(self: var NodeSystemInfo, parser: var JsonParser) =
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
          of "machineID":
            load(self.`machineID`,parser)
          of "kernelVersion":
            load(self.`kernelVersion`,parser)
          of "osImage":
            load(self.`osImage`,parser)
          of "systemUUID":
            load(self.`systemUUID`,parser)
          of "bootID":
            load(self.`bootID`,parser)
          of "containerRuntimeVersion":
            load(self.`containerRuntimeVersion`,parser)
          of "kubeletVersion":
            load(self.`kubeletVersion`,parser)
          of "kubeProxyVersion":
            load(self.`kubeProxyVersion`,parser)
          of "architecture":
            load(self.`architecture`,parser)
          of "operatingSystem":
            load(self.`operatingSystem`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  AttachedVolume* = object
    `devicePath`*: string
    `name`*: string

proc load*(self: var AttachedVolume, parser: var JsonParser) =
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
          of "devicePath":
            load(self.`devicePath`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ContainerImage* = object
    `sizeBytes`*: int
    `names`*: seq[string]

proc load*(self: var ContainerImage, parser: var JsonParser) =
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
          of "sizeBytes":
            load(self.`sizeBytes`,parser)
          of "names":
            load(self.`names`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  NodeStatus* = object
    `phase`*: string
    `allocatable`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]
    `addresses`*: seq[NodeAddress]
    `config`*: NodeConfigStatus
    `daemonEndpoints`*: NodeDaemonEndpoints
    `nodeInfo`*: NodeSystemInfo
    `volumesAttached`*: seq[AttachedVolume]
    `capacity`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]
    `volumesInUse`*: seq[string]
    `images`*: seq[ContainerImage]
    `conditions`*: seq[NodeCondition]

proc load*(self: var NodeStatus, parser: var JsonParser) =
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
          of "phase":
            load(self.`phase`,parser)
          of "allocatable":
            load(self.`allocatable`,parser)
          of "addresses":
            load(self.`addresses`,parser)
          of "config":
            load(self.`config`,parser)
          of "daemonEndpoints":
            load(self.`daemonEndpoints`,parser)
          of "nodeInfo":
            load(self.`nodeInfo`,parser)
          of "volumesAttached":
            load(self.`volumesAttached`,parser)
          of "capacity":
            load(self.`capacity`,parser)
          of "volumesInUse":
            load(self.`volumesInUse`,parser)
          of "images":
            load(self.`images`,parser)
          of "conditions":
            load(self.`conditions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  HTTPHeader* = object
    `value`*: string
    `name`*: string

proc load*(self: var HTTPHeader, parser: var JsonParser) =
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
          of "value":
            load(self.`value`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  HTTPGetAction* = object
    `path`*: string
    `httpHeaders`*: seq[HTTPHeader]
    `port`*: io_k8s_apimachinery_pkg_util_intstr.IntOrString
    `host`*: string
    `scheme`*: string

proc load*(self: var HTTPGetAction, parser: var JsonParser) =
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
          of "path":
            load(self.`path`,parser)
          of "httpHeaders":
            load(self.`httpHeaders`,parser)
          of "port":
            load(self.`port`,parser)
          of "host":
            load(self.`host`,parser)
          of "scheme":
            load(self.`scheme`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ExecAction* = object
    `command`*: seq[string]

proc load*(self: var ExecAction, parser: var JsonParser) =
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
          of "command":
            load(self.`command`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  TCPSocketAction* = object
    `port`*: io_k8s_apimachinery_pkg_util_intstr.IntOrString
    `host`*: string

proc load*(self: var TCPSocketAction, parser: var JsonParser) =
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
          of "port":
            load(self.`port`,parser)
          of "host":
            load(self.`host`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Probe* = object
    `failureThreshold`*: int
    `timeoutSeconds`*: int
    `initialDelaySeconds`*: int
    `httpGet`*: HTTPGetAction
    `exec`*: ExecAction
    `tcpSocket`*: TCPSocketAction
    `successThreshold`*: int
    `periodSeconds`*: int

proc load*(self: var Probe, parser: var JsonParser) =
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
          of "failureThreshold":
            load(self.`failureThreshold`,parser)
          of "timeoutSeconds":
            load(self.`timeoutSeconds`,parser)
          of "initialDelaySeconds":
            load(self.`initialDelaySeconds`,parser)
          of "httpGet":
            load(self.`httpGet`,parser)
          of "exec":
            load(self.`exec`,parser)
          of "tcpSocket":
            load(self.`tcpSocket`,parser)
          of "successThreshold":
            load(self.`successThreshold`,parser)
          of "periodSeconds":
            load(self.`periodSeconds`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PersistentVolumeClaimCondition* = object
    `lastTransitionTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `type`*: string
    `message`*: string
    `lastProbeTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `reason`*: string
    `status`*: string

proc load*(self: var PersistentVolumeClaimCondition, parser: var JsonParser) =
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
          of "lastProbeTime":
            load(self.`lastProbeTime`,parser)
          of "reason":
            load(self.`reason`,parser)
          of "status":
            load(self.`status`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  LocalObjectReference* = object
    `name`*: string

proc load*(self: var LocalObjectReference, parser: var JsonParser) =
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
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CSIVolumeSource* = object
    `volumeAttributes`*: Table[string,string]
    `driver`*: string
    `fsType`*: string
    `nodePublishSecretRef`*: LocalObjectReference
    `readOnly`*: bool

proc load*(self: var CSIVolumeSource, parser: var JsonParser) =
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
          of "volumeAttributes":
            load(self.`volumeAttributes`,parser)
          of "driver":
            load(self.`driver`,parser)
          of "fsType":
            load(self.`fsType`,parser)
          of "nodePublishSecretRef":
            load(self.`nodePublishSecretRef`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ConfigMapEnvSource* = object
    `name`*: string
    `optional`*: bool

proc load*(self: var ConfigMapEnvSource, parser: var JsonParser) =
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
          of "name":
            load(self.`name`,parser)
          of "optional":
            load(self.`optional`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  SecretEnvSource* = object
    `name`*: string
    `optional`*: bool

proc load*(self: var SecretEnvSource, parser: var JsonParser) =
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
          of "name":
            load(self.`name`,parser)
          of "optional":
            load(self.`optional`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  EnvFromSource* = object
    `prefix`*: string
    `configMapRef`*: ConfigMapEnvSource
    `secretRef`*: SecretEnvSource

proc load*(self: var EnvFromSource, parser: var JsonParser) =
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
          of "prefix":
            load(self.`prefix`,parser)
          of "configMapRef":
            load(self.`configMapRef`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  TopologySelectorLabelRequirement* = object
    `key`*: string
    `values`*: seq[string]

proc load*(self: var TopologySelectorLabelRequirement, parser: var JsonParser) =
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
          of "key":
            load(self.`key`,parser)
          of "values":
            load(self.`values`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  TopologySelectorTerm* = object
    `matchLabelExpressions`*: seq[TopologySelectorLabelRequirement]

proc load*(self: var TopologySelectorTerm, parser: var JsonParser) =
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
          of "matchLabelExpressions":
            load(self.`matchLabelExpressions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ObjectFieldSelector* = object
    `apiVersion`*: string
    `fieldPath`*: string

proc load*(self: var ObjectFieldSelector, parser: var JsonParser) =
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
          of "fieldPath":
            load(self.`fieldPath`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodAffinityTerm* = object
    `namespaces`*: seq[string]
    `labelSelector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `topologyKey`*: string

proc load*(self: var PodAffinityTerm, parser: var JsonParser) =
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
          of "namespaces":
            load(self.`namespaces`,parser)
          of "labelSelector":
            load(self.`labelSelector`,parser)
          of "topologyKey":
            load(self.`topologyKey`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  WeightedPodAffinityTerm* = object
    `podAffinityTerm`*: PodAffinityTerm
    `weight`*: int

proc load*(self: var WeightedPodAffinityTerm, parser: var JsonParser) =
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
          of "podAffinityTerm":
            load(self.`podAffinityTerm`,parser)
          of "weight":
            load(self.`weight`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodAntiAffinity* = object
    `preferredDuringSchedulingIgnoredDuringExecution`*: seq[WeightedPodAffinityTerm]
    `requiredDuringSchedulingIgnoredDuringExecution`*: seq[PodAffinityTerm]

proc load*(self: var PodAntiAffinity, parser: var JsonParser) =
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
          of "preferredDuringSchedulingIgnoredDuringExecution":
            load(self.`preferredDuringSchedulingIgnoredDuringExecution`,parser)
          of "requiredDuringSchedulingIgnoredDuringExecution":
            load(self.`requiredDuringSchedulingIgnoredDuringExecution`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  NodeSelectorRequirement* = object
    `key`*: string
    `values`*: seq[string]
    `operator`*: string

proc load*(self: var NodeSelectorRequirement, parser: var JsonParser) =
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
          of "key":
            load(self.`key`,parser)
          of "values":
            load(self.`values`,parser)
          of "operator":
            load(self.`operator`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  NodeSelectorTerm* = object
    `matchFields`*: seq[NodeSelectorRequirement]
    `matchExpressions`*: seq[NodeSelectorRequirement]

proc load*(self: var NodeSelectorTerm, parser: var JsonParser) =
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
          of "matchFields":
            load(self.`matchFields`,parser)
          of "matchExpressions":
            load(self.`matchExpressions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PreferredSchedulingTerm* = object
    `preference`*: NodeSelectorTerm
    `weight`*: int

proc load*(self: var PreferredSchedulingTerm, parser: var JsonParser) =
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
          of "preference":
            load(self.`preference`,parser)
          of "weight":
            load(self.`weight`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  NodeSelector* = object
    `nodeSelectorTerms`*: seq[NodeSelectorTerm]

proc load*(self: var NodeSelector, parser: var JsonParser) =
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
          of "nodeSelectorTerms":
            load(self.`nodeSelectorTerms`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  NodeAffinity* = object
    `preferredDuringSchedulingIgnoredDuringExecution`*: seq[PreferredSchedulingTerm]
    `requiredDuringSchedulingIgnoredDuringExecution`*: NodeSelector

proc load*(self: var NodeAffinity, parser: var JsonParser) =
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
          of "preferredDuringSchedulingIgnoredDuringExecution":
            load(self.`preferredDuringSchedulingIgnoredDuringExecution`,parser)
          of "requiredDuringSchedulingIgnoredDuringExecution":
            load(self.`requiredDuringSchedulingIgnoredDuringExecution`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodAffinity* = object
    `preferredDuringSchedulingIgnoredDuringExecution`*: seq[WeightedPodAffinityTerm]
    `requiredDuringSchedulingIgnoredDuringExecution`*: seq[PodAffinityTerm]

proc load*(self: var PodAffinity, parser: var JsonParser) =
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
          of "preferredDuringSchedulingIgnoredDuringExecution":
            load(self.`preferredDuringSchedulingIgnoredDuringExecution`,parser)
          of "requiredDuringSchedulingIgnoredDuringExecution":
            load(self.`requiredDuringSchedulingIgnoredDuringExecution`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Affinity* = object
    `podAntiAffinity`*: PodAntiAffinity
    `nodeAffinity`*: NodeAffinity
    `podAffinity`*: PodAffinity

proc load*(self: var Affinity, parser: var JsonParser) =
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
          of "podAntiAffinity":
            load(self.`podAntiAffinity`,parser)
          of "nodeAffinity":
            load(self.`nodeAffinity`,parser)
          of "podAffinity":
            load(self.`podAffinity`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Handler* = object
    `httpGet`*: HTTPGetAction
    `exec`*: ExecAction
    `tcpSocket`*: TCPSocketAction

proc load*(self: var Handler, parser: var JsonParser) =
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
          of "httpGet":
            load(self.`httpGet`,parser)
          of "exec":
            load(self.`exec`,parser)
          of "tcpSocket":
            load(self.`tcpSocket`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Lifecycle* = object
    `preStop`*: Handler
    `postStart`*: Handler

proc load*(self: var Lifecycle, parser: var JsonParser) =
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
          of "preStop":
            load(self.`preStop`,parser)
          of "postStart":
            load(self.`postStart`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ContainerPort* = object
    `hostPort`*: int
    `hostIP`*: string
    `protocol`*: string
    `name`*: string
    `containerPort`*: int

proc load*(self: var ContainerPort, parser: var JsonParser) =
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
          of "hostPort":
            load(self.`hostPort`,parser)
          of "hostIP":
            load(self.`hostIP`,parser)
          of "protocol":
            load(self.`protocol`,parser)
          of "name":
            load(self.`name`,parser)
          of "containerPort":
            load(self.`containerPort`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ConfigMapKeySelector* = object
    `key`*: string
    `name`*: string
    `optional`*: bool

proc load*(self: var ConfigMapKeySelector, parser: var JsonParser) =
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
          of "key":
            load(self.`key`,parser)
          of "name":
            load(self.`name`,parser)
          of "optional":
            load(self.`optional`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  SecretKeySelector* = object
    `key`*: string
    `name`*: string
    `optional`*: bool

proc load*(self: var SecretKeySelector, parser: var JsonParser) =
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
          of "key":
            load(self.`key`,parser)
          of "name":
            load(self.`name`,parser)
          of "optional":
            load(self.`optional`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ResourceFieldSelector* = object
    `divisor`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `resource`*: string
    `containerName`*: string

proc load*(self: var ResourceFieldSelector, parser: var JsonParser) =
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
          of "divisor":
            load(self.`divisor`,parser)
          of "resource":
            load(self.`resource`,parser)
          of "containerName":
            load(self.`containerName`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  EnvVarSource* = object
    `fieldRef`*: ObjectFieldSelector
    `configMapKeyRef`*: ConfigMapKeySelector
    `secretKeyRef`*: SecretKeySelector
    `resourceFieldRef`*: ResourceFieldSelector

proc load*(self: var EnvVarSource, parser: var JsonParser) =
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
          of "fieldRef":
            load(self.`fieldRef`,parser)
          of "configMapKeyRef":
            load(self.`configMapKeyRef`,parser)
          of "secretKeyRef":
            load(self.`secretKeyRef`,parser)
          of "resourceFieldRef":
            load(self.`resourceFieldRef`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  EnvVar* = object
    `value`*: string
    `name`*: string
    `valueFrom`*: EnvVarSource

proc load*(self: var EnvVar, parser: var JsonParser) =
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
          of "value":
            load(self.`value`,parser)
          of "name":
            load(self.`name`,parser)
          of "valueFrom":
            load(self.`valueFrom`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  VolumeDevice* = object
    `devicePath`*: string
    `name`*: string

proc load*(self: var VolumeDevice, parser: var JsonParser) =
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
          of "devicePath":
            load(self.`devicePath`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ResourceRequirements* = object
    `limits`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]
    `requests`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]

proc load*(self: var ResourceRequirements, parser: var JsonParser) =
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
          of "limits":
            load(self.`limits`,parser)
          of "requests":
            load(self.`requests`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  VolumeMount* = object
    `mountPropagation`*: string
    `subPathExpr`*: string
    `subPath`*: string
    `mountPath`*: string
    `name`*: string
    `readOnly`*: bool

proc load*(self: var VolumeMount, parser: var JsonParser) =
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
          of "mountPropagation":
            load(self.`mountPropagation`,parser)
          of "subPathExpr":
            load(self.`subPathExpr`,parser)
          of "subPath":
            load(self.`subPath`,parser)
          of "mountPath":
            load(self.`mountPath`,parser)
          of "name":
            load(self.`name`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  SELinuxOptions* = object
    `level`*: string
    `user`*: string
    `type`*: string
    `role`*: string

proc load*(self: var SELinuxOptions, parser: var JsonParser) =
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
          of "level":
            load(self.`level`,parser)
          of "user":
            load(self.`user`,parser)
          of "type":
            load(self.`type`,parser)
          of "role":
            load(self.`role`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Capabilities* = object
    `drop`*: seq[string]
    `add`*: seq[string]

proc load*(self: var Capabilities, parser: var JsonParser) =
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
          of "drop":
            load(self.`drop`,parser)
          of "add":
            load(self.`add`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  WindowsSecurityContextOptions* = object
    `runAsUserName`*: string
    `gmsaCredentialSpecName`*: string
    `gmsaCredentialSpec`*: string

proc load*(self: var WindowsSecurityContextOptions, parser: var JsonParser) =
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
          of "runAsUserName":
            load(self.`runAsUserName`,parser)
          of "gmsaCredentialSpecName":
            load(self.`gmsaCredentialSpecName`,parser)
          of "gmsaCredentialSpec":
            load(self.`gmsaCredentialSpec`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  SecurityContext* = object
    `readOnlyRootFilesystem`*: bool
    `allowPrivilegeEscalation`*: bool
    `procMount`*: string
    `runAsNonRoot`*: bool
    `seLinuxOptions`*: SELinuxOptions
    `runAsGroup`*: int
    `capabilities`*: Capabilities
    `privileged`*: bool
    `runAsUser`*: int
    `windowsOptions`*: WindowsSecurityContextOptions

proc load*(self: var SecurityContext, parser: var JsonParser) =
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
          of "readOnlyRootFilesystem":
            load(self.`readOnlyRootFilesystem`,parser)
          of "allowPrivilegeEscalation":
            load(self.`allowPrivilegeEscalation`,parser)
          of "procMount":
            load(self.`procMount`,parser)
          of "runAsNonRoot":
            load(self.`runAsNonRoot`,parser)
          of "seLinuxOptions":
            load(self.`seLinuxOptions`,parser)
          of "runAsGroup":
            load(self.`runAsGroup`,parser)
          of "capabilities":
            load(self.`capabilities`,parser)
          of "privileged":
            load(self.`privileged`,parser)
          of "runAsUser":
            load(self.`runAsUser`,parser)
          of "windowsOptions":
            load(self.`windowsOptions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  EphemeralContainer* = object
    `terminationMessagePolicy`*: string
    `command`*: seq[string]
    `image`*: string
    `stdinOnce`*: bool
    `lifecycle`*: Lifecycle
    `ports`*: seq[ContainerPort]
    `terminationMessagePath`*: string
    `env`*: seq[EnvVar]
    `volumeDevices`*: seq[VolumeDevice]
    `readinessProbe`*: Probe
    `tty`*: bool
    `startupProbe`*: Probe
    `resources`*: ResourceRequirements
    `imagePullPolicy`*: string
    `stdin`*: bool
    `workingDir`*: string
    `name`*: string
    `volumeMounts`*: seq[VolumeMount]
    `securityContext`*: SecurityContext
    `envFrom`*: seq[EnvFromSource]
    `livenessProbe`*: Probe
    `targetContainerName`*: string
    `args`*: seq[string]

proc load*(self: var EphemeralContainer, parser: var JsonParser) =
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
          of "terminationMessagePolicy":
            load(self.`terminationMessagePolicy`,parser)
          of "command":
            load(self.`command`,parser)
          of "image":
            load(self.`image`,parser)
          of "stdinOnce":
            load(self.`stdinOnce`,parser)
          of "lifecycle":
            load(self.`lifecycle`,parser)
          of "ports":
            load(self.`ports`,parser)
          of "terminationMessagePath":
            load(self.`terminationMessagePath`,parser)
          of "env":
            load(self.`env`,parser)
          of "volumeDevices":
            load(self.`volumeDevices`,parser)
          of "readinessProbe":
            load(self.`readinessProbe`,parser)
          of "tty":
            load(self.`tty`,parser)
          of "startupProbe":
            load(self.`startupProbe`,parser)
          of "resources":
            load(self.`resources`,parser)
          of "imagePullPolicy":
            load(self.`imagePullPolicy`,parser)
          of "stdin":
            load(self.`stdin`,parser)
          of "workingDir":
            load(self.`workingDir`,parser)
          of "name":
            load(self.`name`,parser)
          of "volumeMounts":
            load(self.`volumeMounts`,parser)
          of "securityContext":
            load(self.`securityContext`,parser)
          of "envFrom":
            load(self.`envFrom`,parser)
          of "livenessProbe":
            load(self.`livenessProbe`,parser)
          of "targetContainerName":
            load(self.`targetContainerName`,parser)
          of "args":
            load(self.`args`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodDNSConfigOption* = object
    `value`*: string
    `name`*: string

proc load*(self: var PodDNSConfigOption, parser: var JsonParser) =
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
          of "value":
            load(self.`value`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodDNSConfig* = object
    `nameservers`*: seq[string]
    `options`*: seq[PodDNSConfigOption]
    `searches`*: seq[string]

proc load*(self: var PodDNSConfig, parser: var JsonParser) =
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
          of "nameservers":
            load(self.`nameservers`,parser)
          of "options":
            load(self.`options`,parser)
          of "searches":
            load(self.`searches`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  HostAlias* = object
    `hostnames`*: seq[string]
    `ip`*: string

proc load*(self: var HostAlias, parser: var JsonParser) =
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
          of "hostnames":
            load(self.`hostnames`,parser)
          of "ip":
            load(self.`ip`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Container* = object
    `terminationMessagePolicy`*: string
    `command`*: seq[string]
    `image`*: string
    `stdinOnce`*: bool
    `lifecycle`*: Lifecycle
    `ports`*: seq[ContainerPort]
    `terminationMessagePath`*: string
    `env`*: seq[EnvVar]
    `volumeDevices`*: seq[VolumeDevice]
    `readinessProbe`*: Probe
    `tty`*: bool
    `startupProbe`*: Probe
    `resources`*: ResourceRequirements
    `imagePullPolicy`*: string
    `stdin`*: bool
    `workingDir`*: string
    `name`*: string
    `volumeMounts`*: seq[VolumeMount]
    `securityContext`*: SecurityContext
    `envFrom`*: seq[EnvFromSource]
    `livenessProbe`*: Probe
    `args`*: seq[string]

proc load*(self: var Container, parser: var JsonParser) =
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
          of "terminationMessagePolicy":
            load(self.`terminationMessagePolicy`,parser)
          of "command":
            load(self.`command`,parser)
          of "image":
            load(self.`image`,parser)
          of "stdinOnce":
            load(self.`stdinOnce`,parser)
          of "lifecycle":
            load(self.`lifecycle`,parser)
          of "ports":
            load(self.`ports`,parser)
          of "terminationMessagePath":
            load(self.`terminationMessagePath`,parser)
          of "env":
            load(self.`env`,parser)
          of "volumeDevices":
            load(self.`volumeDevices`,parser)
          of "readinessProbe":
            load(self.`readinessProbe`,parser)
          of "tty":
            load(self.`tty`,parser)
          of "startupProbe":
            load(self.`startupProbe`,parser)
          of "resources":
            load(self.`resources`,parser)
          of "imagePullPolicy":
            load(self.`imagePullPolicy`,parser)
          of "stdin":
            load(self.`stdin`,parser)
          of "workingDir":
            load(self.`workingDir`,parser)
          of "name":
            load(self.`name`,parser)
          of "volumeMounts":
            load(self.`volumeMounts`,parser)
          of "securityContext":
            load(self.`securityContext`,parser)
          of "envFrom":
            load(self.`envFrom`,parser)
          of "livenessProbe":
            load(self.`livenessProbe`,parser)
          of "args":
            load(self.`args`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Toleration* = object
    `key`*: string
    `effect`*: string
    `operator`*: string
    `value`*: string
    `tolerationSeconds`*: int

proc load*(self: var Toleration, parser: var JsonParser) =
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
          of "key":
            load(self.`key`,parser)
          of "effect":
            load(self.`effect`,parser)
          of "operator":
            load(self.`operator`,parser)
          of "value":
            load(self.`value`,parser)
          of "tolerationSeconds":
            load(self.`tolerationSeconds`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodReadinessGate* = object
    `conditionType`*: string

proc load*(self: var PodReadinessGate, parser: var JsonParser) =
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
          of "conditionType":
            load(self.`conditionType`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Sysctl* = object
    `value`*: string
    `name`*: string

proc load*(self: var Sysctl, parser: var JsonParser) =
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
          of "value":
            load(self.`value`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodSecurityContext* = object
    `fsGroup`*: int
    `supplementalGroups`*: seq[int]
    `sysctls`*: seq[Sysctl]
    `runAsNonRoot`*: bool
    `seLinuxOptions`*: SELinuxOptions
    `runAsGroup`*: int
    `windowsOptions`*: WindowsSecurityContextOptions
    `runAsUser`*: int

proc load*(self: var PodSecurityContext, parser: var JsonParser) =
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
          of "fsGroup":
            load(self.`fsGroup`,parser)
          of "supplementalGroups":
            load(self.`supplementalGroups`,parser)
          of "sysctls":
            load(self.`sysctls`,parser)
          of "runAsNonRoot":
            load(self.`runAsNonRoot`,parser)
          of "seLinuxOptions":
            load(self.`seLinuxOptions`,parser)
          of "runAsGroup":
            load(self.`runAsGroup`,parser)
          of "windowsOptions":
            load(self.`windowsOptions`,parser)
          of "runAsUser":
            load(self.`runAsUser`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  TopologySpreadConstraint* = object
    `labelSelector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `maxSkew`*: int
    `whenUnsatisfiable`*: string
    `topologyKey`*: string

proc load*(self: var TopologySpreadConstraint, parser: var JsonParser) =
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
          of "labelSelector":
            load(self.`labelSelector`,parser)
          of "maxSkew":
            load(self.`maxSkew`,parser)
          of "whenUnsatisfiable":
            load(self.`whenUnsatisfiable`,parser)
          of "topologyKey":
            load(self.`topologyKey`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  VsphereVirtualDiskVolumeSource* = object
    `storagePolicyName`*: string
    `storagePolicyID`*: string
    `volumePath`*: string
    `fsType`*: string

proc load*(self: var VsphereVirtualDiskVolumeSource, parser: var JsonParser) =
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
          of "storagePolicyName":
            load(self.`storagePolicyName`,parser)
          of "storagePolicyID":
            load(self.`storagePolicyID`,parser)
          of "volumePath":
            load(self.`volumePath`,parser)
          of "fsType":
            load(self.`fsType`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  AzureFileVolumeSource* = object
    `shareName`*: string
    `secretName`*: string
    `readOnly`*: bool

proc load*(self: var AzureFileVolumeSource, parser: var JsonParser) =
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
          of "shareName":
            load(self.`shareName`,parser)
          of "secretName":
            load(self.`secretName`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  RBDVolumeSource* = object
    `user`*: string
    `monitors`*: seq[string]
    `image`*: string
    `keyring`*: string
    `fsType`*: string
    `readOnly`*: bool
    `secretRef`*: LocalObjectReference
    `pool`*: string

proc load*(self: var RBDVolumeSource, parser: var JsonParser) =
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
          of "user":
            load(self.`user`,parser)
          of "monitors":
            load(self.`monitors`,parser)
          of "image":
            load(self.`image`,parser)
          of "keyring":
            load(self.`keyring`,parser)
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
          of "pool":
            load(self.`pool`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CephFSVolumeSource* = object
    `path`*: string
    `user`*: string
    `monitors`*: seq[string]
    `secretFile`*: string
    `readOnly`*: bool
    `secretRef`*: LocalObjectReference

proc load*(self: var CephFSVolumeSource, parser: var JsonParser) =
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
          of "path":
            load(self.`path`,parser)
          of "user":
            load(self.`user`,parser)
          of "monitors":
            load(self.`monitors`,parser)
          of "secretFile":
            load(self.`secretFile`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  DownwardAPIVolumeFile* = object
    `path`*: string
    `fieldRef`*: ObjectFieldSelector
    `mode`*: int
    `resourceFieldRef`*: ResourceFieldSelector

proc load*(self: var DownwardAPIVolumeFile, parser: var JsonParser) =
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
          of "path":
            load(self.`path`,parser)
          of "fieldRef":
            load(self.`fieldRef`,parser)
          of "mode":
            load(self.`mode`,parser)
          of "resourceFieldRef":
            load(self.`resourceFieldRef`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  DownwardAPIProjection* = object
    `items`*: seq[DownwardAPIVolumeFile]

proc load*(self: var DownwardAPIProjection, parser: var JsonParser) =
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
          of "items":
            load(self.`items`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ServiceAccountTokenProjection* = object
    `path`*: string
    `expirationSeconds`*: int
    `audience`*: string

proc load*(self: var ServiceAccountTokenProjection, parser: var JsonParser) =
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
          of "path":
            load(self.`path`,parser)
          of "expirationSeconds":
            load(self.`expirationSeconds`,parser)
          of "audience":
            load(self.`audience`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  KeyToPath* = object
    `path`*: string
    `key`*: string
    `mode`*: int

proc load*(self: var KeyToPath, parser: var JsonParser) =
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
          of "path":
            load(self.`path`,parser)
          of "key":
            load(self.`key`,parser)
          of "mode":
            load(self.`mode`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  SecretProjection* = object
    `items`*: seq[KeyToPath]
    `name`*: string
    `optional`*: bool

proc load*(self: var SecretProjection, parser: var JsonParser) =
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
          of "items":
            load(self.`items`,parser)
          of "name":
            load(self.`name`,parser)
          of "optional":
            load(self.`optional`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ConfigMapProjection* = object
    `items`*: seq[KeyToPath]
    `name`*: string
    `optional`*: bool

proc load*(self: var ConfigMapProjection, parser: var JsonParser) =
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
          of "items":
            load(self.`items`,parser)
          of "name":
            load(self.`name`,parser)
          of "optional":
            load(self.`optional`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  VolumeProjection* = object
    `downwardAPI`*: DownwardAPIProjection
    `serviceAccountToken`*: ServiceAccountTokenProjection
    `secret`*: SecretProjection
    `configMap`*: ConfigMapProjection

proc load*(self: var VolumeProjection, parser: var JsonParser) =
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
          of "downwardAPI":
            load(self.`downwardAPI`,parser)
          of "serviceAccountToken":
            load(self.`serviceAccountToken`,parser)
          of "secret":
            load(self.`secret`,parser)
          of "configMap":
            load(self.`configMap`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ProjectedVolumeSource* = object
    `defaultMode`*: int
    `sources`*: seq[VolumeProjection]

proc load*(self: var ProjectedVolumeSource, parser: var JsonParser) =
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
          of "defaultMode":
            load(self.`defaultMode`,parser)
          of "sources":
            load(self.`sources`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  HostPathVolumeSource* = object
    `path`*: string
    `type`*: string

proc load*(self: var HostPathVolumeSource, parser: var JsonParser) =
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
          of "path":
            load(self.`path`,parser)
          of "type":
            load(self.`type`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  GlusterfsVolumeSource* = object
    `path`*: string
    `endpoints`*: string
    `readOnly`*: bool

proc load*(self: var GlusterfsVolumeSource, parser: var JsonParser) =
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
          of "path":
            load(self.`path`,parser)
          of "endpoints":
            load(self.`endpoints`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  GCEPersistentDiskVolumeSource* = object
    `partition`*: int
    `fsType`*: string
    `readOnly`*: bool
    `pdName`*: string

proc load*(self: var GCEPersistentDiskVolumeSource, parser: var JsonParser) =
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
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "pdName":
            load(self.`pdName`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  QuobyteVolumeSource* = object
    `user`*: string
    `registry`*: string
    `volume`*: string
    `group`*: string
    `tenant`*: string
    `readOnly`*: bool

proc load*(self: var QuobyteVolumeSource, parser: var JsonParser) =
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
          of "user":
            load(self.`user`,parser)
          of "registry":
            load(self.`registry`,parser)
          of "volume":
            load(self.`volume`,parser)
          of "group":
            load(self.`group`,parser)
          of "tenant":
            load(self.`tenant`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  NFSVolumeSource* = object
    `path`*: string
    `server`*: string
    `readOnly`*: bool

proc load*(self: var NFSVolumeSource, parser: var JsonParser) =
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
          of "path":
            load(self.`path`,parser)
          of "server":
            load(self.`server`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  EmptyDirVolumeSource* = object
    `sizeLimit`*: io_k8s_apimachinery_pkg_api_resource.Quantity
    `medium`*: string

proc load*(self: var EmptyDirVolumeSource, parser: var JsonParser) =
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
          of "sizeLimit":
            load(self.`sizeLimit`,parser)
          of "medium":
            load(self.`medium`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  FlockerVolumeSource* = object
    `datasetName`*: string
    `datasetUUID`*: string

proc load*(self: var FlockerVolumeSource, parser: var JsonParser) =
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
          of "datasetName":
            load(self.`datasetName`,parser)
          of "datasetUUID":
            load(self.`datasetUUID`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  DownwardAPIVolumeSource* = object
    `items`*: seq[DownwardAPIVolumeFile]
    `defaultMode`*: int

proc load*(self: var DownwardAPIVolumeSource, parser: var JsonParser) =
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
          of "items":
            load(self.`items`,parser)
          of "defaultMode":
            load(self.`defaultMode`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PersistentVolumeClaimVolumeSource* = object
    `claimName`*: string
    `readOnly`*: bool

proc load*(self: var PersistentVolumeClaimVolumeSource, parser: var JsonParser) =
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
          of "claimName":
            load(self.`claimName`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ScaleIOVolumeSource* = object
    `storageMode`*: string
    `volumeName`*: string
    `storagePool`*: string
    `gateway`*: string
    `fsType`*: string
    `readOnly`*: bool
    `secretRef`*: LocalObjectReference
    `system`*: string
    `sslEnabled`*: bool
    `protectionDomain`*: string

proc load*(self: var ScaleIOVolumeSource, parser: var JsonParser) =
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
          of "storageMode":
            load(self.`storageMode`,parser)
          of "volumeName":
            load(self.`volumeName`,parser)
          of "storagePool":
            load(self.`storagePool`,parser)
          of "gateway":
            load(self.`gateway`,parser)
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
          of "system":
            load(self.`system`,parser)
          of "sslEnabled":
            load(self.`sslEnabled`,parser)
          of "protectionDomain":
            load(self.`protectionDomain`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  FlexVolumeSource* = object
    `driver`*: string
    `options`*: Table[string,string]
    `fsType`*: string
    `readOnly`*: bool
    `secretRef`*: LocalObjectReference

proc load*(self: var FlexVolumeSource, parser: var JsonParser) =
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
          of "driver":
            load(self.`driver`,parser)
          of "options":
            load(self.`options`,parser)
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  SecretVolumeSource* = object
    `items`*: seq[KeyToPath]
    `secretName`*: string
    `defaultMode`*: int
    `optional`*: bool

proc load*(self: var SecretVolumeSource, parser: var JsonParser) =
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
          of "items":
            load(self.`items`,parser)
          of "secretName":
            load(self.`secretName`,parser)
          of "defaultMode":
            load(self.`defaultMode`,parser)
          of "optional":
            load(self.`optional`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ConfigMapVolumeSource* = object
    `items`*: seq[KeyToPath]
    `defaultMode`*: int
    `name`*: string
    `optional`*: bool

proc load*(self: var ConfigMapVolumeSource, parser: var JsonParser) =
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
          of "items":
            load(self.`items`,parser)
          of "defaultMode":
            load(self.`defaultMode`,parser)
          of "name":
            load(self.`name`,parser)
          of "optional":
            load(self.`optional`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PortworxVolumeSource* = object
    `fsType`*: string
    `readOnly`*: bool
    `volumeID`*: string

proc load*(self: var PortworxVolumeSource, parser: var JsonParser) =
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
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "volumeID":
            load(self.`volumeID`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  GitRepoVolumeSource* = object
    `repository`*: string
    `directory`*: string
    `revision`*: string

proc load*(self: var GitRepoVolumeSource, parser: var JsonParser) =
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
          of "repository":
            load(self.`repository`,parser)
          of "directory":
            load(self.`directory`,parser)
          of "revision":
            load(self.`revision`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  AzureDiskVolumeSource* = object
    `diskURI`*: string
    `cachingMode`*: string
    `fsType`*: string
    `readOnly`*: bool
    `diskName`*: string
    `kind`*: string

proc load*(self: var AzureDiskVolumeSource, parser: var JsonParser) =
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
          of "diskURI":
            load(self.`diskURI`,parser)
          of "cachingMode":
            load(self.`cachingMode`,parser)
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "diskName":
            load(self.`diskName`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CinderVolumeSource* = object
    `fsType`*: string
    `readOnly`*: bool
    `secretRef`*: LocalObjectReference
    `volumeID`*: string

proc load*(self: var CinderVolumeSource, parser: var JsonParser) =
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
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
          of "volumeID":
            load(self.`volumeID`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  FCVolumeSource* = object
    `lun`*: int
    `fsType`*: string
    `readOnly`*: bool
    `targetWWNs`*: seq[string]
    `wwids`*: seq[string]

proc load*(self: var FCVolumeSource, parser: var JsonParser) =
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
          of "lun":
            load(self.`lun`,parser)
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "targetWWNs":
            load(self.`targetWWNs`,parser)
          of "wwids":
            load(self.`wwids`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  StorageOSVolumeSource* = object
    `volumeName`*: string
    `fsType`*: string
    `readOnly`*: bool
    `secretRef`*: LocalObjectReference
    `volumeNamespace`*: string

proc load*(self: var StorageOSVolumeSource, parser: var JsonParser) =
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
          of "volumeName":
            load(self.`volumeName`,parser)
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
          of "volumeNamespace":
            load(self.`volumeNamespace`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  AWSElasticBlockStoreVolumeSource* = object
    `partition`*: int
    `fsType`*: string
    `readOnly`*: bool
    `volumeID`*: string

proc load*(self: var AWSElasticBlockStoreVolumeSource, parser: var JsonParser) =
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
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "volumeID":
            load(self.`volumeID`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ISCSIVolumeSource* = object
    `iqn`*: string
    `iscsiInterface`*: string
    `lun`*: int
    `fsType`*: string
    `readOnly`*: bool
    `secretRef`*: LocalObjectReference
    `chapAuthDiscovery`*: bool
    `chapAuthSession`*: bool
    `initiatorName`*: string
    `portals`*: seq[string]
    `targetPortal`*: string

proc load*(self: var ISCSIVolumeSource, parser: var JsonParser) =
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
          of "iqn":
            load(self.`iqn`,parser)
          of "iscsiInterface":
            load(self.`iscsiInterface`,parser)
          of "lun":
            load(self.`lun`,parser)
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
          of "chapAuthDiscovery":
            load(self.`chapAuthDiscovery`,parser)
          of "chapAuthSession":
            load(self.`chapAuthSession`,parser)
          of "initiatorName":
            load(self.`initiatorName`,parser)
          of "portals":
            load(self.`portals`,parser)
          of "targetPortal":
            load(self.`targetPortal`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PhotonPersistentDiskVolumeSource* = object
    `pdID`*: string
    `fsType`*: string

proc load*(self: var PhotonPersistentDiskVolumeSource, parser: var JsonParser) =
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
          of "pdID":
            load(self.`pdID`,parser)
          of "fsType":
            load(self.`fsType`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Volume* = object
    `vsphereVolume`*: VsphereVirtualDiskVolumeSource
    `azureFile`*: AzureFileVolumeSource
    `rbd`*: RBDVolumeSource
    `cephfs`*: CephFSVolumeSource
    `projected`*: ProjectedVolumeSource
    `hostPath`*: HostPathVolumeSource
    `glusterfs`*: GlusterfsVolumeSource
    `gcePersistentDisk`*: GCEPersistentDiskVolumeSource
    `quobyte`*: QuobyteVolumeSource
    `nfs`*: NFSVolumeSource
    `emptyDir`*: EmptyDirVolumeSource
    `flocker`*: FlockerVolumeSource
    `downwardAPI`*: DownwardAPIVolumeSource
    `persistentVolumeClaim`*: PersistentVolumeClaimVolumeSource
    `scaleIO`*: ScaleIOVolumeSource
    `flexVolume`*: FlexVolumeSource
    `secret`*: SecretVolumeSource
    `configMap`*: ConfigMapVolumeSource
    `portworxVolume`*: PortworxVolumeSource
    `gitRepo`*: GitRepoVolumeSource
    `azureDisk`*: AzureDiskVolumeSource
    `cinder`*: CinderVolumeSource
    `fc`*: FCVolumeSource
    `csi`*: CSIVolumeSource
    `name`*: string
    `storageos`*: StorageOSVolumeSource
    `awsElasticBlockStore`*: AWSElasticBlockStoreVolumeSource
    `iscsi`*: ISCSIVolumeSource
    `photonPersistentDisk`*: PhotonPersistentDiskVolumeSource

proc load*(self: var Volume, parser: var JsonParser) =
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
          of "vsphereVolume":
            load(self.`vsphereVolume`,parser)
          of "azureFile":
            load(self.`azureFile`,parser)
          of "rbd":
            load(self.`rbd`,parser)
          of "cephfs":
            load(self.`cephfs`,parser)
          of "projected":
            load(self.`projected`,parser)
          of "hostPath":
            load(self.`hostPath`,parser)
          of "glusterfs":
            load(self.`glusterfs`,parser)
          of "gcePersistentDisk":
            load(self.`gcePersistentDisk`,parser)
          of "quobyte":
            load(self.`quobyte`,parser)
          of "nfs":
            load(self.`nfs`,parser)
          of "emptyDir":
            load(self.`emptyDir`,parser)
          of "flocker":
            load(self.`flocker`,parser)
          of "downwardAPI":
            load(self.`downwardAPI`,parser)
          of "persistentVolumeClaim":
            load(self.`persistentVolumeClaim`,parser)
          of "scaleIO":
            load(self.`scaleIO`,parser)
          of "flexVolume":
            load(self.`flexVolume`,parser)
          of "secret":
            load(self.`secret`,parser)
          of "configMap":
            load(self.`configMap`,parser)
          of "portworxVolume":
            load(self.`portworxVolume`,parser)
          of "gitRepo":
            load(self.`gitRepo`,parser)
          of "azureDisk":
            load(self.`azureDisk`,parser)
          of "cinder":
            load(self.`cinder`,parser)
          of "fc":
            load(self.`fc`,parser)
          of "csi":
            load(self.`csi`,parser)
          of "name":
            load(self.`name`,parser)
          of "storageos":
            load(self.`storageos`,parser)
          of "awsElasticBlockStore":
            load(self.`awsElasticBlockStore`,parser)
          of "iscsi":
            load(self.`iscsi`,parser)
          of "photonPersistentDisk":
            load(self.`photonPersistentDisk`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodSpec* = object
    `affinity`*: Affinity
    `ephemeralContainers`*: seq[EphemeralContainer]
    `dnsConfig`*: PodDNSConfig
    `subdomain`*: string
    `hostAliases`*: seq[HostAlias]
    `activeDeadlineSeconds`*: int
    `containers`*: seq[Container]
    `priorityClassName`*: string
    `tolerations`*: seq[Toleration]
    `imagePullSecrets`*: seq[LocalObjectReference]
    `nodeSelector`*: Table[string,string]
    `priority`*: int
    `nodeName`*: string
    `serviceAccountName`*: string
    `terminationGracePeriodSeconds`*: int
    `shareProcessNamespace`*: bool
    `restartPolicy`*: string
    `hostname`*: string
    `initContainers`*: seq[Container]
    `overhead`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]
    `dnsPolicy`*: string
    `readinessGates`*: seq[PodReadinessGate]
    `hostPID`*: bool
    `schedulerName`*: string
    `automountServiceAccountToken`*: bool
    `enableServiceLinks`*: bool
    `securityContext`*: PodSecurityContext
    `hostIPC`*: bool
    `hostNetwork`*: bool
    `preemptionPolicy`*: string
    `serviceAccount`*: string
    `topologySpreadConstraints`*: seq[TopologySpreadConstraint]
    `volumes`*: seq[Volume]
    `runtimeClassName`*: string

proc load*(self: var PodSpec, parser: var JsonParser) =
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
          of "affinity":
            load(self.`affinity`,parser)
          of "ephemeralContainers":
            load(self.`ephemeralContainers`,parser)
          of "dnsConfig":
            load(self.`dnsConfig`,parser)
          of "subdomain":
            load(self.`subdomain`,parser)
          of "hostAliases":
            load(self.`hostAliases`,parser)
          of "activeDeadlineSeconds":
            load(self.`activeDeadlineSeconds`,parser)
          of "containers":
            load(self.`containers`,parser)
          of "priorityClassName":
            load(self.`priorityClassName`,parser)
          of "tolerations":
            load(self.`tolerations`,parser)
          of "imagePullSecrets":
            load(self.`imagePullSecrets`,parser)
          of "nodeSelector":
            load(self.`nodeSelector`,parser)
          of "priority":
            load(self.`priority`,parser)
          of "nodeName":
            load(self.`nodeName`,parser)
          of "serviceAccountName":
            load(self.`serviceAccountName`,parser)
          of "terminationGracePeriodSeconds":
            load(self.`terminationGracePeriodSeconds`,parser)
          of "shareProcessNamespace":
            load(self.`shareProcessNamespace`,parser)
          of "restartPolicy":
            load(self.`restartPolicy`,parser)
          of "hostname":
            load(self.`hostname`,parser)
          of "initContainers":
            load(self.`initContainers`,parser)
          of "overhead":
            load(self.`overhead`,parser)
          of "dnsPolicy":
            load(self.`dnsPolicy`,parser)
          of "readinessGates":
            load(self.`readinessGates`,parser)
          of "hostPID":
            load(self.`hostPID`,parser)
          of "schedulerName":
            load(self.`schedulerName`,parser)
          of "automountServiceAccountToken":
            load(self.`automountServiceAccountToken`,parser)
          of "enableServiceLinks":
            load(self.`enableServiceLinks`,parser)
          of "securityContext":
            load(self.`securityContext`,parser)
          of "hostIPC":
            load(self.`hostIPC`,parser)
          of "hostNetwork":
            load(self.`hostNetwork`,parser)
          of "preemptionPolicy":
            load(self.`preemptionPolicy`,parser)
          of "serviceAccount":
            load(self.`serviceAccount`,parser)
          of "topologySpreadConstraints":
            load(self.`topologySpreadConstraints`,parser)
          of "volumes":
            load(self.`volumes`,parser)
          of "runtimeClassName":
            load(self.`runtimeClassName`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ContainerStateWaiting* = object
    `message`*: string
    `reason`*: string

proc load*(self: var ContainerStateWaiting, parser: var JsonParser) =
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
          of "message":
            load(self.`message`,parser)
          of "reason":
            load(self.`reason`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ContainerStateTerminated* = object
    `signal`*: int
    `message`*: string
    `startedAt`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `containerID`*: string
    `exitCode`*: int
    `finishedAt`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `reason`*: string

proc load*(self: var ContainerStateTerminated, parser: var JsonParser) =
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
          of "signal":
            load(self.`signal`,parser)
          of "message":
            load(self.`message`,parser)
          of "startedAt":
            load(self.`startedAt`,parser)
          of "containerID":
            load(self.`containerID`,parser)
          of "exitCode":
            load(self.`exitCode`,parser)
          of "finishedAt":
            load(self.`finishedAt`,parser)
          of "reason":
            load(self.`reason`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ContainerStateRunning* = object
    `startedAt`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time

proc load*(self: var ContainerStateRunning, parser: var JsonParser) =
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
          of "startedAt":
            load(self.`startedAt`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ContainerState* = object
    `waiting`*: ContainerStateWaiting
    `terminated`*: ContainerStateTerminated
    `running`*: ContainerStateRunning

proc load*(self: var ContainerState, parser: var JsonParser) =
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
          of "waiting":
            load(self.`waiting`,parser)
          of "terminated":
            load(self.`terminated`,parser)
          of "running":
            load(self.`running`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ContainerStatus* = object
    `ready`*: bool
    `imageID`*: string
    `image`*: string
    `started`*: bool
    `containerID`*: string
    `lastState`*: ContainerState
    `restartCount`*: int
    `name`*: string
    `state`*: ContainerState

proc load*(self: var ContainerStatus, parser: var JsonParser) =
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
          of "ready":
            load(self.`ready`,parser)
          of "imageID":
            load(self.`imageID`,parser)
          of "image":
            load(self.`image`,parser)
          of "started":
            load(self.`started`,parser)
          of "containerID":
            load(self.`containerID`,parser)
          of "lastState":
            load(self.`lastState`,parser)
          of "restartCount":
            load(self.`restartCount`,parser)
          of "name":
            load(self.`name`,parser)
          of "state":
            load(self.`state`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodCondition* = object
    `lastTransitionTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `type`*: string
    `message`*: string
    `lastProbeTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `reason`*: string
    `status`*: string

proc load*(self: var PodCondition, parser: var JsonParser) =
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
          of "lastProbeTime":
            load(self.`lastProbeTime`,parser)
          of "reason":
            load(self.`reason`,parser)
          of "status":
            load(self.`status`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodIP* = object
    `ip`*: string

proc load*(self: var PodIP, parser: var JsonParser) =
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
          of "ip":
            load(self.`ip`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodStatus* = object
    `containerStatuses`*: seq[ContainerStatus]
    `qosClass`*: string
    `phase`*: string
    `initContainerStatuses`*: seq[ContainerStatus]
    `nominatedNodeName`*: string
    `message`*: string
    `startTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `ephemeralContainerStatuses`*: seq[ContainerStatus]
    `hostIP`*: string
    `conditions`*: seq[PodCondition]
    `reason`*: string
    `podIP`*: string
    `podIPs`*: seq[PodIP]

proc load*(self: var PodStatus, parser: var JsonParser) =
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
          of "containerStatuses":
            load(self.`containerStatuses`,parser)
          of "qosClass":
            load(self.`qosClass`,parser)
          of "phase":
            load(self.`phase`,parser)
          of "initContainerStatuses":
            load(self.`initContainerStatuses`,parser)
          of "nominatedNodeName":
            load(self.`nominatedNodeName`,parser)
          of "message":
            load(self.`message`,parser)
          of "startTime":
            load(self.`startTime`,parser)
          of "ephemeralContainerStatuses":
            load(self.`ephemeralContainerStatuses`,parser)
          of "hostIP":
            load(self.`hostIP`,parser)
          of "conditions":
            load(self.`conditions`,parser)
          of "reason":
            load(self.`reason`,parser)
          of "podIP":
            load(self.`podIP`,parser)
          of "podIPs":
            load(self.`podIPs`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Pod* = object
    `apiVersion`*: string
    `spec`*: PodSpec
    `status`*: PodStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Pod, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[Pod], name: string, namespace = "default"): Future[Pod] {.async.}=
  proc unmarshal(parser: var JsonParser):Pod = 
    var ret: Pod
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ObjectReference* = object
    `uid`*: string
    `apiVersion`*: string
    `fieldPath`*: string
    `resourceVersion`*: string
    `namespace`*: string
    `name`*: string
    `kind`*: string

proc load*(self: var ObjectReference, parser: var JsonParser) =
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
          of "uid":
            load(self.`uid`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "fieldPath":
            load(self.`fieldPath`,parser)
          of "resourceVersion":
            load(self.`resourceVersion`,parser)
          of "namespace":
            load(self.`namespace`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  EndpointAddress* = object
    `nodeName`*: string
    `ip`*: string
    `hostname`*: string
    `targetRef`*: ObjectReference

proc load*(self: var EndpointAddress, parser: var JsonParser) =
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
          of "nodeName":
            load(self.`nodeName`,parser)
          of "ip":
            load(self.`ip`,parser)
          of "hostname":
            load(self.`hostname`,parser)
          of "targetRef":
            load(self.`targetRef`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  EndpointPort* = object
    `protocol`*: string
    `port`*: int
    `name`*: string

proc load*(self: var EndpointPort, parser: var JsonParser) =
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
          of "protocol":
            load(self.`protocol`,parser)
          of "port":
            load(self.`port`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  EndpointSubset* = object
    `addresses`*: seq[EndpointAddress]
    `ports`*: seq[EndpointPort]
    `notReadyAddresses`*: seq[EndpointAddress]

proc load*(self: var EndpointSubset, parser: var JsonParser) =
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
          of "addresses":
            load(self.`addresses`,parser)
          of "ports":
            load(self.`ports`,parser)
          of "notReadyAddresses":
            load(self.`notReadyAddresses`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Endpoints* = object
    `apiVersion`*: string
    `kind`*: string
    `subsets`*: seq[EndpointSubset]
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Endpoints, parser: var JsonParser) =
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
          of "kind":
            load(self.`kind`,parser)
          of "subsets":
            load(self.`subsets`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[Endpoints], name: string, namespace = "default"): Future[Endpoints] {.async.}=
  proc unmarshal(parser: var JsonParser):Endpoints = 
    var ret: Endpoints
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ScopedResourceSelectorRequirement* = object
    `values`*: seq[string]
    `scopeName`*: string
    `operator`*: string

proc load*(self: var ScopedResourceSelectorRequirement, parser: var JsonParser) =
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
          of "values":
            load(self.`values`,parser)
          of "scopeName":
            load(self.`scopeName`,parser)
          of "operator":
            load(self.`operator`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Taint* = object
    `key`*: string
    `effect`*: string
    `timeAdded`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `value`*: string

proc load*(self: var Taint, parser: var JsonParser) =
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
          of "key":
            load(self.`key`,parser)
          of "effect":
            load(self.`effect`,parser)
          of "timeAdded":
            load(self.`timeAdded`,parser)
          of "value":
            load(self.`value`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  NodeSpec* = object
    `podCIDRs`*: seq[string]
    `externalID`*: string
    `taints`*: seq[Taint]
    `providerID`*: string
    `unschedulable`*: bool
    `podCIDR`*: string
    `configSource`*: NodeConfigSource

proc load*(self: var NodeSpec, parser: var JsonParser) =
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
          of "podCIDRs":
            load(self.`podCIDRs`,parser)
          of "externalID":
            load(self.`externalID`,parser)
          of "taints":
            load(self.`taints`,parser)
          of "providerID":
            load(self.`providerID`,parser)
          of "unschedulable":
            load(self.`unschedulable`,parser)
          of "podCIDR":
            load(self.`podCIDR`,parser)
          of "configSource":
            load(self.`configSource`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  AzureFilePersistentVolumeSource* = object
    `shareName`*: string
    `secretName`*: string
    `secretNamespace`*: string
    `readOnly`*: bool

proc load*(self: var AzureFilePersistentVolumeSource, parser: var JsonParser) =
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
          of "shareName":
            load(self.`shareName`,parser)
          of "secretName":
            load(self.`secretName`,parser)
          of "secretNamespace":
            load(self.`secretNamespace`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  EventSource* = object
    `component`*: string
    `host`*: string

proc load*(self: var EventSource, parser: var JsonParser) =
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
          of "component":
            load(self.`component`,parser)
          of "host":
            load(self.`host`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodTemplateSpec* = object
    `spec`*: PodSpec
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var PodTemplateSpec, parser: var JsonParser) =
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
          of "spec":
            load(self.`spec`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ReplicationControllerSpec* = object
    `replicas`*: int
    `template`*: PodTemplateSpec
    `selector`*: Table[string,string]
    `minReadySeconds`*: int

proc load*(self: var ReplicationControllerSpec, parser: var JsonParser) =
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
  ReplicationControllerCondition* = object
    `lastTransitionTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `type`*: string
    `message`*: string
    `reason`*: string
    `status`*: string

proc load*(self: var ReplicationControllerCondition, parser: var JsonParser) =
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
  ReplicationControllerStatus* = object
    `fullyLabeledReplicas`*: int
    `replicas`*: int
    `observedGeneration`*: int
    `conditions`*: seq[ReplicationControllerCondition]
    `readyReplicas`*: int
    `availableReplicas`*: int

proc load*(self: var ReplicationControllerStatus, parser: var JsonParser) =
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
  ReplicationController* = object
    `apiVersion`*: string
    `spec`*: ReplicationControllerSpec
    `status`*: ReplicationControllerStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var ReplicationController, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[ReplicationController], name: string, namespace = "default"): Future[ReplicationController] {.async.}=
  proc unmarshal(parser: var JsonParser):ReplicationController = 
    var ret: ReplicationController
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  LimitRangeItem* = object
    `maxLimitRequestRatio`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]
    `defaultRequest`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]
    `type`*: string
    `max`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]
    `default`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]
    `min`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]

proc load*(self: var LimitRangeItem, parser: var JsonParser) =
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
          of "maxLimitRequestRatio":
            load(self.`maxLimitRequestRatio`,parser)
          of "defaultRequest":
            load(self.`defaultRequest`,parser)
          of "type":
            load(self.`type`,parser)
          of "max":
            load(self.`max`,parser)
          of "default":
            load(self.`default`,parser)
          of "min":
            load(self.`min`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  LimitRangeSpec* = object
    `limits`*: seq[LimitRangeItem]

proc load*(self: var LimitRangeSpec, parser: var JsonParser) =
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
          of "limits":
            load(self.`limits`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  LimitRange* = object
    `apiVersion`*: string
    `spec`*: LimitRangeSpec
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var LimitRange, parser: var JsonParser) =
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
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[LimitRange], name: string, namespace = "default"): Future[LimitRange] {.async.}=
  proc unmarshal(parser: var JsonParser):LimitRange = 
    var ret: LimitRange
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  LimitRangeList* = object
    `apiVersion`*: string
    `items`*: seq[LimitRange]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var LimitRangeList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[LimitRangeList], name: string, namespace = "default"): Future[LimitRangeList] {.async.}=
  proc unmarshal(parser: var JsonParser):LimitRangeList = 
    var ret: LimitRangeList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  Node* = object
    `apiVersion`*: string
    `spec`*: NodeSpec
    `status`*: NodeStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Node, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[Node], name: string, namespace = "default"): Future[Node] {.async.}=
  proc unmarshal(parser: var JsonParser):Node = 
    var ret: Node
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  NodeList* = object
    `apiVersion`*: string
    `items`*: seq[Node]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var NodeList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[NodeList], name: string, namespace = "default"): Future[NodeList] {.async.}=
  proc unmarshal(parser: var JsonParser):NodeList = 
    var ret: NodeList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ServicePort* = object
    `nodePort`*: int
    `targetPort`*: io_k8s_apimachinery_pkg_util_intstr.IntOrString
    `protocol`*: string
    `port`*: int
    `name`*: string

proc load*(self: var ServicePort, parser: var JsonParser) =
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
          of "nodePort":
            load(self.`nodePort`,parser)
          of "targetPort":
            load(self.`targetPort`,parser)
          of "protocol":
            load(self.`protocol`,parser)
          of "port":
            load(self.`port`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  StorageOSPersistentVolumeSource* = object
    `volumeName`*: string
    `fsType`*: string
    `readOnly`*: bool
    `secretRef`*: ObjectReference
    `volumeNamespace`*: string

proc load*(self: var StorageOSPersistentVolumeSource, parser: var JsonParser) =
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
          of "volumeName":
            load(self.`volumeName`,parser)
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
          of "volumeNamespace":
            load(self.`volumeNamespace`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  VolumeNodeAffinity* = object
    `required`*: NodeSelector

proc load*(self: var VolumeNodeAffinity, parser: var JsonParser) =
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
          of "required":
            load(self.`required`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ConfigMap* = object
    `apiVersion`*: string
    `data`*: Table[string,string]
    `binaryData`*: Table[string,ByteArray]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var ConfigMap, parser: var JsonParser) =
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
          of "binaryData":
            load(self.`binaryData`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[ConfigMap], name: string, namespace = "default"): Future[ConfigMap] {.async.}=
  proc unmarshal(parser: var JsonParser):ConfigMap = 
    var ret: ConfigMap
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ConfigMapList* = object
    `apiVersion`*: string
    `items`*: seq[ConfigMap]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var ConfigMapList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[ConfigMapList], name: string, namespace = "default"): Future[ConfigMapList] {.async.}=
  proc unmarshal(parser: var JsonParser):ConfigMapList = 
    var ret: ConfigMapList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ClientIPConfig* = object
    `timeoutSeconds`*: int

proc load*(self: var ClientIPConfig, parser: var JsonParser) =
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
          of "timeoutSeconds":
            load(self.`timeoutSeconds`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  SessionAffinityConfig* = object
    `clientIP`*: ClientIPConfig

proc load*(self: var SessionAffinityConfig, parser: var JsonParser) =
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
          of "clientIP":
            load(self.`clientIP`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ServiceSpec* = object
    `publishNotReadyAddresses`*: bool
    `externalName`*: string
    `healthCheckNodePort`*: int
    `type`*: string
    `externalTrafficPolicy`*: string
    `sessionAffinityConfig`*: SessionAffinityConfig
    `ports`*: seq[ServicePort]
    `sessionAffinity`*: string
    `selector`*: Table[string,string]
    `clusterIP`*: string
    `loadBalancerIP`*: string
    `loadBalancerSourceRanges`*: seq[string]
    `ipFamily`*: string
    `externalIPs`*: seq[string]

proc load*(self: var ServiceSpec, parser: var JsonParser) =
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
          of "publishNotReadyAddresses":
            load(self.`publishNotReadyAddresses`,parser)
          of "externalName":
            load(self.`externalName`,parser)
          of "healthCheckNodePort":
            load(self.`healthCheckNodePort`,parser)
          of "type":
            load(self.`type`,parser)
          of "externalTrafficPolicy":
            load(self.`externalTrafficPolicy`,parser)
          of "sessionAffinityConfig":
            load(self.`sessionAffinityConfig`,parser)
          of "ports":
            load(self.`ports`,parser)
          of "sessionAffinity":
            load(self.`sessionAffinity`,parser)
          of "selector":
            load(self.`selector`,parser)
          of "clusterIP":
            load(self.`clusterIP`,parser)
          of "loadBalancerIP":
            load(self.`loadBalancerIP`,parser)
          of "loadBalancerSourceRanges":
            load(self.`loadBalancerSourceRanges`,parser)
          of "ipFamily":
            load(self.`ipFamily`,parser)
          of "externalIPs":
            load(self.`externalIPs`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  LoadBalancerIngress* = object
    `ip`*: string
    `hostname`*: string

proc load*(self: var LoadBalancerIngress, parser: var JsonParser) =
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
          of "ip":
            load(self.`ip`,parser)
          of "hostname":
            load(self.`hostname`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  LoadBalancerStatus* = object
    `ingress`*: seq[LoadBalancerIngress]

proc load*(self: var LoadBalancerStatus, parser: var JsonParser) =
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
          of "ingress":
            load(self.`ingress`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ServiceStatus* = object
    `loadBalancer`*: LoadBalancerStatus

proc load*(self: var ServiceStatus, parser: var JsonParser) =
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
          of "loadBalancer":
            load(self.`loadBalancer`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Service* = object
    `apiVersion`*: string
    `spec`*: ServiceSpec
    `status`*: ServiceStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Service, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[Service], name: string, namespace = "default"): Future[Service] {.async.}=
  proc unmarshal(parser: var JsonParser):Service = 
    var ret: Service
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ServiceList* = object
    `apiVersion`*: string
    `items`*: seq[Service]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var ServiceList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[ServiceList], name: string, namespace = "default"): Future[ServiceList] {.async.}=
  proc unmarshal(parser: var JsonParser):ServiceList = 
    var ret: ServiceList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  NamespaceCondition* = object
    `lastTransitionTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `type`*: string
    `message`*: string
    `reason`*: string
    `status`*: string

proc load*(self: var NamespaceCondition, parser: var JsonParser) =
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
  NamespaceStatus* = object
    `phase`*: string
    `conditions`*: seq[NamespaceCondition]

proc load*(self: var NamespaceStatus, parser: var JsonParser) =
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
          of "phase":
            load(self.`phase`,parser)
          of "conditions":
            load(self.`conditions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  SecretReference* = object
    `namespace`*: string
    `name`*: string

proc load*(self: var SecretReference, parser: var JsonParser) =
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
          of "namespace":
            load(self.`namespace`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CinderPersistentVolumeSource* = object
    `fsType`*: string
    `readOnly`*: bool
    `secretRef`*: SecretReference
    `volumeID`*: string

proc load*(self: var CinderPersistentVolumeSource, parser: var JsonParser) =
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
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
          of "volumeID":
            load(self.`volumeID`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ScopeSelector* = object
    `matchExpressions`*: seq[ScopedResourceSelectorRequirement]

proc load*(self: var ScopeSelector, parser: var JsonParser) =
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
          of "matchExpressions":
            load(self.`matchExpressions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ResourceQuotaSpec* = object
    `scopes`*: seq[string]
    `hard`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]
    `scopeSelector`*: ScopeSelector

proc load*(self: var ResourceQuotaSpec, parser: var JsonParser) =
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
          of "scopes":
            load(self.`scopes`,parser)
          of "hard":
            load(self.`hard`,parser)
          of "scopeSelector":
            load(self.`scopeSelector`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ResourceQuotaStatus* = object
    `hard`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]
    `used`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]

proc load*(self: var ResourceQuotaStatus, parser: var JsonParser) =
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
          of "hard":
            load(self.`hard`,parser)
          of "used":
            load(self.`used`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ResourceQuota* = object
    `apiVersion`*: string
    `spec`*: ResourceQuotaSpec
    `status`*: ResourceQuotaStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var ResourceQuota, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[ResourceQuota], name: string, namespace = "default"): Future[ResourceQuota] {.async.}=
  proc unmarshal(parser: var JsonParser):ResourceQuota = 
    var ret: ResourceQuota
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ISCSIPersistentVolumeSource* = object
    `iqn`*: string
    `iscsiInterface`*: string
    `lun`*: int
    `fsType`*: string
    `readOnly`*: bool
    `secretRef`*: SecretReference
    `chapAuthDiscovery`*: bool
    `chapAuthSession`*: bool
    `initiatorName`*: string
    `portals`*: seq[string]
    `targetPortal`*: string

proc load*(self: var ISCSIPersistentVolumeSource, parser: var JsonParser) =
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
          of "iqn":
            load(self.`iqn`,parser)
          of "iscsiInterface":
            load(self.`iscsiInterface`,parser)
          of "lun":
            load(self.`lun`,parser)
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
          of "chapAuthDiscovery":
            load(self.`chapAuthDiscovery`,parser)
          of "chapAuthSession":
            load(self.`chapAuthSession`,parser)
          of "initiatorName":
            load(self.`initiatorName`,parser)
          of "portals":
            load(self.`portals`,parser)
          of "targetPortal":
            load(self.`targetPortal`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  RBDPersistentVolumeSource* = object
    `user`*: string
    `monitors`*: seq[string]
    `image`*: string
    `keyring`*: string
    `fsType`*: string
    `readOnly`*: bool
    `secretRef`*: SecretReference
    `pool`*: string

proc load*(self: var RBDPersistentVolumeSource, parser: var JsonParser) =
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
          of "user":
            load(self.`user`,parser)
          of "monitors":
            load(self.`monitors`,parser)
          of "image":
            load(self.`image`,parser)
          of "keyring":
            load(self.`keyring`,parser)
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
          of "pool":
            load(self.`pool`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CephFSPersistentVolumeSource* = object
    `path`*: string
    `user`*: string
    `monitors`*: seq[string]
    `secretFile`*: string
    `readOnly`*: bool
    `secretRef`*: SecretReference

proc load*(self: var CephFSPersistentVolumeSource, parser: var JsonParser) =
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
          of "path":
            load(self.`path`,parser)
          of "user":
            load(self.`user`,parser)
          of "monitors":
            load(self.`monitors`,parser)
          of "secretFile":
            load(self.`secretFile`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  GlusterfsPersistentVolumeSource* = object
    `path`*: string
    `endpointsNamespace`*: string
    `endpoints`*: string
    `readOnly`*: bool

proc load*(self: var GlusterfsPersistentVolumeSource, parser: var JsonParser) =
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
          of "path":
            load(self.`path`,parser)
          of "endpointsNamespace":
            load(self.`endpointsNamespace`,parser)
          of "endpoints":
            load(self.`endpoints`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ScaleIOPersistentVolumeSource* = object
    `storageMode`*: string
    `volumeName`*: string
    `storagePool`*: string
    `gateway`*: string
    `fsType`*: string
    `readOnly`*: bool
    `secretRef`*: SecretReference
    `system`*: string
    `sslEnabled`*: bool
    `protectionDomain`*: string

proc load*(self: var ScaleIOPersistentVolumeSource, parser: var JsonParser) =
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
          of "storageMode":
            load(self.`storageMode`,parser)
          of "volumeName":
            load(self.`volumeName`,parser)
          of "storagePool":
            load(self.`storagePool`,parser)
          of "gateway":
            load(self.`gateway`,parser)
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
          of "system":
            load(self.`system`,parser)
          of "sslEnabled":
            load(self.`sslEnabled`,parser)
          of "protectionDomain":
            load(self.`protectionDomain`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  FlexPersistentVolumeSource* = object
    `driver`*: string
    `options`*: Table[string,string]
    `fsType`*: string
    `readOnly`*: bool
    `secretRef`*: SecretReference

proc load*(self: var FlexPersistentVolumeSource, parser: var JsonParser) =
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
          of "driver":
            load(self.`driver`,parser)
          of "options":
            load(self.`options`,parser)
          of "fsType":
            load(self.`fsType`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "secretRef":
            load(self.`secretRef`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  LocalVolumeSource* = object
    `path`*: string
    `fsType`*: string

proc load*(self: var LocalVolumeSource, parser: var JsonParser) =
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
          of "path":
            load(self.`path`,parser)
          of "fsType":
            load(self.`fsType`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CSIPersistentVolumeSource* = object
    `controllerExpandSecretRef`*: SecretReference
    `volumeAttributes`*: Table[string,string]
    `driver`*: string
    `nodeStageSecretRef`*: SecretReference
    `controllerPublishSecretRef`*: SecretReference
    `fsType`*: string
    `nodePublishSecretRef`*: SecretReference
    `readOnly`*: bool
    `volumeHandle`*: string

proc load*(self: var CSIPersistentVolumeSource, parser: var JsonParser) =
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
          of "controllerExpandSecretRef":
            load(self.`controllerExpandSecretRef`,parser)
          of "volumeAttributes":
            load(self.`volumeAttributes`,parser)
          of "driver":
            load(self.`driver`,parser)
          of "nodeStageSecretRef":
            load(self.`nodeStageSecretRef`,parser)
          of "controllerPublishSecretRef":
            load(self.`controllerPublishSecretRef`,parser)
          of "fsType":
            load(self.`fsType`,parser)
          of "nodePublishSecretRef":
            load(self.`nodePublishSecretRef`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
          of "volumeHandle":
            load(self.`volumeHandle`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PersistentVolumeSpec* = object
    `vsphereVolume`*: VsphereVirtualDiskVolumeSource
    `azureFile`*: AzureFilePersistentVolumeSource
    `rbd`*: RBDPersistentVolumeSource
    `cephfs`*: CephFSPersistentVolumeSource
    `hostPath`*: HostPathVolumeSource
    `nodeAffinity`*: VolumeNodeAffinity
    `glusterfs`*: GlusterfsPersistentVolumeSource
    `gcePersistentDisk`*: GCEPersistentDiskVolumeSource
    `quobyte`*: QuobyteVolumeSource
    `volumeMode`*: string
    `nfs`*: NFSVolumeSource
    `flocker`*: FlockerVolumeSource
    `storageClassName`*: string
    `scaleIO`*: ScaleIOPersistentVolumeSource
    `flexVolume`*: FlexPersistentVolumeSource
    `local`*: LocalVolumeSource
    `portworxVolume`*: PortworxVolumeSource
    `azureDisk`*: AzureDiskVolumeSource
    `capacity`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]
    `claimRef`*: ObjectReference
    `mountOptions`*: seq[string]
    `cinder`*: CinderPersistentVolumeSource
    `fc`*: FCVolumeSource
    `csi`*: CSIPersistentVolumeSource
    `storageos`*: StorageOSPersistentVolumeSource
    `persistentVolumeReclaimPolicy`*: string
    `accessModes`*: seq[string]
    `awsElasticBlockStore`*: AWSElasticBlockStoreVolumeSource
    `iscsi`*: ISCSIPersistentVolumeSource
    `photonPersistentDisk`*: PhotonPersistentDiskVolumeSource

proc load*(self: var PersistentVolumeSpec, parser: var JsonParser) =
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
          of "vsphereVolume":
            load(self.`vsphereVolume`,parser)
          of "azureFile":
            load(self.`azureFile`,parser)
          of "rbd":
            load(self.`rbd`,parser)
          of "cephfs":
            load(self.`cephfs`,parser)
          of "hostPath":
            load(self.`hostPath`,parser)
          of "nodeAffinity":
            load(self.`nodeAffinity`,parser)
          of "glusterfs":
            load(self.`glusterfs`,parser)
          of "gcePersistentDisk":
            load(self.`gcePersistentDisk`,parser)
          of "quobyte":
            load(self.`quobyte`,parser)
          of "volumeMode":
            load(self.`volumeMode`,parser)
          of "nfs":
            load(self.`nfs`,parser)
          of "flocker":
            load(self.`flocker`,parser)
          of "storageClassName":
            load(self.`storageClassName`,parser)
          of "scaleIO":
            load(self.`scaleIO`,parser)
          of "flexVolume":
            load(self.`flexVolume`,parser)
          of "local":
            load(self.`local`,parser)
          of "portworxVolume":
            load(self.`portworxVolume`,parser)
          of "azureDisk":
            load(self.`azureDisk`,parser)
          of "capacity":
            load(self.`capacity`,parser)
          of "claimRef":
            load(self.`claimRef`,parser)
          of "mountOptions":
            load(self.`mountOptions`,parser)
          of "cinder":
            load(self.`cinder`,parser)
          of "fc":
            load(self.`fc`,parser)
          of "csi":
            load(self.`csi`,parser)
          of "storageos":
            load(self.`storageos`,parser)
          of "persistentVolumeReclaimPolicy":
            load(self.`persistentVolumeReclaimPolicy`,parser)
          of "accessModes":
            load(self.`accessModes`,parser)
          of "awsElasticBlockStore":
            load(self.`awsElasticBlockStore`,parser)
          of "iscsi":
            load(self.`iscsi`,parser)
          of "photonPersistentDisk":
            load(self.`photonPersistentDisk`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PersistentVolumeStatus* = object
    `phase`*: string
    `message`*: string
    `reason`*: string

proc load*(self: var PersistentVolumeStatus, parser: var JsonParser) =
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
          of "phase":
            load(self.`phase`,parser)
          of "message":
            load(self.`message`,parser)
          of "reason":
            load(self.`reason`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PersistentVolumeClaimStatus* = object
    `phase`*: string
    `capacity`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]
    `conditions`*: seq[PersistentVolumeClaimCondition]
    `accessModes`*: seq[string]

proc load*(self: var PersistentVolumeClaimStatus, parser: var JsonParser) =
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
          of "phase":
            load(self.`phase`,parser)
          of "capacity":
            load(self.`capacity`,parser)
          of "conditions":
            load(self.`conditions`,parser)
          of "accessModes":
            load(self.`accessModes`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  EventSeries* = object
    `count`*: int
    `lastObservedTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.MicroTime
    `state`*: string

proc load*(self: var EventSeries, parser: var JsonParser) =
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
          of "count":
            load(self.`count`,parser)
          of "lastObservedTime":
            load(self.`lastObservedTime`,parser)
          of "state":
            load(self.`state`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Event* = object
    `involvedObject`*: ObjectReference
    `apiVersion`*: string
    `reportingInstance`*: string
    `type`*: string
    `message`*: string
    `lastTimestamp`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `eventTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.MicroTime
    `series`*: EventSeries
    `count`*: int
    `action`*: string
    `firstTimestamp`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `source`*: EventSource
    `reason`*: string
    `reportingComponent`*: string
    `kind`*: string
    `related`*: ObjectReference
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Event, parser: var JsonParser) =
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
          of "involvedObject":
            load(self.`involvedObject`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "reportingInstance":
            load(self.`reportingInstance`,parser)
          of "type":
            load(self.`type`,parser)
          of "message":
            load(self.`message`,parser)
          of "lastTimestamp":
            load(self.`lastTimestamp`,parser)
          of "eventTime":
            load(self.`eventTime`,parser)
          of "series":
            load(self.`series`,parser)
          of "count":
            load(self.`count`,parser)
          of "action":
            load(self.`action`,parser)
          of "firstTimestamp":
            load(self.`firstTimestamp`,parser)
          of "source":
            load(self.`source`,parser)
          of "reason":
            load(self.`reason`,parser)
          of "reportingComponent":
            load(self.`reportingComponent`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "related":
            load(self.`related`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[Event], name: string, namespace = "default"): Future[Event] {.async.}=
  proc unmarshal(parser: var JsonParser):Event = 
    var ret: Event
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  EventList* = object
    `apiVersion`*: string
    `items`*: seq[Event]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var EventList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[EventList], name: string, namespace = "default"): Future[EventList] {.async.}=
  proc unmarshal(parser: var JsonParser):EventList = 
    var ret: EventList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  PersistentVolume* = object
    `apiVersion`*: string
    `spec`*: PersistentVolumeSpec
    `status`*: PersistentVolumeStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var PersistentVolume, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[PersistentVolume], name: string, namespace = "default"): Future[PersistentVolume] {.async.}=
  proc unmarshal(parser: var JsonParser):PersistentVolume = 
    var ret: PersistentVolume
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  TypedLocalObjectReference* = object
    `apiGroup`*: string
    `name`*: string
    `kind`*: string

proc load*(self: var TypedLocalObjectReference, parser: var JsonParser) =
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
          of "apiGroup":
            load(self.`apiGroup`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PodTemplate* = object
    `apiVersion`*: string
    `template`*: PodTemplateSpec
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var PodTemplate, parser: var JsonParser) =
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
          of "template":
            load(self.`template`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[PodTemplate], name: string, namespace = "default"): Future[PodTemplate] {.async.}=
  proc unmarshal(parser: var JsonParser):PodTemplate = 
    var ret: PodTemplate
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  PodTemplateList* = object
    `apiVersion`*: string
    `items`*: seq[PodTemplate]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var PodTemplateList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[PodTemplateList], name: string, namespace = "default"): Future[PodTemplateList] {.async.}=
  proc unmarshal(parser: var JsonParser):PodTemplateList = 
    var ret: PodTemplateList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ComponentCondition* = object
    `error`*: string
    `type`*: string
    `message`*: string
    `status`*: string

proc load*(self: var ComponentCondition, parser: var JsonParser) =
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
          of "error":
            load(self.`error`,parser)
          of "type":
            load(self.`type`,parser)
          of "message":
            load(self.`message`,parser)
          of "status":
            load(self.`status`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ComponentStatus* = object
    `apiVersion`*: string
    `conditions`*: seq[ComponentCondition]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var ComponentStatus, parser: var JsonParser) =
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
          of "conditions":
            load(self.`conditions`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[ComponentStatus], name: string, namespace = "default"): Future[ComponentStatus] {.async.}=
  proc unmarshal(parser: var JsonParser):ComponentStatus = 
    var ret: ComponentStatus
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ComponentStatusList* = object
    `apiVersion`*: string
    `items`*: seq[ComponentStatus]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var ComponentStatusList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[ComponentStatusList], name: string, namespace = "default"): Future[ComponentStatusList] {.async.}=
  proc unmarshal(parser: var JsonParser):ComponentStatusList = 
    var ret: ComponentStatusList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  PersistentVolumeClaimSpec* = object
    `volumeMode`*: string
    `volumeName`*: string
    `storageClassName`*: string
    `dataSource`*: TypedLocalObjectReference
    `resources`*: ResourceRequirements
    `selector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `accessModes`*: seq[string]

proc load*(self: var PersistentVolumeClaimSpec, parser: var JsonParser) =
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
          of "volumeMode":
            load(self.`volumeMode`,parser)
          of "volumeName":
            load(self.`volumeName`,parser)
          of "storageClassName":
            load(self.`storageClassName`,parser)
          of "dataSource":
            load(self.`dataSource`,parser)
          of "resources":
            load(self.`resources`,parser)
          of "selector":
            load(self.`selector`,parser)
          of "accessModes":
            load(self.`accessModes`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  PersistentVolumeClaim* = object
    `apiVersion`*: string
    `spec`*: PersistentVolumeClaimSpec
    `status`*: PersistentVolumeClaimStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var PersistentVolumeClaim, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[PersistentVolumeClaim], name: string, namespace = "default"): Future[PersistentVolumeClaim] {.async.}=
  proc unmarshal(parser: var JsonParser):PersistentVolumeClaim = 
    var ret: PersistentVolumeClaim
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  PersistentVolumeList* = object
    `apiVersion`*: string
    `items`*: seq[PersistentVolume]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var PersistentVolumeList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[PersistentVolumeList], name: string, namespace = "default"): Future[PersistentVolumeList] {.async.}=
  proc unmarshal(parser: var JsonParser):PersistentVolumeList = 
    var ret: PersistentVolumeList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  Binding* = object
    `apiVersion`*: string
    `target`*: ObjectReference
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Binding, parser: var JsonParser) =
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
          of "target":
            load(self.`target`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[Binding], name: string, namespace = "default"): Future[Binding] {.async.}=
  proc unmarshal(parser: var JsonParser):Binding = 
    var ret: Binding
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  NamespaceSpec* = object
    `finalizers`*: seq[string]

proc load*(self: var NamespaceSpec, parser: var JsonParser) =
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
          of "finalizers":
            load(self.`finalizers`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Namespace* = object
    `apiVersion`*: string
    `spec`*: NamespaceSpec
    `status`*: NamespaceStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Namespace, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[Namespace], name: string, namespace = "default"): Future[Namespace] {.async.}=
  proc unmarshal(parser: var JsonParser):Namespace = 
    var ret: Namespace
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ResourceQuotaList* = object
    `apiVersion`*: string
    `items`*: seq[ResourceQuota]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var ResourceQuotaList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[ResourceQuotaList], name: string, namespace = "default"): Future[ResourceQuotaList] {.async.}=
  proc unmarshal(parser: var JsonParser):ResourceQuotaList = 
    var ret: ResourceQuotaList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  PersistentVolumeClaimList* = object
    `apiVersion`*: string
    `items`*: seq[PersistentVolumeClaim]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var PersistentVolumeClaimList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[PersistentVolumeClaimList], name: string, namespace = "default"): Future[PersistentVolumeClaimList] {.async.}=
  proc unmarshal(parser: var JsonParser):PersistentVolumeClaimList = 
    var ret: PersistentVolumeClaimList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  PodList* = object
    `apiVersion`*: string
    `items`*: seq[Pod]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var PodList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[PodList], name: string, namespace = "default"): Future[PodList] {.async.}=
  proc unmarshal(parser: var JsonParser):PodList = 
    var ret: PodList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ServiceAccount* = object
    `secrets`*: seq[ObjectReference]
    `apiVersion`*: string
    `imagePullSecrets`*: seq[LocalObjectReference]
    `automountServiceAccountToken`*: bool
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var ServiceAccount, parser: var JsonParser) =
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
          of "secrets":
            load(self.`secrets`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "imagePullSecrets":
            load(self.`imagePullSecrets`,parser)
          of "automountServiceAccountToken":
            load(self.`automountServiceAccountToken`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[ServiceAccount], name: string, namespace = "default"): Future[ServiceAccount] {.async.}=
  proc unmarshal(parser: var JsonParser):ServiceAccount = 
    var ret: ServiceAccount
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ServiceAccountList* = object
    `apiVersion`*: string
    `items`*: seq[ServiceAccount]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var ServiceAccountList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[ServiceAccountList], name: string, namespace = "default"): Future[ServiceAccountList] {.async.}=
  proc unmarshal(parser: var JsonParser):ServiceAccountList = 
    var ret: ServiceAccountList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  ReplicationControllerList* = object
    `apiVersion`*: string
    `items`*: seq[ReplicationController]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var ReplicationControllerList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[ReplicationControllerList], name: string, namespace = "default"): Future[ReplicationControllerList] {.async.}=
  proc unmarshal(parser: var JsonParser):ReplicationControllerList = 
    var ret: ReplicationControllerList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  EndpointsList* = object
    `apiVersion`*: string
    `items`*: seq[Endpoints]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var EndpointsList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[EndpointsList], name: string, namespace = "default"): Future[EndpointsList] {.async.}=
  proc unmarshal(parser: var JsonParser):EndpointsList = 
    var ret: EndpointsList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  NamespaceList* = object
    `apiVersion`*: string
    `items`*: seq[Namespace]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var NamespaceList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[NamespaceList], name: string, namespace = "default"): Future[NamespaceList] {.async.}=
  proc unmarshal(parser: var JsonParser):NamespaceList = 
    var ret: NamespaceList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  Secret* = object
    `apiVersion`*: string
    `data`*: Table[string,ByteArray]
    `type`*: string
    `stringData`*: Table[string,string]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Secret, parser: var JsonParser) =
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
          of "type":
            load(self.`type`,parser)
          of "stringData":
            load(self.`stringData`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[Secret], name: string, namespace = "default"): Future[Secret] {.async.}=
  proc unmarshal(parser: var JsonParser):Secret = 
    var ret: Secret
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)

type
  SecretList* = object
    `apiVersion`*: string
    `items`*: seq[Secret]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var SecretList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[SecretList], name: string, namespace = "default"): Future[SecretList] {.async.}=
  proc unmarshal(parser: var JsonParser):SecretList = 
    var ret: SecretList
    load(ret,parser)
    return ret 
  return await client.get("/api/v1",t,name,namespace, unmarshal)
