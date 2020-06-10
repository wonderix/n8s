import ../client
import ../base_types
import parsejson
import streams
import io_k8s_apimachinery_pkg_apis_meta_v1
import tables
import io_k8s_apimachinery_pkg_api_resource
import io_k8s_apimachinery_pkg_util_intstr
import asyncdispatch

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

proc dump*(self: NodeCondition, s: Stream) =
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
  if not self.`lastHeartbeatTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastHeartbeatTime\":")
    self.`lastHeartbeatTime`.dump(s)
  s.write("}")

proc isEmpty*(self: NodeCondition): bool =
  if not self.`lastTransitionTime`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`lastHeartbeatTime`.isEmpty: return false
  true

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

proc dump*(self: NodeAddress, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`address`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"address\":")
    self.`address`.dump(s)
  s.write("}")

proc isEmpty*(self: NodeAddress): bool =
  if not self.`type`.isEmpty: return false
  if not self.`address`.isEmpty: return false
  true

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

proc dump*(self: ConfigMapNodeConfigSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`uid`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"uid\":")
    self.`uid`.dump(s)
  if not self.`kubeletConfigKey`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kubeletConfigKey\":")
    self.`kubeletConfigKey`.dump(s)
  if not self.`resourceVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resourceVersion\":")
    self.`resourceVersion`.dump(s)
  if not self.`namespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespace\":")
    self.`namespace`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: ConfigMapNodeConfigSource): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`kubeletConfigKey`.isEmpty: return false
  if not self.`resourceVersion`.isEmpty: return false
  if not self.`namespace`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: NodeConfigSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`configMap`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"configMap\":")
    self.`configMap`.dump(s)
  s.write("}")

proc isEmpty*(self: NodeConfigSource): bool =
  if not self.`configMap`.isEmpty: return false
  true

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

proc dump*(self: NodeConfigStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`lastKnownGood`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastKnownGood\":")
    self.`lastKnownGood`.dump(s)
  if not self.`error`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"error\":")
    self.`error`.dump(s)
  if not self.`active`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"active\":")
    self.`active`.dump(s)
  if not self.`assigned`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"assigned\":")
    self.`assigned`.dump(s)
  s.write("}")

proc isEmpty*(self: NodeConfigStatus): bool =
  if not self.`lastKnownGood`.isEmpty: return false
  if not self.`error`.isEmpty: return false
  if not self.`active`.isEmpty: return false
  if not self.`assigned`.isEmpty: return false
  true

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

proc dump*(self: DaemonEndpoint, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`Port`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"Port\":")
    self.`Port`.dump(s)
  s.write("}")

proc isEmpty*(self: DaemonEndpoint): bool =
  if not self.`Port`.isEmpty: return false
  true

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

proc dump*(self: NodeDaemonEndpoints, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`kubeletEndpoint`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kubeletEndpoint\":")
    self.`kubeletEndpoint`.dump(s)
  s.write("}")

proc isEmpty*(self: NodeDaemonEndpoints): bool =
  if not self.`kubeletEndpoint`.isEmpty: return false
  true

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

proc dump*(self: NodeSystemInfo, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`machineID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"machineID\":")
    self.`machineID`.dump(s)
  if not self.`kernelVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kernelVersion\":")
    self.`kernelVersion`.dump(s)
  if not self.`osImage`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"osImage\":")
    self.`osImage`.dump(s)
  if not self.`systemUUID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"systemUUID\":")
    self.`systemUUID`.dump(s)
  if not self.`bootID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"bootID\":")
    self.`bootID`.dump(s)
  if not self.`containerRuntimeVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"containerRuntimeVersion\":")
    self.`containerRuntimeVersion`.dump(s)
  if not self.`kubeletVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kubeletVersion\":")
    self.`kubeletVersion`.dump(s)
  if not self.`kubeProxyVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kubeProxyVersion\":")
    self.`kubeProxyVersion`.dump(s)
  if not self.`architecture`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"architecture\":")
    self.`architecture`.dump(s)
  if not self.`operatingSystem`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"operatingSystem\":")
    self.`operatingSystem`.dump(s)
  s.write("}")

proc isEmpty*(self: NodeSystemInfo): bool =
  if not self.`machineID`.isEmpty: return false
  if not self.`kernelVersion`.isEmpty: return false
  if not self.`osImage`.isEmpty: return false
  if not self.`systemUUID`.isEmpty: return false
  if not self.`bootID`.isEmpty: return false
  if not self.`containerRuntimeVersion`.isEmpty: return false
  if not self.`kubeletVersion`.isEmpty: return false
  if not self.`kubeProxyVersion`.isEmpty: return false
  if not self.`architecture`.isEmpty: return false
  if not self.`operatingSystem`.isEmpty: return false
  true

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

proc dump*(self: AttachedVolume, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`devicePath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"devicePath\":")
    self.`devicePath`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: AttachedVolume): bool =
  if not self.`devicePath`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: ContainerImage, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`sizeBytes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"sizeBytes\":")
    self.`sizeBytes`.dump(s)
  if not self.`names`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"names\":")
    self.`names`.dump(s)
  s.write("}")

proc isEmpty*(self: ContainerImage): bool =
  if not self.`sizeBytes`.isEmpty: return false
  if not self.`names`.isEmpty: return false
  true

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

proc dump*(self: NodeStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`phase`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"phase\":")
    self.`phase`.dump(s)
  if not self.`allocatable`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allocatable\":")
    self.`allocatable`.dump(s)
  if not self.`addresses`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"addresses\":")
    self.`addresses`.dump(s)
  if not self.`config`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"config\":")
    self.`config`.dump(s)
  if not self.`daemonEndpoints`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"daemonEndpoints\":")
    self.`daemonEndpoints`.dump(s)
  if not self.`nodeInfo`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nodeInfo\":")
    self.`nodeInfo`.dump(s)
  if not self.`volumesAttached`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumesAttached\":")
    self.`volumesAttached`.dump(s)
  if not self.`capacity`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"capacity\":")
    self.`capacity`.dump(s)
  if not self.`volumesInUse`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumesInUse\":")
    self.`volumesInUse`.dump(s)
  if not self.`images`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"images\":")
    self.`images`.dump(s)
  if not self.`conditions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conditions\":")
    self.`conditions`.dump(s)
  s.write("}")

proc isEmpty*(self: NodeStatus): bool =
  if not self.`phase`.isEmpty: return false
  if not self.`allocatable`.isEmpty: return false
  if not self.`addresses`.isEmpty: return false
  if not self.`config`.isEmpty: return false
  if not self.`daemonEndpoints`.isEmpty: return false
  if not self.`nodeInfo`.isEmpty: return false
  if not self.`volumesAttached`.isEmpty: return false
  if not self.`capacity`.isEmpty: return false
  if not self.`volumesInUse`.isEmpty: return false
  if not self.`images`.isEmpty: return false
  if not self.`conditions`.isEmpty: return false
  true

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

proc dump*(self: HTTPHeader, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`value`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"value\":")
    self.`value`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: HTTPHeader): bool =
  if not self.`value`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: HTTPGetAction, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`httpHeaders`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"httpHeaders\":")
    self.`httpHeaders`.dump(s)
  if not self.`port`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"port\":")
    self.`port`.dump(s)
  if not self.`host`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"host\":")
    self.`host`.dump(s)
  if not self.`scheme`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"scheme\":")
    self.`scheme`.dump(s)
  s.write("}")

proc isEmpty*(self: HTTPGetAction): bool =
  if not self.`path`.isEmpty: return false
  if not self.`httpHeaders`.isEmpty: return false
  if not self.`port`.isEmpty: return false
  if not self.`host`.isEmpty: return false
  if not self.`scheme`.isEmpty: return false
  true

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

proc dump*(self: ExecAction, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`command`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"command\":")
    self.`command`.dump(s)
  s.write("}")

proc isEmpty*(self: ExecAction): bool =
  if not self.`command`.isEmpty: return false
  true

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

proc dump*(self: TCPSocketAction, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`port`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"port\":")
    self.`port`.dump(s)
  if not self.`host`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"host\":")
    self.`host`.dump(s)
  s.write("}")

proc isEmpty*(self: TCPSocketAction): bool =
  if not self.`port`.isEmpty: return false
  if not self.`host`.isEmpty: return false
  true

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

proc dump*(self: Probe, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`failureThreshold`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"failureThreshold\":")
    self.`failureThreshold`.dump(s)
  if not self.`timeoutSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"timeoutSeconds\":")
    self.`timeoutSeconds`.dump(s)
  if not self.`initialDelaySeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"initialDelaySeconds\":")
    self.`initialDelaySeconds`.dump(s)
  if not self.`httpGet`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"httpGet\":")
    self.`httpGet`.dump(s)
  if not self.`exec`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"exec\":")
    self.`exec`.dump(s)
  if not self.`tcpSocket`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"tcpSocket\":")
    self.`tcpSocket`.dump(s)
  if not self.`successThreshold`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"successThreshold\":")
    self.`successThreshold`.dump(s)
  if not self.`periodSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"periodSeconds\":")
    self.`periodSeconds`.dump(s)
  s.write("}")

proc isEmpty*(self: Probe): bool =
  if not self.`failureThreshold`.isEmpty: return false
  if not self.`timeoutSeconds`.isEmpty: return false
  if not self.`initialDelaySeconds`.isEmpty: return false
  if not self.`httpGet`.isEmpty: return false
  if not self.`exec`.isEmpty: return false
  if not self.`tcpSocket`.isEmpty: return false
  if not self.`successThreshold`.isEmpty: return false
  if not self.`periodSeconds`.isEmpty: return false
  true

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

proc dump*(self: PersistentVolumeClaimCondition, s: Stream) =
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
  if not self.`lastProbeTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastProbeTime\":")
    self.`lastProbeTime`.dump(s)
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

proc isEmpty*(self: PersistentVolumeClaimCondition): bool =
  if not self.`lastTransitionTime`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`lastProbeTime`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

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

proc dump*(self: LocalObjectReference, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: LocalObjectReference): bool =
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: CSIVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`volumeAttributes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeAttributes\":")
    self.`volumeAttributes`.dump(s)
  if not self.`driver`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"driver\":")
    self.`driver`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`nodePublishSecretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nodePublishSecretRef\":")
    self.`nodePublishSecretRef`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  s.write("}")

proc isEmpty*(self: CSIVolumeSource): bool =
  if not self.`volumeAttributes`.isEmpty: return false
  if not self.`driver`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`nodePublishSecretRef`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  true

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

proc dump*(self: ConfigMapEnvSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`optional`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"optional\":")
    self.`optional`.dump(s)
  s.write("}")

proc isEmpty*(self: ConfigMapEnvSource): bool =
  if not self.`name`.isEmpty: return false
  if not self.`optional`.isEmpty: return false
  true

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

proc dump*(self: SecretEnvSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`optional`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"optional\":")
    self.`optional`.dump(s)
  s.write("}")

proc isEmpty*(self: SecretEnvSource): bool =
  if not self.`name`.isEmpty: return false
  if not self.`optional`.isEmpty: return false
  true

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

proc dump*(self: EnvFromSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`prefix`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"prefix\":")
    self.`prefix`.dump(s)
  if not self.`configMapRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"configMapRef\":")
    self.`configMapRef`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  s.write("}")

proc isEmpty*(self: EnvFromSource): bool =
  if not self.`prefix`.isEmpty: return false
  if not self.`configMapRef`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  true

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

proc dump*(self: TopologySelectorLabelRequirement, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`key`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"key\":")
    self.`key`.dump(s)
  if not self.`values`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"values\":")
    self.`values`.dump(s)
  s.write("}")

proc isEmpty*(self: TopologySelectorLabelRequirement): bool =
  if not self.`key`.isEmpty: return false
  if not self.`values`.isEmpty: return false
  true

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

proc dump*(self: TopologySelectorTerm, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`matchLabelExpressions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"matchLabelExpressions\":")
    self.`matchLabelExpressions`.dump(s)
  s.write("}")

proc isEmpty*(self: TopologySelectorTerm): bool =
  if not self.`matchLabelExpressions`.isEmpty: return false
  true

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

proc dump*(self: ObjectFieldSelector, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`fieldPath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fieldPath\":")
    self.`fieldPath`.dump(s)
  s.write("}")

proc isEmpty*(self: ObjectFieldSelector): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`fieldPath`.isEmpty: return false
  true

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

proc dump*(self: PodAffinityTerm, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`namespaces`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespaces\":")
    self.`namespaces`.dump(s)
  if not self.`labelSelector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"labelSelector\":")
    self.`labelSelector`.dump(s)
  if not self.`topologyKey`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"topologyKey\":")
    self.`topologyKey`.dump(s)
  s.write("}")

proc isEmpty*(self: PodAffinityTerm): bool =
  if not self.`namespaces`.isEmpty: return false
  if not self.`labelSelector`.isEmpty: return false
  if not self.`topologyKey`.isEmpty: return false
  true

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

proc dump*(self: WeightedPodAffinityTerm, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`podAffinityTerm`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"podAffinityTerm\":")
    self.`podAffinityTerm`.dump(s)
  if not self.`weight`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"weight\":")
    self.`weight`.dump(s)
  s.write("}")

proc isEmpty*(self: WeightedPodAffinityTerm): bool =
  if not self.`podAffinityTerm`.isEmpty: return false
  if not self.`weight`.isEmpty: return false
  true

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

proc dump*(self: PodAntiAffinity, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`preferredDuringSchedulingIgnoredDuringExecution`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"preferredDuringSchedulingIgnoredDuringExecution\":")
    self.`preferredDuringSchedulingIgnoredDuringExecution`.dump(s)
  if not self.`requiredDuringSchedulingIgnoredDuringExecution`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"requiredDuringSchedulingIgnoredDuringExecution\":")
    self.`requiredDuringSchedulingIgnoredDuringExecution`.dump(s)
  s.write("}")

proc isEmpty*(self: PodAntiAffinity): bool =
  if not self.`preferredDuringSchedulingIgnoredDuringExecution`.isEmpty: return false
  if not self.`requiredDuringSchedulingIgnoredDuringExecution`.isEmpty: return false
  true

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

proc dump*(self: NodeSelectorRequirement, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`key`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"key\":")
    self.`key`.dump(s)
  if not self.`values`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"values\":")
    self.`values`.dump(s)
  if not self.`operator`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"operator\":")
    self.`operator`.dump(s)
  s.write("}")

proc isEmpty*(self: NodeSelectorRequirement): bool =
  if not self.`key`.isEmpty: return false
  if not self.`values`.isEmpty: return false
  if not self.`operator`.isEmpty: return false
  true

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

proc dump*(self: NodeSelectorTerm, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`matchFields`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"matchFields\":")
    self.`matchFields`.dump(s)
  if not self.`matchExpressions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"matchExpressions\":")
    self.`matchExpressions`.dump(s)
  s.write("}")

proc isEmpty*(self: NodeSelectorTerm): bool =
  if not self.`matchFields`.isEmpty: return false
  if not self.`matchExpressions`.isEmpty: return false
  true

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

proc dump*(self: PreferredSchedulingTerm, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`preference`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"preference\":")
    self.`preference`.dump(s)
  if not self.`weight`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"weight\":")
    self.`weight`.dump(s)
  s.write("}")

proc isEmpty*(self: PreferredSchedulingTerm): bool =
  if not self.`preference`.isEmpty: return false
  if not self.`weight`.isEmpty: return false
  true

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

proc dump*(self: NodeSelector, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`nodeSelectorTerms`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nodeSelectorTerms\":")
    self.`nodeSelectorTerms`.dump(s)
  s.write("}")

proc isEmpty*(self: NodeSelector): bool =
  if not self.`nodeSelectorTerms`.isEmpty: return false
  true

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

proc dump*(self: NodeAffinity, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`preferredDuringSchedulingIgnoredDuringExecution`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"preferredDuringSchedulingIgnoredDuringExecution\":")
    self.`preferredDuringSchedulingIgnoredDuringExecution`.dump(s)
  if not self.`requiredDuringSchedulingIgnoredDuringExecution`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"requiredDuringSchedulingIgnoredDuringExecution\":")
    self.`requiredDuringSchedulingIgnoredDuringExecution`.dump(s)
  s.write("}")

proc isEmpty*(self: NodeAffinity): bool =
  if not self.`preferredDuringSchedulingIgnoredDuringExecution`.isEmpty: return false
  if not self.`requiredDuringSchedulingIgnoredDuringExecution`.isEmpty: return false
  true

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

proc dump*(self: PodAffinity, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`preferredDuringSchedulingIgnoredDuringExecution`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"preferredDuringSchedulingIgnoredDuringExecution\":")
    self.`preferredDuringSchedulingIgnoredDuringExecution`.dump(s)
  if not self.`requiredDuringSchedulingIgnoredDuringExecution`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"requiredDuringSchedulingIgnoredDuringExecution\":")
    self.`requiredDuringSchedulingIgnoredDuringExecution`.dump(s)
  s.write("}")

proc isEmpty*(self: PodAffinity): bool =
  if not self.`preferredDuringSchedulingIgnoredDuringExecution`.isEmpty: return false
  if not self.`requiredDuringSchedulingIgnoredDuringExecution`.isEmpty: return false
  true

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

proc dump*(self: Affinity, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`podAntiAffinity`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"podAntiAffinity\":")
    self.`podAntiAffinity`.dump(s)
  if not self.`nodeAffinity`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nodeAffinity\":")
    self.`nodeAffinity`.dump(s)
  if not self.`podAffinity`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"podAffinity\":")
    self.`podAffinity`.dump(s)
  s.write("}")

proc isEmpty*(self: Affinity): bool =
  if not self.`podAntiAffinity`.isEmpty: return false
  if not self.`nodeAffinity`.isEmpty: return false
  if not self.`podAffinity`.isEmpty: return false
  true

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

proc dump*(self: Handler, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`httpGet`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"httpGet\":")
    self.`httpGet`.dump(s)
  if not self.`exec`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"exec\":")
    self.`exec`.dump(s)
  if not self.`tcpSocket`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"tcpSocket\":")
    self.`tcpSocket`.dump(s)
  s.write("}")

proc isEmpty*(self: Handler): bool =
  if not self.`httpGet`.isEmpty: return false
  if not self.`exec`.isEmpty: return false
  if not self.`tcpSocket`.isEmpty: return false
  true

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

proc dump*(self: Lifecycle, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`preStop`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"preStop\":")
    self.`preStop`.dump(s)
  if not self.`postStart`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"postStart\":")
    self.`postStart`.dump(s)
  s.write("}")

proc isEmpty*(self: Lifecycle): bool =
  if not self.`preStop`.isEmpty: return false
  if not self.`postStart`.isEmpty: return false
  true

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

proc dump*(self: ContainerPort, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`hostPort`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostPort\":")
    self.`hostPort`.dump(s)
  if not self.`hostIP`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostIP\":")
    self.`hostIP`.dump(s)
  if not self.`protocol`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"protocol\":")
    self.`protocol`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`containerPort`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"containerPort\":")
    self.`containerPort`.dump(s)
  s.write("}")

proc isEmpty*(self: ContainerPort): bool =
  if not self.`hostPort`.isEmpty: return false
  if not self.`hostIP`.isEmpty: return false
  if not self.`protocol`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`containerPort`.isEmpty: return false
  true

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

proc dump*(self: ConfigMapKeySelector, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`key`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"key\":")
    self.`key`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`optional`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"optional\":")
    self.`optional`.dump(s)
  s.write("}")

proc isEmpty*(self: ConfigMapKeySelector): bool =
  if not self.`key`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`optional`.isEmpty: return false
  true

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

proc dump*(self: SecretKeySelector, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`key`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"key\":")
    self.`key`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`optional`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"optional\":")
    self.`optional`.dump(s)
  s.write("}")

proc isEmpty*(self: SecretKeySelector): bool =
  if not self.`key`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`optional`.isEmpty: return false
  true

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

proc dump*(self: ResourceFieldSelector, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`divisor`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"divisor\":")
    self.`divisor`.dump(s)
  if not self.`resource`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resource\":")
    self.`resource`.dump(s)
  if not self.`containerName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"containerName\":")
    self.`containerName`.dump(s)
  s.write("}")

proc isEmpty*(self: ResourceFieldSelector): bool =
  if not self.`divisor`.isEmpty: return false
  if not self.`resource`.isEmpty: return false
  if not self.`containerName`.isEmpty: return false
  true

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

proc dump*(self: EnvVarSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`fieldRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fieldRef\":")
    self.`fieldRef`.dump(s)
  if not self.`configMapKeyRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"configMapKeyRef\":")
    self.`configMapKeyRef`.dump(s)
  if not self.`secretKeyRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretKeyRef\":")
    self.`secretKeyRef`.dump(s)
  if not self.`resourceFieldRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resourceFieldRef\":")
    self.`resourceFieldRef`.dump(s)
  s.write("}")

proc isEmpty*(self: EnvVarSource): bool =
  if not self.`fieldRef`.isEmpty: return false
  if not self.`configMapKeyRef`.isEmpty: return false
  if not self.`secretKeyRef`.isEmpty: return false
  if not self.`resourceFieldRef`.isEmpty: return false
  true

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

proc dump*(self: EnvVar, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`value`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"value\":")
    self.`value`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`valueFrom`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"valueFrom\":")
    self.`valueFrom`.dump(s)
  s.write("}")

proc isEmpty*(self: EnvVar): bool =
  if not self.`value`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`valueFrom`.isEmpty: return false
  true

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

proc dump*(self: VolumeDevice, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`devicePath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"devicePath\":")
    self.`devicePath`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: VolumeDevice): bool =
  if not self.`devicePath`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: ResourceRequirements, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`limits`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"limits\":")
    self.`limits`.dump(s)
  if not self.`requests`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"requests\":")
    self.`requests`.dump(s)
  s.write("}")

proc isEmpty*(self: ResourceRequirements): bool =
  if not self.`limits`.isEmpty: return false
  if not self.`requests`.isEmpty: return false
  true

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

proc dump*(self: VolumeMount, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`mountPropagation`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"mountPropagation\":")
    self.`mountPropagation`.dump(s)
  if not self.`subPathExpr`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"subPathExpr\":")
    self.`subPathExpr`.dump(s)
  if not self.`subPath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"subPath\":")
    self.`subPath`.dump(s)
  if not self.`mountPath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"mountPath\":")
    self.`mountPath`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  s.write("}")

proc isEmpty*(self: VolumeMount): bool =
  if not self.`mountPropagation`.isEmpty: return false
  if not self.`subPathExpr`.isEmpty: return false
  if not self.`subPath`.isEmpty: return false
  if not self.`mountPath`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  true

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

proc dump*(self: SELinuxOptions, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`level`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"level\":")
    self.`level`.dump(s)
  if not self.`user`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"user\":")
    self.`user`.dump(s)
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`role`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"role\":")
    self.`role`.dump(s)
  s.write("}")

proc isEmpty*(self: SELinuxOptions): bool =
  if not self.`level`.isEmpty: return false
  if not self.`user`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`role`.isEmpty: return false
  true

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

proc dump*(self: Capabilities, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`drop`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"drop\":")
    self.`drop`.dump(s)
  if not self.`add`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"add\":")
    self.`add`.dump(s)
  s.write("}")

proc isEmpty*(self: Capabilities): bool =
  if not self.`drop`.isEmpty: return false
  if not self.`add`.isEmpty: return false
  true

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

proc dump*(self: WindowsSecurityContextOptions, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`runAsUserName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"runAsUserName\":")
    self.`runAsUserName`.dump(s)
  if not self.`gmsaCredentialSpecName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"gmsaCredentialSpecName\":")
    self.`gmsaCredentialSpecName`.dump(s)
  if not self.`gmsaCredentialSpec`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"gmsaCredentialSpec\":")
    self.`gmsaCredentialSpec`.dump(s)
  s.write("}")

proc isEmpty*(self: WindowsSecurityContextOptions): bool =
  if not self.`runAsUserName`.isEmpty: return false
  if not self.`gmsaCredentialSpecName`.isEmpty: return false
  if not self.`gmsaCredentialSpec`.isEmpty: return false
  true

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

proc dump*(self: SecurityContext, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`readOnlyRootFilesystem`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnlyRootFilesystem\":")
    self.`readOnlyRootFilesystem`.dump(s)
  if not self.`allowPrivilegeEscalation`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allowPrivilegeEscalation\":")
    self.`allowPrivilegeEscalation`.dump(s)
  if not self.`procMount`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"procMount\":")
    self.`procMount`.dump(s)
  if not self.`runAsNonRoot`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"runAsNonRoot\":")
    self.`runAsNonRoot`.dump(s)
  if not self.`seLinuxOptions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"seLinuxOptions\":")
    self.`seLinuxOptions`.dump(s)
  if not self.`runAsGroup`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"runAsGroup\":")
    self.`runAsGroup`.dump(s)
  if not self.`capabilities`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"capabilities\":")
    self.`capabilities`.dump(s)
  if not self.`privileged`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"privileged\":")
    self.`privileged`.dump(s)
  if not self.`runAsUser`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"runAsUser\":")
    self.`runAsUser`.dump(s)
  if not self.`windowsOptions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"windowsOptions\":")
    self.`windowsOptions`.dump(s)
  s.write("}")

proc isEmpty*(self: SecurityContext): bool =
  if not self.`readOnlyRootFilesystem`.isEmpty: return false
  if not self.`allowPrivilegeEscalation`.isEmpty: return false
  if not self.`procMount`.isEmpty: return false
  if not self.`runAsNonRoot`.isEmpty: return false
  if not self.`seLinuxOptions`.isEmpty: return false
  if not self.`runAsGroup`.isEmpty: return false
  if not self.`capabilities`.isEmpty: return false
  if not self.`privileged`.isEmpty: return false
  if not self.`runAsUser`.isEmpty: return false
  if not self.`windowsOptions`.isEmpty: return false
  true

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

proc dump*(self: EphemeralContainer, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`terminationMessagePolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"terminationMessagePolicy\":")
    self.`terminationMessagePolicy`.dump(s)
  if not self.`command`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"command\":")
    self.`command`.dump(s)
  if not self.`image`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"image\":")
    self.`image`.dump(s)
  if not self.`stdinOnce`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"stdinOnce\":")
    self.`stdinOnce`.dump(s)
  if not self.`lifecycle`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lifecycle\":")
    self.`lifecycle`.dump(s)
  if not self.`ports`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ports\":")
    self.`ports`.dump(s)
  if not self.`terminationMessagePath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"terminationMessagePath\":")
    self.`terminationMessagePath`.dump(s)
  if not self.`env`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"env\":")
    self.`env`.dump(s)
  if not self.`volumeDevices`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeDevices\":")
    self.`volumeDevices`.dump(s)
  if not self.`readinessProbe`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readinessProbe\":")
    self.`readinessProbe`.dump(s)
  if not self.`tty`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"tty\":")
    self.`tty`.dump(s)
  if not self.`startupProbe`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"startupProbe\":")
    self.`startupProbe`.dump(s)
  if not self.`resources`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resources\":")
    self.`resources`.dump(s)
  if not self.`imagePullPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"imagePullPolicy\":")
    self.`imagePullPolicy`.dump(s)
  if not self.`stdin`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"stdin\":")
    self.`stdin`.dump(s)
  if not self.`workingDir`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"workingDir\":")
    self.`workingDir`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`volumeMounts`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeMounts\":")
    self.`volumeMounts`.dump(s)
  if not self.`securityContext`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"securityContext\":")
    self.`securityContext`.dump(s)
  if not self.`envFrom`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"envFrom\":")
    self.`envFrom`.dump(s)
  if not self.`livenessProbe`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"livenessProbe\":")
    self.`livenessProbe`.dump(s)
  if not self.`targetContainerName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"targetContainerName\":")
    self.`targetContainerName`.dump(s)
  if not self.`args`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"args\":")
    self.`args`.dump(s)
  s.write("}")

proc isEmpty*(self: EphemeralContainer): bool =
  if not self.`terminationMessagePolicy`.isEmpty: return false
  if not self.`command`.isEmpty: return false
  if not self.`image`.isEmpty: return false
  if not self.`stdinOnce`.isEmpty: return false
  if not self.`lifecycle`.isEmpty: return false
  if not self.`ports`.isEmpty: return false
  if not self.`terminationMessagePath`.isEmpty: return false
  if not self.`env`.isEmpty: return false
  if not self.`volumeDevices`.isEmpty: return false
  if not self.`readinessProbe`.isEmpty: return false
  if not self.`tty`.isEmpty: return false
  if not self.`startupProbe`.isEmpty: return false
  if not self.`resources`.isEmpty: return false
  if not self.`imagePullPolicy`.isEmpty: return false
  if not self.`stdin`.isEmpty: return false
  if not self.`workingDir`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`volumeMounts`.isEmpty: return false
  if not self.`securityContext`.isEmpty: return false
  if not self.`envFrom`.isEmpty: return false
  if not self.`livenessProbe`.isEmpty: return false
  if not self.`targetContainerName`.isEmpty: return false
  if not self.`args`.isEmpty: return false
  true

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

proc dump*(self: PodDNSConfigOption, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`value`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"value\":")
    self.`value`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: PodDNSConfigOption): bool =
  if not self.`value`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: PodDNSConfig, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`nameservers`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nameservers\":")
    self.`nameservers`.dump(s)
  if not self.`options`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"options\":")
    self.`options`.dump(s)
  if not self.`searches`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"searches\":")
    self.`searches`.dump(s)
  s.write("}")

proc isEmpty*(self: PodDNSConfig): bool =
  if not self.`nameservers`.isEmpty: return false
  if not self.`options`.isEmpty: return false
  if not self.`searches`.isEmpty: return false
  true

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

proc dump*(self: HostAlias, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`hostnames`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostnames\":")
    self.`hostnames`.dump(s)
  if not self.`ip`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ip\":")
    self.`ip`.dump(s)
  s.write("}")

proc isEmpty*(self: HostAlias): bool =
  if not self.`hostnames`.isEmpty: return false
  if not self.`ip`.isEmpty: return false
  true

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

proc dump*(self: Container, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`terminationMessagePolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"terminationMessagePolicy\":")
    self.`terminationMessagePolicy`.dump(s)
  if not self.`command`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"command\":")
    self.`command`.dump(s)
  if not self.`image`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"image\":")
    self.`image`.dump(s)
  if not self.`stdinOnce`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"stdinOnce\":")
    self.`stdinOnce`.dump(s)
  if not self.`lifecycle`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lifecycle\":")
    self.`lifecycle`.dump(s)
  if not self.`ports`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ports\":")
    self.`ports`.dump(s)
  if not self.`terminationMessagePath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"terminationMessagePath\":")
    self.`terminationMessagePath`.dump(s)
  if not self.`env`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"env\":")
    self.`env`.dump(s)
  if not self.`volumeDevices`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeDevices\":")
    self.`volumeDevices`.dump(s)
  if not self.`readinessProbe`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readinessProbe\":")
    self.`readinessProbe`.dump(s)
  if not self.`tty`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"tty\":")
    self.`tty`.dump(s)
  if not self.`startupProbe`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"startupProbe\":")
    self.`startupProbe`.dump(s)
  if not self.`resources`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resources\":")
    self.`resources`.dump(s)
  if not self.`imagePullPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"imagePullPolicy\":")
    self.`imagePullPolicy`.dump(s)
  if not self.`stdin`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"stdin\":")
    self.`stdin`.dump(s)
  if not self.`workingDir`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"workingDir\":")
    self.`workingDir`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`volumeMounts`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeMounts\":")
    self.`volumeMounts`.dump(s)
  if not self.`securityContext`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"securityContext\":")
    self.`securityContext`.dump(s)
  if not self.`envFrom`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"envFrom\":")
    self.`envFrom`.dump(s)
  if not self.`livenessProbe`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"livenessProbe\":")
    self.`livenessProbe`.dump(s)
  if not self.`args`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"args\":")
    self.`args`.dump(s)
  s.write("}")

proc isEmpty*(self: Container): bool =
  if not self.`terminationMessagePolicy`.isEmpty: return false
  if not self.`command`.isEmpty: return false
  if not self.`image`.isEmpty: return false
  if not self.`stdinOnce`.isEmpty: return false
  if not self.`lifecycle`.isEmpty: return false
  if not self.`ports`.isEmpty: return false
  if not self.`terminationMessagePath`.isEmpty: return false
  if not self.`env`.isEmpty: return false
  if not self.`volumeDevices`.isEmpty: return false
  if not self.`readinessProbe`.isEmpty: return false
  if not self.`tty`.isEmpty: return false
  if not self.`startupProbe`.isEmpty: return false
  if not self.`resources`.isEmpty: return false
  if not self.`imagePullPolicy`.isEmpty: return false
  if not self.`stdin`.isEmpty: return false
  if not self.`workingDir`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`volumeMounts`.isEmpty: return false
  if not self.`securityContext`.isEmpty: return false
  if not self.`envFrom`.isEmpty: return false
  if not self.`livenessProbe`.isEmpty: return false
  if not self.`args`.isEmpty: return false
  true

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

proc dump*(self: Toleration, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`key`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"key\":")
    self.`key`.dump(s)
  if not self.`effect`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"effect\":")
    self.`effect`.dump(s)
  if not self.`operator`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"operator\":")
    self.`operator`.dump(s)
  if not self.`value`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"value\":")
    self.`value`.dump(s)
  if not self.`tolerationSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"tolerationSeconds\":")
    self.`tolerationSeconds`.dump(s)
  s.write("}")

proc isEmpty*(self: Toleration): bool =
  if not self.`key`.isEmpty: return false
  if not self.`effect`.isEmpty: return false
  if not self.`operator`.isEmpty: return false
  if not self.`value`.isEmpty: return false
  if not self.`tolerationSeconds`.isEmpty: return false
  true

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

proc dump*(self: PodReadinessGate, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`conditionType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conditionType\":")
    self.`conditionType`.dump(s)
  s.write("}")

proc isEmpty*(self: PodReadinessGate): bool =
  if not self.`conditionType`.isEmpty: return false
  true

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

proc dump*(self: Sysctl, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`value`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"value\":")
    self.`value`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: Sysctl): bool =
  if not self.`value`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: PodSecurityContext, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`fsGroup`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsGroup\":")
    self.`fsGroup`.dump(s)
  if not self.`supplementalGroups`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"supplementalGroups\":")
    self.`supplementalGroups`.dump(s)
  if not self.`sysctls`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"sysctls\":")
    self.`sysctls`.dump(s)
  if not self.`runAsNonRoot`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"runAsNonRoot\":")
    self.`runAsNonRoot`.dump(s)
  if not self.`seLinuxOptions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"seLinuxOptions\":")
    self.`seLinuxOptions`.dump(s)
  if not self.`runAsGroup`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"runAsGroup\":")
    self.`runAsGroup`.dump(s)
  if not self.`windowsOptions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"windowsOptions\":")
    self.`windowsOptions`.dump(s)
  if not self.`runAsUser`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"runAsUser\":")
    self.`runAsUser`.dump(s)
  s.write("}")

proc isEmpty*(self: PodSecurityContext): bool =
  if not self.`fsGroup`.isEmpty: return false
  if not self.`supplementalGroups`.isEmpty: return false
  if not self.`sysctls`.isEmpty: return false
  if not self.`runAsNonRoot`.isEmpty: return false
  if not self.`seLinuxOptions`.isEmpty: return false
  if not self.`runAsGroup`.isEmpty: return false
  if not self.`windowsOptions`.isEmpty: return false
  if not self.`runAsUser`.isEmpty: return false
  true

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

proc dump*(self: TopologySpreadConstraint, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`labelSelector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"labelSelector\":")
    self.`labelSelector`.dump(s)
  if not self.`maxSkew`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"maxSkew\":")
    self.`maxSkew`.dump(s)
  if not self.`whenUnsatisfiable`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"whenUnsatisfiable\":")
    self.`whenUnsatisfiable`.dump(s)
  if not self.`topologyKey`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"topologyKey\":")
    self.`topologyKey`.dump(s)
  s.write("}")

proc isEmpty*(self: TopologySpreadConstraint): bool =
  if not self.`labelSelector`.isEmpty: return false
  if not self.`maxSkew`.isEmpty: return false
  if not self.`whenUnsatisfiable`.isEmpty: return false
  if not self.`topologyKey`.isEmpty: return false
  true

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

proc dump*(self: VsphereVirtualDiskVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`storagePolicyName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"storagePolicyName\":")
    self.`storagePolicyName`.dump(s)
  if not self.`storagePolicyID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"storagePolicyID\":")
    self.`storagePolicyID`.dump(s)
  if not self.`volumePath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumePath\":")
    self.`volumePath`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  s.write("}")

proc isEmpty*(self: VsphereVirtualDiskVolumeSource): bool =
  if not self.`storagePolicyName`.isEmpty: return false
  if not self.`storagePolicyID`.isEmpty: return false
  if not self.`volumePath`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  true

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

proc dump*(self: AzureFileVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`shareName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"shareName\":")
    self.`shareName`.dump(s)
  if not self.`secretName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretName\":")
    self.`secretName`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  s.write("}")

proc isEmpty*(self: AzureFileVolumeSource): bool =
  if not self.`shareName`.isEmpty: return false
  if not self.`secretName`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  true

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

proc dump*(self: RBDVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`user`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"user\":")
    self.`user`.dump(s)
  if not self.`monitors`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"monitors\":")
    self.`monitors`.dump(s)
  if not self.`image`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"image\":")
    self.`image`.dump(s)
  if not self.`keyring`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"keyring\":")
    self.`keyring`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  if not self.`pool`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"pool\":")
    self.`pool`.dump(s)
  s.write("}")

proc isEmpty*(self: RBDVolumeSource): bool =
  if not self.`user`.isEmpty: return false
  if not self.`monitors`.isEmpty: return false
  if not self.`image`.isEmpty: return false
  if not self.`keyring`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  if not self.`pool`.isEmpty: return false
  true

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

proc dump*(self: CephFSVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`user`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"user\":")
    self.`user`.dump(s)
  if not self.`monitors`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"monitors\":")
    self.`monitors`.dump(s)
  if not self.`secretFile`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretFile\":")
    self.`secretFile`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  s.write("}")

proc isEmpty*(self: CephFSVolumeSource): bool =
  if not self.`path`.isEmpty: return false
  if not self.`user`.isEmpty: return false
  if not self.`monitors`.isEmpty: return false
  if not self.`secretFile`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  true

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

proc dump*(self: DownwardAPIVolumeFile, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`fieldRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fieldRef\":")
    self.`fieldRef`.dump(s)
  if not self.`mode`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"mode\":")
    self.`mode`.dump(s)
  if not self.`resourceFieldRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resourceFieldRef\":")
    self.`resourceFieldRef`.dump(s)
  s.write("}")

proc isEmpty*(self: DownwardAPIVolumeFile): bool =
  if not self.`path`.isEmpty: return false
  if not self.`fieldRef`.isEmpty: return false
  if not self.`mode`.isEmpty: return false
  if not self.`resourceFieldRef`.isEmpty: return false
  true

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

proc dump*(self: DownwardAPIProjection, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
  s.write("}")

proc isEmpty*(self: DownwardAPIProjection): bool =
  if not self.`items`.isEmpty: return false
  true

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

proc dump*(self: ServiceAccountTokenProjection, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`expirationSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"expirationSeconds\":")
    self.`expirationSeconds`.dump(s)
  if not self.`audience`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"audience\":")
    self.`audience`.dump(s)
  s.write("}")

proc isEmpty*(self: ServiceAccountTokenProjection): bool =
  if not self.`path`.isEmpty: return false
  if not self.`expirationSeconds`.isEmpty: return false
  if not self.`audience`.isEmpty: return false
  true

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

proc dump*(self: KeyToPath, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`key`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"key\":")
    self.`key`.dump(s)
  if not self.`mode`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"mode\":")
    self.`mode`.dump(s)
  s.write("}")

proc isEmpty*(self: KeyToPath): bool =
  if not self.`path`.isEmpty: return false
  if not self.`key`.isEmpty: return false
  if not self.`mode`.isEmpty: return false
  true

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

proc dump*(self: SecretProjection, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`optional`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"optional\":")
    self.`optional`.dump(s)
  s.write("}")

proc isEmpty*(self: SecretProjection): bool =
  if not self.`items`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`optional`.isEmpty: return false
  true

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

proc dump*(self: ConfigMapProjection, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`optional`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"optional\":")
    self.`optional`.dump(s)
  s.write("}")

proc isEmpty*(self: ConfigMapProjection): bool =
  if not self.`items`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`optional`.isEmpty: return false
  true

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

proc dump*(self: VolumeProjection, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`downwardAPI`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"downwardAPI\":")
    self.`downwardAPI`.dump(s)
  if not self.`serviceAccountToken`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"serviceAccountToken\":")
    self.`serviceAccountToken`.dump(s)
  if not self.`secret`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secret\":")
    self.`secret`.dump(s)
  if not self.`configMap`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"configMap\":")
    self.`configMap`.dump(s)
  s.write("}")

proc isEmpty*(self: VolumeProjection): bool =
  if not self.`downwardAPI`.isEmpty: return false
  if not self.`serviceAccountToken`.isEmpty: return false
  if not self.`secret`.isEmpty: return false
  if not self.`configMap`.isEmpty: return false
  true

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

proc dump*(self: ProjectedVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`defaultMode`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"defaultMode\":")
    self.`defaultMode`.dump(s)
  if not self.`sources`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"sources\":")
    self.`sources`.dump(s)
  s.write("}")

proc isEmpty*(self: ProjectedVolumeSource): bool =
  if not self.`defaultMode`.isEmpty: return false
  if not self.`sources`.isEmpty: return false
  true

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

proc dump*(self: HostPathVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  s.write("}")

proc isEmpty*(self: HostPathVolumeSource): bool =
  if not self.`path`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  true

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

proc dump*(self: GlusterfsVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`endpoints`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"endpoints\":")
    self.`endpoints`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  s.write("}")

proc isEmpty*(self: GlusterfsVolumeSource): bool =
  if not self.`path`.isEmpty: return false
  if not self.`endpoints`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  true

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

proc dump*(self: GCEPersistentDiskVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`partition`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"partition\":")
    self.`partition`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`pdName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"pdName\":")
    self.`pdName`.dump(s)
  s.write("}")

proc isEmpty*(self: GCEPersistentDiskVolumeSource): bool =
  if not self.`partition`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`pdName`.isEmpty: return false
  true

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

proc dump*(self: QuobyteVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`user`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"user\":")
    self.`user`.dump(s)
  if not self.`registry`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"registry\":")
    self.`registry`.dump(s)
  if not self.`volume`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volume\":")
    self.`volume`.dump(s)
  if not self.`group`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"group\":")
    self.`group`.dump(s)
  if not self.`tenant`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"tenant\":")
    self.`tenant`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  s.write("}")

proc isEmpty*(self: QuobyteVolumeSource): bool =
  if not self.`user`.isEmpty: return false
  if not self.`registry`.isEmpty: return false
  if not self.`volume`.isEmpty: return false
  if not self.`group`.isEmpty: return false
  if not self.`tenant`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  true

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

proc dump*(self: NFSVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`server`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"server\":")
    self.`server`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  s.write("}")

proc isEmpty*(self: NFSVolumeSource): bool =
  if not self.`path`.isEmpty: return false
  if not self.`server`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  true

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

proc dump*(self: EmptyDirVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`sizeLimit`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"sizeLimit\":")
    self.`sizeLimit`.dump(s)
  if not self.`medium`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"medium\":")
    self.`medium`.dump(s)
  s.write("}")

proc isEmpty*(self: EmptyDirVolumeSource): bool =
  if not self.`sizeLimit`.isEmpty: return false
  if not self.`medium`.isEmpty: return false
  true

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

proc dump*(self: FlockerVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`datasetName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"datasetName\":")
    self.`datasetName`.dump(s)
  if not self.`datasetUUID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"datasetUUID\":")
    self.`datasetUUID`.dump(s)
  s.write("}")

proc isEmpty*(self: FlockerVolumeSource): bool =
  if not self.`datasetName`.isEmpty: return false
  if not self.`datasetUUID`.isEmpty: return false
  true

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

proc dump*(self: DownwardAPIVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
  if not self.`defaultMode`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"defaultMode\":")
    self.`defaultMode`.dump(s)
  s.write("}")

proc isEmpty*(self: DownwardAPIVolumeSource): bool =
  if not self.`items`.isEmpty: return false
  if not self.`defaultMode`.isEmpty: return false
  true

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

proc dump*(self: PersistentVolumeClaimVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`claimName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"claimName\":")
    self.`claimName`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  s.write("}")

proc isEmpty*(self: PersistentVolumeClaimVolumeSource): bool =
  if not self.`claimName`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  true

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

proc dump*(self: ScaleIOVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`storageMode`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"storageMode\":")
    self.`storageMode`.dump(s)
  if not self.`volumeName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeName\":")
    self.`volumeName`.dump(s)
  if not self.`storagePool`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"storagePool\":")
    self.`storagePool`.dump(s)
  if not self.`gateway`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"gateway\":")
    self.`gateway`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  if not self.`system`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"system\":")
    self.`system`.dump(s)
  if not self.`sslEnabled`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"sslEnabled\":")
    self.`sslEnabled`.dump(s)
  if not self.`protectionDomain`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"protectionDomain\":")
    self.`protectionDomain`.dump(s)
  s.write("}")

proc isEmpty*(self: ScaleIOVolumeSource): bool =
  if not self.`storageMode`.isEmpty: return false
  if not self.`volumeName`.isEmpty: return false
  if not self.`storagePool`.isEmpty: return false
  if not self.`gateway`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  if not self.`system`.isEmpty: return false
  if not self.`sslEnabled`.isEmpty: return false
  if not self.`protectionDomain`.isEmpty: return false
  true

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

proc dump*(self: FlexVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`driver`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"driver\":")
    self.`driver`.dump(s)
  if not self.`options`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"options\":")
    self.`options`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  s.write("}")

proc isEmpty*(self: FlexVolumeSource): bool =
  if not self.`driver`.isEmpty: return false
  if not self.`options`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  true

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

proc dump*(self: SecretVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
  if not self.`secretName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretName\":")
    self.`secretName`.dump(s)
  if not self.`defaultMode`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"defaultMode\":")
    self.`defaultMode`.dump(s)
  if not self.`optional`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"optional\":")
    self.`optional`.dump(s)
  s.write("}")

proc isEmpty*(self: SecretVolumeSource): bool =
  if not self.`items`.isEmpty: return false
  if not self.`secretName`.isEmpty: return false
  if not self.`defaultMode`.isEmpty: return false
  if not self.`optional`.isEmpty: return false
  true

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

proc dump*(self: ConfigMapVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
  if not self.`defaultMode`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"defaultMode\":")
    self.`defaultMode`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`optional`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"optional\":")
    self.`optional`.dump(s)
  s.write("}")

proc isEmpty*(self: ConfigMapVolumeSource): bool =
  if not self.`items`.isEmpty: return false
  if not self.`defaultMode`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`optional`.isEmpty: return false
  true

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

proc dump*(self: PortworxVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`volumeID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeID\":")
    self.`volumeID`.dump(s)
  s.write("}")

proc isEmpty*(self: PortworxVolumeSource): bool =
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`volumeID`.isEmpty: return false
  true

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

proc dump*(self: GitRepoVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`repository`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"repository\":")
    self.`repository`.dump(s)
  if not self.`directory`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"directory\":")
    self.`directory`.dump(s)
  if not self.`revision`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"revision\":")
    self.`revision`.dump(s)
  s.write("}")

proc isEmpty*(self: GitRepoVolumeSource): bool =
  if not self.`repository`.isEmpty: return false
  if not self.`directory`.isEmpty: return false
  if not self.`revision`.isEmpty: return false
  true

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

proc dump*(self: AzureDiskVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`diskURI`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"diskURI\":")
    self.`diskURI`.dump(s)
  if not self.`cachingMode`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"cachingMode\":")
    self.`cachingMode`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`diskName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"diskName\":")
    self.`diskName`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  s.write("}")

proc isEmpty*(self: AzureDiskVolumeSource): bool =
  if not self.`diskURI`.isEmpty: return false
  if not self.`cachingMode`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`diskName`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

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

proc dump*(self: CinderVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  if not self.`volumeID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeID\":")
    self.`volumeID`.dump(s)
  s.write("}")

proc isEmpty*(self: CinderVolumeSource): bool =
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  if not self.`volumeID`.isEmpty: return false
  true

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

proc dump*(self: FCVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`lun`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lun\":")
    self.`lun`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`targetWWNs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"targetWWNs\":")
    self.`targetWWNs`.dump(s)
  if not self.`wwids`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"wwids\":")
    self.`wwids`.dump(s)
  s.write("}")

proc isEmpty*(self: FCVolumeSource): bool =
  if not self.`lun`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`targetWWNs`.isEmpty: return false
  if not self.`wwids`.isEmpty: return false
  true

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

proc dump*(self: StorageOSVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`volumeName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeName\":")
    self.`volumeName`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  if not self.`volumeNamespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeNamespace\":")
    self.`volumeNamespace`.dump(s)
  s.write("}")

proc isEmpty*(self: StorageOSVolumeSource): bool =
  if not self.`volumeName`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  if not self.`volumeNamespace`.isEmpty: return false
  true

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

proc dump*(self: AWSElasticBlockStoreVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`partition`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"partition\":")
    self.`partition`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`volumeID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeID\":")
    self.`volumeID`.dump(s)
  s.write("}")

proc isEmpty*(self: AWSElasticBlockStoreVolumeSource): bool =
  if not self.`partition`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`volumeID`.isEmpty: return false
  true

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

proc dump*(self: ISCSIVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`iqn`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"iqn\":")
    self.`iqn`.dump(s)
  if not self.`iscsiInterface`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"iscsiInterface\":")
    self.`iscsiInterface`.dump(s)
  if not self.`lun`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lun\":")
    self.`lun`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  if not self.`chapAuthDiscovery`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"chapAuthDiscovery\":")
    self.`chapAuthDiscovery`.dump(s)
  if not self.`chapAuthSession`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"chapAuthSession\":")
    self.`chapAuthSession`.dump(s)
  if not self.`initiatorName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"initiatorName\":")
    self.`initiatorName`.dump(s)
  if not self.`portals`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"portals\":")
    self.`portals`.dump(s)
  if not self.`targetPortal`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"targetPortal\":")
    self.`targetPortal`.dump(s)
  s.write("}")

proc isEmpty*(self: ISCSIVolumeSource): bool =
  if not self.`iqn`.isEmpty: return false
  if not self.`iscsiInterface`.isEmpty: return false
  if not self.`lun`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  if not self.`chapAuthDiscovery`.isEmpty: return false
  if not self.`chapAuthSession`.isEmpty: return false
  if not self.`initiatorName`.isEmpty: return false
  if not self.`portals`.isEmpty: return false
  if not self.`targetPortal`.isEmpty: return false
  true

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

proc dump*(self: PhotonPersistentDiskVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`pdID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"pdID\":")
    self.`pdID`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  s.write("}")

proc isEmpty*(self: PhotonPersistentDiskVolumeSource): bool =
  if not self.`pdID`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  true

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

proc dump*(self: Volume, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`vsphereVolume`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"vsphereVolume\":")
    self.`vsphereVolume`.dump(s)
  if not self.`azureFile`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"azureFile\":")
    self.`azureFile`.dump(s)
  if not self.`rbd`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rbd\":")
    self.`rbd`.dump(s)
  if not self.`cephfs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"cephfs\":")
    self.`cephfs`.dump(s)
  if not self.`projected`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"projected\":")
    self.`projected`.dump(s)
  if not self.`hostPath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostPath\":")
    self.`hostPath`.dump(s)
  if not self.`glusterfs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"glusterfs\":")
    self.`glusterfs`.dump(s)
  if not self.`gcePersistentDisk`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"gcePersistentDisk\":")
    self.`gcePersistentDisk`.dump(s)
  if not self.`quobyte`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"quobyte\":")
    self.`quobyte`.dump(s)
  if not self.`nfs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nfs\":")
    self.`nfs`.dump(s)
  if not self.`emptyDir`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"emptyDir\":")
    self.`emptyDir`.dump(s)
  if not self.`flocker`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"flocker\":")
    self.`flocker`.dump(s)
  if not self.`downwardAPI`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"downwardAPI\":")
    self.`downwardAPI`.dump(s)
  if not self.`persistentVolumeClaim`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"persistentVolumeClaim\":")
    self.`persistentVolumeClaim`.dump(s)
  if not self.`scaleIO`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"scaleIO\":")
    self.`scaleIO`.dump(s)
  if not self.`flexVolume`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"flexVolume\":")
    self.`flexVolume`.dump(s)
  if not self.`secret`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secret\":")
    self.`secret`.dump(s)
  if not self.`configMap`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"configMap\":")
    self.`configMap`.dump(s)
  if not self.`portworxVolume`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"portworxVolume\":")
    self.`portworxVolume`.dump(s)
  if not self.`gitRepo`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"gitRepo\":")
    self.`gitRepo`.dump(s)
  if not self.`azureDisk`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"azureDisk\":")
    self.`azureDisk`.dump(s)
  if not self.`cinder`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"cinder\":")
    self.`cinder`.dump(s)
  if not self.`fc`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fc\":")
    self.`fc`.dump(s)
  if not self.`csi`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"csi\":")
    self.`csi`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`storageos`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"storageos\":")
    self.`storageos`.dump(s)
  if not self.`awsElasticBlockStore`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"awsElasticBlockStore\":")
    self.`awsElasticBlockStore`.dump(s)
  if not self.`iscsi`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"iscsi\":")
    self.`iscsi`.dump(s)
  if not self.`photonPersistentDisk`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"photonPersistentDisk\":")
    self.`photonPersistentDisk`.dump(s)
  s.write("}")

proc isEmpty*(self: Volume): bool =
  if not self.`vsphereVolume`.isEmpty: return false
  if not self.`azureFile`.isEmpty: return false
  if not self.`rbd`.isEmpty: return false
  if not self.`cephfs`.isEmpty: return false
  if not self.`projected`.isEmpty: return false
  if not self.`hostPath`.isEmpty: return false
  if not self.`glusterfs`.isEmpty: return false
  if not self.`gcePersistentDisk`.isEmpty: return false
  if not self.`quobyte`.isEmpty: return false
  if not self.`nfs`.isEmpty: return false
  if not self.`emptyDir`.isEmpty: return false
  if not self.`flocker`.isEmpty: return false
  if not self.`downwardAPI`.isEmpty: return false
  if not self.`persistentVolumeClaim`.isEmpty: return false
  if not self.`scaleIO`.isEmpty: return false
  if not self.`flexVolume`.isEmpty: return false
  if not self.`secret`.isEmpty: return false
  if not self.`configMap`.isEmpty: return false
  if not self.`portworxVolume`.isEmpty: return false
  if not self.`gitRepo`.isEmpty: return false
  if not self.`azureDisk`.isEmpty: return false
  if not self.`cinder`.isEmpty: return false
  if not self.`fc`.isEmpty: return false
  if not self.`csi`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`storageos`.isEmpty: return false
  if not self.`awsElasticBlockStore`.isEmpty: return false
  if not self.`iscsi`.isEmpty: return false
  if not self.`photonPersistentDisk`.isEmpty: return false
  true

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

proc dump*(self: PodSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`affinity`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"affinity\":")
    self.`affinity`.dump(s)
  if not self.`ephemeralContainers`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ephemeralContainers\":")
    self.`ephemeralContainers`.dump(s)
  if not self.`dnsConfig`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"dnsConfig\":")
    self.`dnsConfig`.dump(s)
  if not self.`subdomain`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"subdomain\":")
    self.`subdomain`.dump(s)
  if not self.`hostAliases`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostAliases\":")
    self.`hostAliases`.dump(s)
  if not self.`activeDeadlineSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"activeDeadlineSeconds\":")
    self.`activeDeadlineSeconds`.dump(s)
  if not self.`containers`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"containers\":")
    self.`containers`.dump(s)
  if not self.`priorityClassName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"priorityClassName\":")
    self.`priorityClassName`.dump(s)
  if not self.`tolerations`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"tolerations\":")
    self.`tolerations`.dump(s)
  if not self.`imagePullSecrets`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"imagePullSecrets\":")
    self.`imagePullSecrets`.dump(s)
  if not self.`nodeSelector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nodeSelector\":")
    self.`nodeSelector`.dump(s)
  if not self.`priority`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"priority\":")
    self.`priority`.dump(s)
  if not self.`nodeName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nodeName\":")
    self.`nodeName`.dump(s)
  if not self.`serviceAccountName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"serviceAccountName\":")
    self.`serviceAccountName`.dump(s)
  if not self.`terminationGracePeriodSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"terminationGracePeriodSeconds\":")
    self.`terminationGracePeriodSeconds`.dump(s)
  if not self.`shareProcessNamespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"shareProcessNamespace\":")
    self.`shareProcessNamespace`.dump(s)
  if not self.`restartPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"restartPolicy\":")
    self.`restartPolicy`.dump(s)
  if not self.`hostname`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostname\":")
    self.`hostname`.dump(s)
  if not self.`initContainers`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"initContainers\":")
    self.`initContainers`.dump(s)
  if not self.`overhead`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"overhead\":")
    self.`overhead`.dump(s)
  if not self.`dnsPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"dnsPolicy\":")
    self.`dnsPolicy`.dump(s)
  if not self.`readinessGates`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readinessGates\":")
    self.`readinessGates`.dump(s)
  if not self.`hostPID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostPID\":")
    self.`hostPID`.dump(s)
  if not self.`schedulerName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"schedulerName\":")
    self.`schedulerName`.dump(s)
  if not self.`automountServiceAccountToken`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"automountServiceAccountToken\":")
    self.`automountServiceAccountToken`.dump(s)
  if not self.`enableServiceLinks`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"enableServiceLinks\":")
    self.`enableServiceLinks`.dump(s)
  if not self.`securityContext`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"securityContext\":")
    self.`securityContext`.dump(s)
  if not self.`hostIPC`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostIPC\":")
    self.`hostIPC`.dump(s)
  if not self.`hostNetwork`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostNetwork\":")
    self.`hostNetwork`.dump(s)
  if not self.`preemptionPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"preemptionPolicy\":")
    self.`preemptionPolicy`.dump(s)
  if not self.`serviceAccount`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"serviceAccount\":")
    self.`serviceAccount`.dump(s)
  if not self.`topologySpreadConstraints`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"topologySpreadConstraints\":")
    self.`topologySpreadConstraints`.dump(s)
  if not self.`volumes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumes\":")
    self.`volumes`.dump(s)
  if not self.`runtimeClassName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"runtimeClassName\":")
    self.`runtimeClassName`.dump(s)
  s.write("}")

proc isEmpty*(self: PodSpec): bool =
  if not self.`affinity`.isEmpty: return false
  if not self.`ephemeralContainers`.isEmpty: return false
  if not self.`dnsConfig`.isEmpty: return false
  if not self.`subdomain`.isEmpty: return false
  if not self.`hostAliases`.isEmpty: return false
  if not self.`activeDeadlineSeconds`.isEmpty: return false
  if not self.`containers`.isEmpty: return false
  if not self.`priorityClassName`.isEmpty: return false
  if not self.`tolerations`.isEmpty: return false
  if not self.`imagePullSecrets`.isEmpty: return false
  if not self.`nodeSelector`.isEmpty: return false
  if not self.`priority`.isEmpty: return false
  if not self.`nodeName`.isEmpty: return false
  if not self.`serviceAccountName`.isEmpty: return false
  if not self.`terminationGracePeriodSeconds`.isEmpty: return false
  if not self.`shareProcessNamespace`.isEmpty: return false
  if not self.`restartPolicy`.isEmpty: return false
  if not self.`hostname`.isEmpty: return false
  if not self.`initContainers`.isEmpty: return false
  if not self.`overhead`.isEmpty: return false
  if not self.`dnsPolicy`.isEmpty: return false
  if not self.`readinessGates`.isEmpty: return false
  if not self.`hostPID`.isEmpty: return false
  if not self.`schedulerName`.isEmpty: return false
  if not self.`automountServiceAccountToken`.isEmpty: return false
  if not self.`enableServiceLinks`.isEmpty: return false
  if not self.`securityContext`.isEmpty: return false
  if not self.`hostIPC`.isEmpty: return false
  if not self.`hostNetwork`.isEmpty: return false
  if not self.`preemptionPolicy`.isEmpty: return false
  if not self.`serviceAccount`.isEmpty: return false
  if not self.`topologySpreadConstraints`.isEmpty: return false
  if not self.`volumes`.isEmpty: return false
  if not self.`runtimeClassName`.isEmpty: return false
  true

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

proc dump*(self: ContainerStateWaiting, s: Stream) =
  s.write("{")
  var firstIteration = true
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
  s.write("}")

proc isEmpty*(self: ContainerStateWaiting): bool =
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  true

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

proc dump*(self: ContainerStateTerminated, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`signal`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"signal\":")
    self.`signal`.dump(s)
  if not self.`message`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"message\":")
    self.`message`.dump(s)
  if not self.`startedAt`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"startedAt\":")
    self.`startedAt`.dump(s)
  if not self.`containerID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"containerID\":")
    self.`containerID`.dump(s)
  if not self.`exitCode`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"exitCode\":")
    self.`exitCode`.dump(s)
  if not self.`finishedAt`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"finishedAt\":")
    self.`finishedAt`.dump(s)
  if not self.`reason`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"reason\":")
    self.`reason`.dump(s)
  s.write("}")

proc isEmpty*(self: ContainerStateTerminated): bool =
  if not self.`signal`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`startedAt`.isEmpty: return false
  if not self.`containerID`.isEmpty: return false
  if not self.`exitCode`.isEmpty: return false
  if not self.`finishedAt`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  true

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

proc dump*(self: ContainerStateRunning, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`startedAt`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"startedAt\":")
    self.`startedAt`.dump(s)
  s.write("}")

proc isEmpty*(self: ContainerStateRunning): bool =
  if not self.`startedAt`.isEmpty: return false
  true

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

proc dump*(self: ContainerState, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`waiting`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"waiting\":")
    self.`waiting`.dump(s)
  if not self.`terminated`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"terminated\":")
    self.`terminated`.dump(s)
  if not self.`running`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"running\":")
    self.`running`.dump(s)
  s.write("}")

proc isEmpty*(self: ContainerState): bool =
  if not self.`waiting`.isEmpty: return false
  if not self.`terminated`.isEmpty: return false
  if not self.`running`.isEmpty: return false
  true

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

proc dump*(self: ContainerStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`ready`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ready\":")
    self.`ready`.dump(s)
  if not self.`imageID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"imageID\":")
    self.`imageID`.dump(s)
  if not self.`image`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"image\":")
    self.`image`.dump(s)
  if not self.`started`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"started\":")
    self.`started`.dump(s)
  if not self.`containerID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"containerID\":")
    self.`containerID`.dump(s)
  if not self.`lastState`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastState\":")
    self.`lastState`.dump(s)
  if not self.`restartCount`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"restartCount\":")
    self.`restartCount`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`state`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"state\":")
    self.`state`.dump(s)
  s.write("}")

proc isEmpty*(self: ContainerStatus): bool =
  if not self.`ready`.isEmpty: return false
  if not self.`imageID`.isEmpty: return false
  if not self.`image`.isEmpty: return false
  if not self.`started`.isEmpty: return false
  if not self.`containerID`.isEmpty: return false
  if not self.`lastState`.isEmpty: return false
  if not self.`restartCount`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`state`.isEmpty: return false
  true

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

proc dump*(self: PodCondition, s: Stream) =
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
  if not self.`lastProbeTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastProbeTime\":")
    self.`lastProbeTime`.dump(s)
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

proc isEmpty*(self: PodCondition): bool =
  if not self.`lastTransitionTime`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`lastProbeTime`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

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

proc dump*(self: PodIP, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`ip`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ip\":")
    self.`ip`.dump(s)
  s.write("}")

proc isEmpty*(self: PodIP): bool =
  if not self.`ip`.isEmpty: return false
  true

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

proc dump*(self: PodStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`containerStatuses`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"containerStatuses\":")
    self.`containerStatuses`.dump(s)
  if not self.`qosClass`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"qosClass\":")
    self.`qosClass`.dump(s)
  if not self.`phase`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"phase\":")
    self.`phase`.dump(s)
  if not self.`initContainerStatuses`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"initContainerStatuses\":")
    self.`initContainerStatuses`.dump(s)
  if not self.`nominatedNodeName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nominatedNodeName\":")
    self.`nominatedNodeName`.dump(s)
  if not self.`message`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"message\":")
    self.`message`.dump(s)
  if not self.`startTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"startTime\":")
    self.`startTime`.dump(s)
  if not self.`ephemeralContainerStatuses`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ephemeralContainerStatuses\":")
    self.`ephemeralContainerStatuses`.dump(s)
  if not self.`hostIP`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostIP\":")
    self.`hostIP`.dump(s)
  if not self.`conditions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conditions\":")
    self.`conditions`.dump(s)
  if not self.`reason`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"reason\":")
    self.`reason`.dump(s)
  if not self.`podIP`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"podIP\":")
    self.`podIP`.dump(s)
  if not self.`podIPs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"podIPs\":")
    self.`podIPs`.dump(s)
  s.write("}")

proc isEmpty*(self: PodStatus): bool =
  if not self.`containerStatuses`.isEmpty: return false
  if not self.`qosClass`.isEmpty: return false
  if not self.`phase`.isEmpty: return false
  if not self.`initContainerStatuses`.isEmpty: return false
  if not self.`nominatedNodeName`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`startTime`.isEmpty: return false
  if not self.`ephemeralContainerStatuses`.isEmpty: return false
  if not self.`hostIP`.isEmpty: return false
  if not self.`conditions`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`podIP`.isEmpty: return false
  if not self.`podIPs`.isEmpty: return false
  true

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

proc dump*(self: Pod, s: Stream) =
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

proc isEmpty*(self: Pod): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPod(parser: var JsonParser):Pod = 
  var ret: Pod
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Pod], name: string, namespace = "default"): Future[Pod] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadPod)

proc create*(client: Client, t: Pod, namespace = "default"): Future[Pod] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "Pod"
  return await client.get("/api/v1", t, name, namespace, loadPod)

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

proc dump*(self: ObjectReference, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`uid`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"uid\":")
    self.`uid`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`fieldPath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fieldPath\":")
    self.`fieldPath`.dump(s)
  if not self.`resourceVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resourceVersion\":")
    self.`resourceVersion`.dump(s)
  if not self.`namespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespace\":")
    self.`namespace`.dump(s)
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

proc isEmpty*(self: ObjectReference): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`fieldPath`.isEmpty: return false
  if not self.`resourceVersion`.isEmpty: return false
  if not self.`namespace`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

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

proc dump*(self: EndpointAddress, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`nodeName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nodeName\":")
    self.`nodeName`.dump(s)
  if not self.`ip`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ip\":")
    self.`ip`.dump(s)
  if not self.`hostname`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostname\":")
    self.`hostname`.dump(s)
  if not self.`targetRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"targetRef\":")
    self.`targetRef`.dump(s)
  s.write("}")

proc isEmpty*(self: EndpointAddress): bool =
  if not self.`nodeName`.isEmpty: return false
  if not self.`ip`.isEmpty: return false
  if not self.`hostname`.isEmpty: return false
  if not self.`targetRef`.isEmpty: return false
  true

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

proc dump*(self: EndpointPort, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`protocol`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"protocol\":")
    self.`protocol`.dump(s)
  if not self.`port`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"port\":")
    self.`port`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: EndpointPort): bool =
  if not self.`protocol`.isEmpty: return false
  if not self.`port`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: EndpointSubset, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`addresses`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"addresses\":")
    self.`addresses`.dump(s)
  if not self.`ports`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ports\":")
    self.`ports`.dump(s)
  if not self.`notReadyAddresses`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"notReadyAddresses\":")
    self.`notReadyAddresses`.dump(s)
  s.write("}")

proc isEmpty*(self: EndpointSubset): bool =
  if not self.`addresses`.isEmpty: return false
  if not self.`ports`.isEmpty: return false
  if not self.`notReadyAddresses`.isEmpty: return false
  true

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

proc dump*(self: Endpoints, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`subsets`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"subsets\":")
    self.`subsets`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: Endpoints): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`subsets`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadEndpoints(parser: var JsonParser):Endpoints = 
  var ret: Endpoints
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Endpoints], name: string, namespace = "default"): Future[Endpoints] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadEndpoints)

proc create*(client: Client, t: Endpoints, namespace = "default"): Future[Endpoints] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "Endpoints"
  return await client.get("/api/v1", t, name, namespace, loadEndpoints)

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

proc dump*(self: ScopedResourceSelectorRequirement, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`values`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"values\":")
    self.`values`.dump(s)
  if not self.`scopeName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"scopeName\":")
    self.`scopeName`.dump(s)
  if not self.`operator`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"operator\":")
    self.`operator`.dump(s)
  s.write("}")

proc isEmpty*(self: ScopedResourceSelectorRequirement): bool =
  if not self.`values`.isEmpty: return false
  if not self.`scopeName`.isEmpty: return false
  if not self.`operator`.isEmpty: return false
  true

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

proc dump*(self: Taint, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`key`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"key\":")
    self.`key`.dump(s)
  if not self.`effect`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"effect\":")
    self.`effect`.dump(s)
  if not self.`timeAdded`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"timeAdded\":")
    self.`timeAdded`.dump(s)
  if not self.`value`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"value\":")
    self.`value`.dump(s)
  s.write("}")

proc isEmpty*(self: Taint): bool =
  if not self.`key`.isEmpty: return false
  if not self.`effect`.isEmpty: return false
  if not self.`timeAdded`.isEmpty: return false
  if not self.`value`.isEmpty: return false
  true

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

proc dump*(self: NodeSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`podCIDRs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"podCIDRs\":")
    self.`podCIDRs`.dump(s)
  if not self.`externalID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"externalID\":")
    self.`externalID`.dump(s)
  if not self.`taints`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"taints\":")
    self.`taints`.dump(s)
  if not self.`providerID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"providerID\":")
    self.`providerID`.dump(s)
  if not self.`unschedulable`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"unschedulable\":")
    self.`unschedulable`.dump(s)
  if not self.`podCIDR`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"podCIDR\":")
    self.`podCIDR`.dump(s)
  if not self.`configSource`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"configSource\":")
    self.`configSource`.dump(s)
  s.write("}")

proc isEmpty*(self: NodeSpec): bool =
  if not self.`podCIDRs`.isEmpty: return false
  if not self.`externalID`.isEmpty: return false
  if not self.`taints`.isEmpty: return false
  if not self.`providerID`.isEmpty: return false
  if not self.`unschedulable`.isEmpty: return false
  if not self.`podCIDR`.isEmpty: return false
  if not self.`configSource`.isEmpty: return false
  true

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

proc dump*(self: AzureFilePersistentVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`shareName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"shareName\":")
    self.`shareName`.dump(s)
  if not self.`secretName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretName\":")
    self.`secretName`.dump(s)
  if not self.`secretNamespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretNamespace\":")
    self.`secretNamespace`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  s.write("}")

proc isEmpty*(self: AzureFilePersistentVolumeSource): bool =
  if not self.`shareName`.isEmpty: return false
  if not self.`secretName`.isEmpty: return false
  if not self.`secretNamespace`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  true

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

proc dump*(self: EventSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`component`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"component\":")
    self.`component`.dump(s)
  if not self.`host`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"host\":")
    self.`host`.dump(s)
  s.write("}")

proc isEmpty*(self: EventSource): bool =
  if not self.`component`.isEmpty: return false
  if not self.`host`.isEmpty: return false
  true

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

proc dump*(self: PodTemplateSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`spec`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"spec\":")
    self.`spec`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: PodTemplateSpec): bool =
  if not self.`spec`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

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

proc dump*(self: ReplicationControllerSpec, s: Stream) =
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

proc isEmpty*(self: ReplicationControllerSpec): bool =
  if not self.`replicas`.isEmpty: return false
  if not self.`template`.isEmpty: return false
  if not self.`selector`.isEmpty: return false
  if not self.`minReadySeconds`.isEmpty: return false
  true

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

proc dump*(self: ReplicationControllerCondition, s: Stream) =
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

proc isEmpty*(self: ReplicationControllerCondition): bool =
  if not self.`lastTransitionTime`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

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

proc dump*(self: ReplicationControllerStatus, s: Stream) =
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

proc isEmpty*(self: ReplicationControllerStatus): bool =
  if not self.`fullyLabeledReplicas`.isEmpty: return false
  if not self.`replicas`.isEmpty: return false
  if not self.`observedGeneration`.isEmpty: return false
  if not self.`conditions`.isEmpty: return false
  if not self.`readyReplicas`.isEmpty: return false
  if not self.`availableReplicas`.isEmpty: return false
  true

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

proc dump*(self: ReplicationController, s: Stream) =
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

proc isEmpty*(self: ReplicationController): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadReplicationController(parser: var JsonParser):ReplicationController = 
  var ret: ReplicationController
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[ReplicationController], name: string, namespace = "default"): Future[ReplicationController] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadReplicationController)

proc create*(client: Client, t: ReplicationController, namespace = "default"): Future[ReplicationController] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "ReplicationController"
  return await client.get("/api/v1", t, name, namespace, loadReplicationController)

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

proc dump*(self: LimitRangeItem, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`maxLimitRequestRatio`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"maxLimitRequestRatio\":")
    self.`maxLimitRequestRatio`.dump(s)
  if not self.`defaultRequest`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"defaultRequest\":")
    self.`defaultRequest`.dump(s)
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`max`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"max\":")
    self.`max`.dump(s)
  if not self.`default`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"default\":")
    self.`default`.dump(s)
  if not self.`min`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"min\":")
    self.`min`.dump(s)
  s.write("}")

proc isEmpty*(self: LimitRangeItem): bool =
  if not self.`maxLimitRequestRatio`.isEmpty: return false
  if not self.`defaultRequest`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`max`.isEmpty: return false
  if not self.`default`.isEmpty: return false
  if not self.`min`.isEmpty: return false
  true

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

proc dump*(self: LimitRangeSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`limits`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"limits\":")
    self.`limits`.dump(s)
  s.write("}")

proc isEmpty*(self: LimitRangeSpec): bool =
  if not self.`limits`.isEmpty: return false
  true

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

proc dump*(self: LimitRange, s: Stream) =
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

proc isEmpty*(self: LimitRange): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadLimitRange(parser: var JsonParser):LimitRange = 
  var ret: LimitRange
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[LimitRange], name: string, namespace = "default"): Future[LimitRange] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadLimitRange)

proc create*(client: Client, t: LimitRange, namespace = "default"): Future[LimitRange] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "LimitRange"
  return await client.get("/api/v1", t, name, namespace, loadLimitRange)

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

proc dump*(self: LimitRangeList, s: Stream) =
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

proc isEmpty*(self: LimitRangeList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadLimitRangeList(parser: var JsonParser):LimitRangeList = 
  var ret: LimitRangeList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[LimitRange], namespace = "default"): Future[seq[LimitRange]] {.async.}=
  return (await client.list("/api/v1", LimitRangeList, namespace, loadLimitRangeList)).items

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

proc dump*(self: Node, s: Stream) =
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

proc isEmpty*(self: Node): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadNode(parser: var JsonParser):Node = 
  var ret: Node
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Node], name: string, namespace = "default"): Future[Node] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadNode)

proc create*(client: Client, t: Node, namespace = "default"): Future[Node] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "Node"
  return await client.get("/api/v1", t, name, namespace, loadNode)

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

proc dump*(self: NodeList, s: Stream) =
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

proc isEmpty*(self: NodeList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadNodeList(parser: var JsonParser):NodeList = 
  var ret: NodeList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[Node], namespace = "default"): Future[seq[Node]] {.async.}=
  return (await client.list("/api/v1", NodeList, namespace, loadNodeList)).items

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

proc dump*(self: ServicePort, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`nodePort`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nodePort\":")
    self.`nodePort`.dump(s)
  if not self.`targetPort`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"targetPort\":")
    self.`targetPort`.dump(s)
  if not self.`protocol`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"protocol\":")
    self.`protocol`.dump(s)
  if not self.`port`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"port\":")
    self.`port`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: ServicePort): bool =
  if not self.`nodePort`.isEmpty: return false
  if not self.`targetPort`.isEmpty: return false
  if not self.`protocol`.isEmpty: return false
  if not self.`port`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: StorageOSPersistentVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`volumeName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeName\":")
    self.`volumeName`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  if not self.`volumeNamespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeNamespace\":")
    self.`volumeNamespace`.dump(s)
  s.write("}")

proc isEmpty*(self: StorageOSPersistentVolumeSource): bool =
  if not self.`volumeName`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  if not self.`volumeNamespace`.isEmpty: return false
  true

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

proc dump*(self: VolumeNodeAffinity, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`required`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"required\":")
    self.`required`.dump(s)
  s.write("}")

proc isEmpty*(self: VolumeNodeAffinity): bool =
  if not self.`required`.isEmpty: return false
  true

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

proc dump*(self: ConfigMap, s: Stream) =
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
  if not self.`binaryData`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"binaryData\":")
    self.`binaryData`.dump(s)
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

proc isEmpty*(self: ConfigMap): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`data`.isEmpty: return false
  if not self.`binaryData`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadConfigMap(parser: var JsonParser):ConfigMap = 
  var ret: ConfigMap
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[ConfigMap], name: string, namespace = "default"): Future[ConfigMap] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadConfigMap)

proc create*(client: Client, t: ConfigMap, namespace = "default"): Future[ConfigMap] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "ConfigMap"
  return await client.get("/api/v1", t, name, namespace, loadConfigMap)

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

proc dump*(self: ConfigMapList, s: Stream) =
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

proc isEmpty*(self: ConfigMapList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadConfigMapList(parser: var JsonParser):ConfigMapList = 
  var ret: ConfigMapList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[ConfigMap], namespace = "default"): Future[seq[ConfigMap]] {.async.}=
  return (await client.list("/api/v1", ConfigMapList, namespace, loadConfigMapList)).items

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

proc dump*(self: ClientIPConfig, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`timeoutSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"timeoutSeconds\":")
    self.`timeoutSeconds`.dump(s)
  s.write("}")

proc isEmpty*(self: ClientIPConfig): bool =
  if not self.`timeoutSeconds`.isEmpty: return false
  true

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

proc dump*(self: SessionAffinityConfig, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`clientIP`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"clientIP\":")
    self.`clientIP`.dump(s)
  s.write("}")

proc isEmpty*(self: SessionAffinityConfig): bool =
  if not self.`clientIP`.isEmpty: return false
  true

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

proc dump*(self: ServiceSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`publishNotReadyAddresses`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"publishNotReadyAddresses\":")
    self.`publishNotReadyAddresses`.dump(s)
  if not self.`externalName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"externalName\":")
    self.`externalName`.dump(s)
  if not self.`healthCheckNodePort`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"healthCheckNodePort\":")
    self.`healthCheckNodePort`.dump(s)
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`externalTrafficPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"externalTrafficPolicy\":")
    self.`externalTrafficPolicy`.dump(s)
  if not self.`sessionAffinityConfig`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"sessionAffinityConfig\":")
    self.`sessionAffinityConfig`.dump(s)
  if not self.`ports`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ports\":")
    self.`ports`.dump(s)
  if not self.`sessionAffinity`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"sessionAffinity\":")
    self.`sessionAffinity`.dump(s)
  if not self.`selector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selector\":")
    self.`selector`.dump(s)
  if not self.`clusterIP`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"clusterIP\":")
    self.`clusterIP`.dump(s)
  if not self.`loadBalancerIP`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"loadBalancerIP\":")
    self.`loadBalancerIP`.dump(s)
  if not self.`loadBalancerSourceRanges`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"loadBalancerSourceRanges\":")
    self.`loadBalancerSourceRanges`.dump(s)
  if not self.`ipFamily`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ipFamily\":")
    self.`ipFamily`.dump(s)
  if not self.`externalIPs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"externalIPs\":")
    self.`externalIPs`.dump(s)
  s.write("}")

proc isEmpty*(self: ServiceSpec): bool =
  if not self.`publishNotReadyAddresses`.isEmpty: return false
  if not self.`externalName`.isEmpty: return false
  if not self.`healthCheckNodePort`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`externalTrafficPolicy`.isEmpty: return false
  if not self.`sessionAffinityConfig`.isEmpty: return false
  if not self.`ports`.isEmpty: return false
  if not self.`sessionAffinity`.isEmpty: return false
  if not self.`selector`.isEmpty: return false
  if not self.`clusterIP`.isEmpty: return false
  if not self.`loadBalancerIP`.isEmpty: return false
  if not self.`loadBalancerSourceRanges`.isEmpty: return false
  if not self.`ipFamily`.isEmpty: return false
  if not self.`externalIPs`.isEmpty: return false
  true

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

proc dump*(self: LoadBalancerIngress, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`ip`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ip\":")
    self.`ip`.dump(s)
  if not self.`hostname`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostname\":")
    self.`hostname`.dump(s)
  s.write("}")

proc isEmpty*(self: LoadBalancerIngress): bool =
  if not self.`ip`.isEmpty: return false
  if not self.`hostname`.isEmpty: return false
  true

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

proc dump*(self: LoadBalancerStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`ingress`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ingress\":")
    self.`ingress`.dump(s)
  s.write("}")

proc isEmpty*(self: LoadBalancerStatus): bool =
  if not self.`ingress`.isEmpty: return false
  true

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

proc dump*(self: ServiceStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`loadBalancer`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"loadBalancer\":")
    self.`loadBalancer`.dump(s)
  s.write("}")

proc isEmpty*(self: ServiceStatus): bool =
  if not self.`loadBalancer`.isEmpty: return false
  true

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

proc dump*(self: Service, s: Stream) =
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

proc isEmpty*(self: Service): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadService(parser: var JsonParser):Service = 
  var ret: Service
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Service], name: string, namespace = "default"): Future[Service] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadService)

proc create*(client: Client, t: Service, namespace = "default"): Future[Service] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "Service"
  return await client.get("/api/v1", t, name, namespace, loadService)

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

proc dump*(self: ServiceList, s: Stream) =
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

proc isEmpty*(self: ServiceList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadServiceList(parser: var JsonParser):ServiceList = 
  var ret: ServiceList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[Service], namespace = "default"): Future[seq[Service]] {.async.}=
  return (await client.list("/api/v1", ServiceList, namespace, loadServiceList)).items

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

proc dump*(self: NamespaceCondition, s: Stream) =
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

proc isEmpty*(self: NamespaceCondition): bool =
  if not self.`lastTransitionTime`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

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

proc dump*(self: NamespaceStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`phase`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"phase\":")
    self.`phase`.dump(s)
  if not self.`conditions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conditions\":")
    self.`conditions`.dump(s)
  s.write("}")

proc isEmpty*(self: NamespaceStatus): bool =
  if not self.`phase`.isEmpty: return false
  if not self.`conditions`.isEmpty: return false
  true

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

proc dump*(self: SecretReference, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`namespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespace\":")
    self.`namespace`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: SecretReference): bool =
  if not self.`namespace`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: CinderPersistentVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  if not self.`volumeID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeID\":")
    self.`volumeID`.dump(s)
  s.write("}")

proc isEmpty*(self: CinderPersistentVolumeSource): bool =
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  if not self.`volumeID`.isEmpty: return false
  true

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

proc dump*(self: ScopeSelector, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`matchExpressions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"matchExpressions\":")
    self.`matchExpressions`.dump(s)
  s.write("}")

proc isEmpty*(self: ScopeSelector): bool =
  if not self.`matchExpressions`.isEmpty: return false
  true

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

proc dump*(self: ResourceQuotaSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`scopes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"scopes\":")
    self.`scopes`.dump(s)
  if not self.`hard`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hard\":")
    self.`hard`.dump(s)
  if not self.`scopeSelector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"scopeSelector\":")
    self.`scopeSelector`.dump(s)
  s.write("}")

proc isEmpty*(self: ResourceQuotaSpec): bool =
  if not self.`scopes`.isEmpty: return false
  if not self.`hard`.isEmpty: return false
  if not self.`scopeSelector`.isEmpty: return false
  true

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

proc dump*(self: ResourceQuotaStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`hard`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hard\":")
    self.`hard`.dump(s)
  if not self.`used`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"used\":")
    self.`used`.dump(s)
  s.write("}")

proc isEmpty*(self: ResourceQuotaStatus): bool =
  if not self.`hard`.isEmpty: return false
  if not self.`used`.isEmpty: return false
  true

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

proc dump*(self: ResourceQuota, s: Stream) =
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

proc isEmpty*(self: ResourceQuota): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadResourceQuota(parser: var JsonParser):ResourceQuota = 
  var ret: ResourceQuota
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[ResourceQuota], name: string, namespace = "default"): Future[ResourceQuota] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadResourceQuota)

proc create*(client: Client, t: ResourceQuota, namespace = "default"): Future[ResourceQuota] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "ResourceQuota"
  return await client.get("/api/v1", t, name, namespace, loadResourceQuota)

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

proc dump*(self: ISCSIPersistentVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`iqn`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"iqn\":")
    self.`iqn`.dump(s)
  if not self.`iscsiInterface`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"iscsiInterface\":")
    self.`iscsiInterface`.dump(s)
  if not self.`lun`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lun\":")
    self.`lun`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  if not self.`chapAuthDiscovery`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"chapAuthDiscovery\":")
    self.`chapAuthDiscovery`.dump(s)
  if not self.`chapAuthSession`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"chapAuthSession\":")
    self.`chapAuthSession`.dump(s)
  if not self.`initiatorName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"initiatorName\":")
    self.`initiatorName`.dump(s)
  if not self.`portals`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"portals\":")
    self.`portals`.dump(s)
  if not self.`targetPortal`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"targetPortal\":")
    self.`targetPortal`.dump(s)
  s.write("}")

proc isEmpty*(self: ISCSIPersistentVolumeSource): bool =
  if not self.`iqn`.isEmpty: return false
  if not self.`iscsiInterface`.isEmpty: return false
  if not self.`lun`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  if not self.`chapAuthDiscovery`.isEmpty: return false
  if not self.`chapAuthSession`.isEmpty: return false
  if not self.`initiatorName`.isEmpty: return false
  if not self.`portals`.isEmpty: return false
  if not self.`targetPortal`.isEmpty: return false
  true

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

proc dump*(self: RBDPersistentVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`user`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"user\":")
    self.`user`.dump(s)
  if not self.`monitors`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"monitors\":")
    self.`monitors`.dump(s)
  if not self.`image`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"image\":")
    self.`image`.dump(s)
  if not self.`keyring`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"keyring\":")
    self.`keyring`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  if not self.`pool`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"pool\":")
    self.`pool`.dump(s)
  s.write("}")

proc isEmpty*(self: RBDPersistentVolumeSource): bool =
  if not self.`user`.isEmpty: return false
  if not self.`monitors`.isEmpty: return false
  if not self.`image`.isEmpty: return false
  if not self.`keyring`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  if not self.`pool`.isEmpty: return false
  true

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

proc dump*(self: CephFSPersistentVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`user`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"user\":")
    self.`user`.dump(s)
  if not self.`monitors`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"monitors\":")
    self.`monitors`.dump(s)
  if not self.`secretFile`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretFile\":")
    self.`secretFile`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  s.write("}")

proc isEmpty*(self: CephFSPersistentVolumeSource): bool =
  if not self.`path`.isEmpty: return false
  if not self.`user`.isEmpty: return false
  if not self.`monitors`.isEmpty: return false
  if not self.`secretFile`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  true

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

proc dump*(self: GlusterfsPersistentVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`endpointsNamespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"endpointsNamespace\":")
    self.`endpointsNamespace`.dump(s)
  if not self.`endpoints`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"endpoints\":")
    self.`endpoints`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  s.write("}")

proc isEmpty*(self: GlusterfsPersistentVolumeSource): bool =
  if not self.`path`.isEmpty: return false
  if not self.`endpointsNamespace`.isEmpty: return false
  if not self.`endpoints`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  true

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

proc dump*(self: ScaleIOPersistentVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`storageMode`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"storageMode\":")
    self.`storageMode`.dump(s)
  if not self.`volumeName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeName\":")
    self.`volumeName`.dump(s)
  if not self.`storagePool`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"storagePool\":")
    self.`storagePool`.dump(s)
  if not self.`gateway`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"gateway\":")
    self.`gateway`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  if not self.`system`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"system\":")
    self.`system`.dump(s)
  if not self.`sslEnabled`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"sslEnabled\":")
    self.`sslEnabled`.dump(s)
  if not self.`protectionDomain`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"protectionDomain\":")
    self.`protectionDomain`.dump(s)
  s.write("}")

proc isEmpty*(self: ScaleIOPersistentVolumeSource): bool =
  if not self.`storageMode`.isEmpty: return false
  if not self.`volumeName`.isEmpty: return false
  if not self.`storagePool`.isEmpty: return false
  if not self.`gateway`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  if not self.`system`.isEmpty: return false
  if not self.`sslEnabled`.isEmpty: return false
  if not self.`protectionDomain`.isEmpty: return false
  true

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

proc dump*(self: FlexPersistentVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`driver`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"driver\":")
    self.`driver`.dump(s)
  if not self.`options`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"options\":")
    self.`options`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`secretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secretRef\":")
    self.`secretRef`.dump(s)
  s.write("}")

proc isEmpty*(self: FlexPersistentVolumeSource): bool =
  if not self.`driver`.isEmpty: return false
  if not self.`options`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`secretRef`.isEmpty: return false
  true

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

proc dump*(self: LocalVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  s.write("}")

proc isEmpty*(self: LocalVolumeSource): bool =
  if not self.`path`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  true

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

proc dump*(self: CSIPersistentVolumeSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`controllerExpandSecretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"controllerExpandSecretRef\":")
    self.`controllerExpandSecretRef`.dump(s)
  if not self.`volumeAttributes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeAttributes\":")
    self.`volumeAttributes`.dump(s)
  if not self.`driver`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"driver\":")
    self.`driver`.dump(s)
  if not self.`nodeStageSecretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nodeStageSecretRef\":")
    self.`nodeStageSecretRef`.dump(s)
  if not self.`controllerPublishSecretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"controllerPublishSecretRef\":")
    self.`controllerPublishSecretRef`.dump(s)
  if not self.`fsType`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fsType\":")
    self.`fsType`.dump(s)
  if not self.`nodePublishSecretRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nodePublishSecretRef\":")
    self.`nodePublishSecretRef`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  if not self.`volumeHandle`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeHandle\":")
    self.`volumeHandle`.dump(s)
  s.write("}")

proc isEmpty*(self: CSIPersistentVolumeSource): bool =
  if not self.`controllerExpandSecretRef`.isEmpty: return false
  if not self.`volumeAttributes`.isEmpty: return false
  if not self.`driver`.isEmpty: return false
  if not self.`nodeStageSecretRef`.isEmpty: return false
  if not self.`controllerPublishSecretRef`.isEmpty: return false
  if not self.`fsType`.isEmpty: return false
  if not self.`nodePublishSecretRef`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  if not self.`volumeHandle`.isEmpty: return false
  true

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

proc dump*(self: PersistentVolumeSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`vsphereVolume`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"vsphereVolume\":")
    self.`vsphereVolume`.dump(s)
  if not self.`azureFile`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"azureFile\":")
    self.`azureFile`.dump(s)
  if not self.`rbd`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rbd\":")
    self.`rbd`.dump(s)
  if not self.`cephfs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"cephfs\":")
    self.`cephfs`.dump(s)
  if not self.`hostPath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostPath\":")
    self.`hostPath`.dump(s)
  if not self.`nodeAffinity`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nodeAffinity\":")
    self.`nodeAffinity`.dump(s)
  if not self.`glusterfs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"glusterfs\":")
    self.`glusterfs`.dump(s)
  if not self.`gcePersistentDisk`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"gcePersistentDisk\":")
    self.`gcePersistentDisk`.dump(s)
  if not self.`quobyte`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"quobyte\":")
    self.`quobyte`.dump(s)
  if not self.`volumeMode`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeMode\":")
    self.`volumeMode`.dump(s)
  if not self.`nfs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nfs\":")
    self.`nfs`.dump(s)
  if not self.`flocker`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"flocker\":")
    self.`flocker`.dump(s)
  if not self.`storageClassName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"storageClassName\":")
    self.`storageClassName`.dump(s)
  if not self.`scaleIO`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"scaleIO\":")
    self.`scaleIO`.dump(s)
  if not self.`flexVolume`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"flexVolume\":")
    self.`flexVolume`.dump(s)
  if not self.`local`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"local\":")
    self.`local`.dump(s)
  if not self.`portworxVolume`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"portworxVolume\":")
    self.`portworxVolume`.dump(s)
  if not self.`azureDisk`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"azureDisk\":")
    self.`azureDisk`.dump(s)
  if not self.`capacity`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"capacity\":")
    self.`capacity`.dump(s)
  if not self.`claimRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"claimRef\":")
    self.`claimRef`.dump(s)
  if not self.`mountOptions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"mountOptions\":")
    self.`mountOptions`.dump(s)
  if not self.`cinder`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"cinder\":")
    self.`cinder`.dump(s)
  if not self.`fc`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"fc\":")
    self.`fc`.dump(s)
  if not self.`csi`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"csi\":")
    self.`csi`.dump(s)
  if not self.`storageos`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"storageos\":")
    self.`storageos`.dump(s)
  if not self.`persistentVolumeReclaimPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"persistentVolumeReclaimPolicy\":")
    self.`persistentVolumeReclaimPolicy`.dump(s)
  if not self.`accessModes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"accessModes\":")
    self.`accessModes`.dump(s)
  if not self.`awsElasticBlockStore`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"awsElasticBlockStore\":")
    self.`awsElasticBlockStore`.dump(s)
  if not self.`iscsi`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"iscsi\":")
    self.`iscsi`.dump(s)
  if not self.`photonPersistentDisk`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"photonPersistentDisk\":")
    self.`photonPersistentDisk`.dump(s)
  s.write("}")

proc isEmpty*(self: PersistentVolumeSpec): bool =
  if not self.`vsphereVolume`.isEmpty: return false
  if not self.`azureFile`.isEmpty: return false
  if not self.`rbd`.isEmpty: return false
  if not self.`cephfs`.isEmpty: return false
  if not self.`hostPath`.isEmpty: return false
  if not self.`nodeAffinity`.isEmpty: return false
  if not self.`glusterfs`.isEmpty: return false
  if not self.`gcePersistentDisk`.isEmpty: return false
  if not self.`quobyte`.isEmpty: return false
  if not self.`volumeMode`.isEmpty: return false
  if not self.`nfs`.isEmpty: return false
  if not self.`flocker`.isEmpty: return false
  if not self.`storageClassName`.isEmpty: return false
  if not self.`scaleIO`.isEmpty: return false
  if not self.`flexVolume`.isEmpty: return false
  if not self.`local`.isEmpty: return false
  if not self.`portworxVolume`.isEmpty: return false
  if not self.`azureDisk`.isEmpty: return false
  if not self.`capacity`.isEmpty: return false
  if not self.`claimRef`.isEmpty: return false
  if not self.`mountOptions`.isEmpty: return false
  if not self.`cinder`.isEmpty: return false
  if not self.`fc`.isEmpty: return false
  if not self.`csi`.isEmpty: return false
  if not self.`storageos`.isEmpty: return false
  if not self.`persistentVolumeReclaimPolicy`.isEmpty: return false
  if not self.`accessModes`.isEmpty: return false
  if not self.`awsElasticBlockStore`.isEmpty: return false
  if not self.`iscsi`.isEmpty: return false
  if not self.`photonPersistentDisk`.isEmpty: return false
  true

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

proc dump*(self: PersistentVolumeStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`phase`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"phase\":")
    self.`phase`.dump(s)
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
  s.write("}")

proc isEmpty*(self: PersistentVolumeStatus): bool =
  if not self.`phase`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  true

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

proc dump*(self: PersistentVolumeClaimStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`phase`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"phase\":")
    self.`phase`.dump(s)
  if not self.`capacity`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"capacity\":")
    self.`capacity`.dump(s)
  if not self.`conditions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conditions\":")
    self.`conditions`.dump(s)
  if not self.`accessModes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"accessModes\":")
    self.`accessModes`.dump(s)
  s.write("}")

proc isEmpty*(self: PersistentVolumeClaimStatus): bool =
  if not self.`phase`.isEmpty: return false
  if not self.`capacity`.isEmpty: return false
  if not self.`conditions`.isEmpty: return false
  if not self.`accessModes`.isEmpty: return false
  true

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

proc dump*(self: EventSeries, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`count`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"count\":")
    self.`count`.dump(s)
  if not self.`lastObservedTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastObservedTime\":")
    self.`lastObservedTime`.dump(s)
  if not self.`state`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"state\":")
    self.`state`.dump(s)
  s.write("}")

proc isEmpty*(self: EventSeries): bool =
  if not self.`count`.isEmpty: return false
  if not self.`lastObservedTime`.isEmpty: return false
  if not self.`state`.isEmpty: return false
  true

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

proc dump*(self: Event, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`involvedObject`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"involvedObject\":")
    self.`involvedObject`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`reportingInstance`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"reportingInstance\":")
    self.`reportingInstance`.dump(s)
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
  if not self.`lastTimestamp`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastTimestamp\":")
    self.`lastTimestamp`.dump(s)
  if not self.`eventTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"eventTime\":")
    self.`eventTime`.dump(s)
  if not self.`series`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"series\":")
    self.`series`.dump(s)
  if not self.`count`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"count\":")
    self.`count`.dump(s)
  if not self.`action`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"action\":")
    self.`action`.dump(s)
  if not self.`firstTimestamp`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"firstTimestamp\":")
    self.`firstTimestamp`.dump(s)
  if not self.`source`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"source\":")
    self.`source`.dump(s)
  if not self.`reason`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"reason\":")
    self.`reason`.dump(s)
  if not self.`reportingComponent`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"reportingComponent\":")
    self.`reportingComponent`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`related`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"related\":")
    self.`related`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: Event): bool =
  if not self.`involvedObject`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`reportingInstance`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`lastTimestamp`.isEmpty: return false
  if not self.`eventTime`.isEmpty: return false
  if not self.`series`.isEmpty: return false
  if not self.`count`.isEmpty: return false
  if not self.`action`.isEmpty: return false
  if not self.`firstTimestamp`.isEmpty: return false
  if not self.`source`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`reportingComponent`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`related`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadEvent(parser: var JsonParser):Event = 
  var ret: Event
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Event], name: string, namespace = "default"): Future[Event] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadEvent)

proc create*(client: Client, t: Event, namespace = "default"): Future[Event] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "Event"
  return await client.get("/api/v1", t, name, namespace, loadEvent)

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

proc dump*(self: EventList, s: Stream) =
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

proc isEmpty*(self: EventList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadEventList(parser: var JsonParser):EventList = 
  var ret: EventList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[Event], namespace = "default"): Future[seq[Event]] {.async.}=
  return (await client.list("/api/v1", EventList, namespace, loadEventList)).items

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

proc dump*(self: PersistentVolume, s: Stream) =
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

proc isEmpty*(self: PersistentVolume): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPersistentVolume(parser: var JsonParser):PersistentVolume = 
  var ret: PersistentVolume
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[PersistentVolume], name: string, namespace = "default"): Future[PersistentVolume] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadPersistentVolume)

proc create*(client: Client, t: PersistentVolume, namespace = "default"): Future[PersistentVolume] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "PersistentVolume"
  return await client.get("/api/v1", t, name, namespace, loadPersistentVolume)

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

proc dump*(self: TypedLocalObjectReference, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiGroup`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiGroup\":")
    self.`apiGroup`.dump(s)
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

proc isEmpty*(self: TypedLocalObjectReference): bool =
  if not self.`apiGroup`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

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

proc dump*(self: PodTemplate, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`template`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"template\":")
    self.`template`.dump(s)
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

proc isEmpty*(self: PodTemplate): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`template`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPodTemplate(parser: var JsonParser):PodTemplate = 
  var ret: PodTemplate
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[PodTemplate], name: string, namespace = "default"): Future[PodTemplate] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadPodTemplate)

proc create*(client: Client, t: PodTemplate, namespace = "default"): Future[PodTemplate] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "PodTemplate"
  return await client.get("/api/v1", t, name, namespace, loadPodTemplate)

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

proc dump*(self: PodTemplateList, s: Stream) =
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

proc isEmpty*(self: PodTemplateList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPodTemplateList(parser: var JsonParser):PodTemplateList = 
  var ret: PodTemplateList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[PodTemplate], namespace = "default"): Future[seq[PodTemplate]] {.async.}=
  return (await client.list("/api/v1", PodTemplateList, namespace, loadPodTemplateList)).items

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

proc dump*(self: ComponentCondition, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`error`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"error\":")
    self.`error`.dump(s)
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
  if not self.`status`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"status\":")
    self.`status`.dump(s)
  s.write("}")

proc isEmpty*(self: ComponentCondition): bool =
  if not self.`error`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

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

proc dump*(self: ComponentStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`conditions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conditions\":")
    self.`conditions`.dump(s)
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

proc isEmpty*(self: ComponentStatus): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`conditions`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadComponentStatus(parser: var JsonParser):ComponentStatus = 
  var ret: ComponentStatus
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[ComponentStatus], name: string, namespace = "default"): Future[ComponentStatus] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadComponentStatus)

proc create*(client: Client, t: ComponentStatus, namespace = "default"): Future[ComponentStatus] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "ComponentStatus"
  return await client.get("/api/v1", t, name, namespace, loadComponentStatus)

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

proc dump*(self: ComponentStatusList, s: Stream) =
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

proc isEmpty*(self: ComponentStatusList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadComponentStatusList(parser: var JsonParser):ComponentStatusList = 
  var ret: ComponentStatusList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[ComponentStatus], namespace = "default"): Future[seq[ComponentStatus]] {.async.}=
  return (await client.list("/api/v1", ComponentStatusList, namespace, loadComponentStatusList)).items

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

proc dump*(self: PersistentVolumeClaimSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`volumeMode`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeMode\":")
    self.`volumeMode`.dump(s)
  if not self.`volumeName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeName\":")
    self.`volumeName`.dump(s)
  if not self.`storageClassName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"storageClassName\":")
    self.`storageClassName`.dump(s)
  if not self.`dataSource`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"dataSource\":")
    self.`dataSource`.dump(s)
  if not self.`resources`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resources\":")
    self.`resources`.dump(s)
  if not self.`selector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selector\":")
    self.`selector`.dump(s)
  if not self.`accessModes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"accessModes\":")
    self.`accessModes`.dump(s)
  s.write("}")

proc isEmpty*(self: PersistentVolumeClaimSpec): bool =
  if not self.`volumeMode`.isEmpty: return false
  if not self.`volumeName`.isEmpty: return false
  if not self.`storageClassName`.isEmpty: return false
  if not self.`dataSource`.isEmpty: return false
  if not self.`resources`.isEmpty: return false
  if not self.`selector`.isEmpty: return false
  if not self.`accessModes`.isEmpty: return false
  true

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

proc dump*(self: PersistentVolumeClaim, s: Stream) =
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

proc isEmpty*(self: PersistentVolumeClaim): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPersistentVolumeClaim(parser: var JsonParser):PersistentVolumeClaim = 
  var ret: PersistentVolumeClaim
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[PersistentVolumeClaim], name: string, namespace = "default"): Future[PersistentVolumeClaim] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadPersistentVolumeClaim)

proc create*(client: Client, t: PersistentVolumeClaim, namespace = "default"): Future[PersistentVolumeClaim] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "PersistentVolumeClaim"
  return await client.get("/api/v1", t, name, namespace, loadPersistentVolumeClaim)

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

proc dump*(self: PersistentVolumeList, s: Stream) =
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

proc isEmpty*(self: PersistentVolumeList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPersistentVolumeList(parser: var JsonParser):PersistentVolumeList = 
  var ret: PersistentVolumeList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[PersistentVolume], namespace = "default"): Future[seq[PersistentVolume]] {.async.}=
  return (await client.list("/api/v1", PersistentVolumeList, namespace, loadPersistentVolumeList)).items

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

proc dump*(self: Binding, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`target`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"target\":")
    self.`target`.dump(s)
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

proc isEmpty*(self: Binding): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`target`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadBinding(parser: var JsonParser):Binding = 
  var ret: Binding
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Binding], name: string, namespace = "default"): Future[Binding] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadBinding)

proc create*(client: Client, t: Binding, namespace = "default"): Future[Binding] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "Binding"
  return await client.get("/api/v1", t, name, namespace, loadBinding)

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

proc dump*(self: NamespaceSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`finalizers`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"finalizers\":")
    self.`finalizers`.dump(s)
  s.write("}")

proc isEmpty*(self: NamespaceSpec): bool =
  if not self.`finalizers`.isEmpty: return false
  true

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

proc dump*(self: Namespace, s: Stream) =
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

proc isEmpty*(self: Namespace): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadNamespace(parser: var JsonParser):Namespace = 
  var ret: Namespace
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Namespace], name: string, namespace = "default"): Future[Namespace] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadNamespace)

proc create*(client: Client, t: Namespace, namespace = "default"): Future[Namespace] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "Namespace"
  return await client.get("/api/v1", t, name, namespace, loadNamespace)

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

proc dump*(self: ResourceQuotaList, s: Stream) =
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

proc isEmpty*(self: ResourceQuotaList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadResourceQuotaList(parser: var JsonParser):ResourceQuotaList = 
  var ret: ResourceQuotaList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[ResourceQuota], namespace = "default"): Future[seq[ResourceQuota]] {.async.}=
  return (await client.list("/api/v1", ResourceQuotaList, namespace, loadResourceQuotaList)).items

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

proc dump*(self: PersistentVolumeClaimList, s: Stream) =
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

proc isEmpty*(self: PersistentVolumeClaimList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPersistentVolumeClaimList(parser: var JsonParser):PersistentVolumeClaimList = 
  var ret: PersistentVolumeClaimList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[PersistentVolumeClaim], namespace = "default"): Future[seq[PersistentVolumeClaim]] {.async.}=
  return (await client.list("/api/v1", PersistentVolumeClaimList, namespace, loadPersistentVolumeClaimList)).items

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

proc dump*(self: PodList, s: Stream) =
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

proc isEmpty*(self: PodList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPodList(parser: var JsonParser):PodList = 
  var ret: PodList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[Pod], namespace = "default"): Future[seq[Pod]] {.async.}=
  return (await client.list("/api/v1", PodList, namespace, loadPodList)).items

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

proc dump*(self: ServiceAccount, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`secrets`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"secrets\":")
    self.`secrets`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`imagePullSecrets`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"imagePullSecrets\":")
    self.`imagePullSecrets`.dump(s)
  if not self.`automountServiceAccountToken`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"automountServiceAccountToken\":")
    self.`automountServiceAccountToken`.dump(s)
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

proc isEmpty*(self: ServiceAccount): bool =
  if not self.`secrets`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`imagePullSecrets`.isEmpty: return false
  if not self.`automountServiceAccountToken`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadServiceAccount(parser: var JsonParser):ServiceAccount = 
  var ret: ServiceAccount
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[ServiceAccount], name: string, namespace = "default"): Future[ServiceAccount] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadServiceAccount)

proc create*(client: Client, t: ServiceAccount, namespace = "default"): Future[ServiceAccount] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "ServiceAccount"
  return await client.get("/api/v1", t, name, namespace, loadServiceAccount)

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

proc dump*(self: ServiceAccountList, s: Stream) =
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

proc isEmpty*(self: ServiceAccountList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadServiceAccountList(parser: var JsonParser):ServiceAccountList = 
  var ret: ServiceAccountList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[ServiceAccount], namespace = "default"): Future[seq[ServiceAccount]] {.async.}=
  return (await client.list("/api/v1", ServiceAccountList, namespace, loadServiceAccountList)).items

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

proc dump*(self: ReplicationControllerList, s: Stream) =
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

proc isEmpty*(self: ReplicationControllerList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadReplicationControllerList(parser: var JsonParser):ReplicationControllerList = 
  var ret: ReplicationControllerList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[ReplicationController], namespace = "default"): Future[seq[ReplicationController]] {.async.}=
  return (await client.list("/api/v1", ReplicationControllerList, namespace, loadReplicationControllerList)).items

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

proc dump*(self: EndpointsList, s: Stream) =
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

proc isEmpty*(self: EndpointsList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadEndpointsList(parser: var JsonParser):EndpointsList = 
  var ret: EndpointsList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[Endpoints], namespace = "default"): Future[seq[Endpoints]] {.async.}=
  return (await client.list("/api/v1", EndpointsList, namespace, loadEndpointsList)).items

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

proc dump*(self: NamespaceList, s: Stream) =
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

proc isEmpty*(self: NamespaceList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadNamespaceList(parser: var JsonParser):NamespaceList = 
  var ret: NamespaceList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[Namespace], namespace = "default"): Future[seq[Namespace]] {.async.}=
  return (await client.list("/api/v1", NamespaceList, namespace, loadNamespaceList)).items

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

proc dump*(self: Secret, s: Stream) =
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
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`stringData`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"stringData\":")
    self.`stringData`.dump(s)
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

proc isEmpty*(self: Secret): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`data`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`stringData`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadSecret(parser: var JsonParser):Secret = 
  var ret: Secret
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Secret], name: string, namespace = "default"): Future[Secret] {.async.}=
  return await client.get("/api/v1", t, name, namespace, loadSecret)

proc create*(client: Client, t: Secret, namespace = "default"): Future[Secret] {.async.}=
  t.apiVersion = "/api/v1"
  t.kind = "Secret"
  return await client.get("/api/v1", t, name, namespace, loadSecret)

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

proc dump*(self: SecretList, s: Stream) =
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

proc isEmpty*(self: SecretList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadSecretList(parser: var JsonParser):SecretList = 
  var ret: SecretList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[Secret], namespace = "default"): Future[seq[Secret]] {.async.}=
  return (await client.list("/api/v1", SecretList, namespace, loadSecretList)).items
