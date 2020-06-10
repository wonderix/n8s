import ../client
import ../base_types
import parsejson
import streams
import io_k8s_apimachinery_pkg_util_intstr
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch
import io_k8s_api_core_v1
import tables

type
  HostPortRange* = object
    `max`*: int
    `min`*: int

proc load*(self: var HostPortRange, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "max":
            load(self.`max`,parser)
          of "min":
            load(self.`min`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: HostPortRange, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`max`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"max\":")
    self.`max`.dump(s)
  if not self.`min`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"min\":")
    self.`min`.dump(s)
  s.write("}")

proc isEmpty*(self: HostPortRange): bool =
  if not self.`max`.isEmpty: return false
  if not self.`min`.isEmpty: return false
  true

type
  PodDisruptionBudgetSpec* = object
    `maxUnavailable`*: io_k8s_apimachinery_pkg_util_intstr.IntOrString
    `selector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `minAvailable`*: io_k8s_apimachinery_pkg_util_intstr.IntOrString

proc load*(self: var PodDisruptionBudgetSpec, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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
          of "selector":
            load(self.`selector`,parser)
          of "minAvailable":
            load(self.`minAvailable`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: PodDisruptionBudgetSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`maxUnavailable`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"maxUnavailable\":")
    self.`maxUnavailable`.dump(s)
  if not self.`selector`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"selector\":")
    self.`selector`.dump(s)
  if not self.`minAvailable`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"minAvailable\":")
    self.`minAvailable`.dump(s)
  s.write("}")

proc isEmpty*(self: PodDisruptionBudgetSpec): bool =
  if not self.`maxUnavailable`.isEmpty: return false
  if not self.`selector`.isEmpty: return false
  if not self.`minAvailable`.isEmpty: return false
  true

type
  AllowedFlexVolume* = object
    `driver`*: string

proc load*(self: var AllowedFlexVolume, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: AllowedFlexVolume, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`driver`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"driver\":")
    self.`driver`.dump(s)
  s.write("}")

proc isEmpty*(self: AllowedFlexVolume): bool =
  if not self.`driver`.isEmpty: return false
  true

type
  RuntimeClassStrategyOptions* = object
    `allowedRuntimeClassNames`*: seq[string]
    `defaultRuntimeClassName`*: string

proc load*(self: var RuntimeClassStrategyOptions, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "allowedRuntimeClassNames":
            load(self.`allowedRuntimeClassNames`,parser)
          of "defaultRuntimeClassName":
            load(self.`defaultRuntimeClassName`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: RuntimeClassStrategyOptions, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`allowedRuntimeClassNames`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allowedRuntimeClassNames\":")
    self.`allowedRuntimeClassNames`.dump(s)
  if not self.`defaultRuntimeClassName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"defaultRuntimeClassName\":")
    self.`defaultRuntimeClassName`.dump(s)
  s.write("}")

proc isEmpty*(self: RuntimeClassStrategyOptions): bool =
  if not self.`allowedRuntimeClassNames`.isEmpty: return false
  if not self.`defaultRuntimeClassName`.isEmpty: return false
  true

type
  IDRange* = object
    `max`*: int
    `min`*: int

proc load*(self: var IDRange, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "max":
            load(self.`max`,parser)
          of "min":
            load(self.`min`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: IDRange, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`max`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"max\":")
    self.`max`.dump(s)
  if not self.`min`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"min\":")
    self.`min`.dump(s)
  s.write("}")

proc isEmpty*(self: IDRange): bool =
  if not self.`max`.isEmpty: return false
  if not self.`min`.isEmpty: return false
  true

type
  FSGroupStrategyOptions* = object
    `rule`*: string
    `ranges`*: seq[IDRange]

proc load*(self: var FSGroupStrategyOptions, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "rule":
            load(self.`rule`,parser)
          of "ranges":
            load(self.`ranges`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: FSGroupStrategyOptions, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`rule`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rule\":")
    self.`rule`.dump(s)
  if not self.`ranges`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ranges\":")
    self.`ranges`.dump(s)
  s.write("}")

proc isEmpty*(self: FSGroupStrategyOptions): bool =
  if not self.`rule`.isEmpty: return false
  if not self.`ranges`.isEmpty: return false
  true

type
  SupplementalGroupsStrategyOptions* = object
    `rule`*: string
    `ranges`*: seq[IDRange]

proc load*(self: var SupplementalGroupsStrategyOptions, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "rule":
            load(self.`rule`,parser)
          of "ranges":
            load(self.`ranges`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: SupplementalGroupsStrategyOptions, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`rule`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rule\":")
    self.`rule`.dump(s)
  if not self.`ranges`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ranges\":")
    self.`ranges`.dump(s)
  s.write("}")

proc isEmpty*(self: SupplementalGroupsStrategyOptions): bool =
  if not self.`rule`.isEmpty: return false
  if not self.`ranges`.isEmpty: return false
  true

type
  SELinuxStrategyOptions* = object
    `rule`*: string
    `seLinuxOptions`*: io_k8s_api_core_v1.SELinuxOptions

proc load*(self: var SELinuxStrategyOptions, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "rule":
            load(self.`rule`,parser)
          of "seLinuxOptions":
            load(self.`seLinuxOptions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: SELinuxStrategyOptions, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`rule`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rule\":")
    self.`rule`.dump(s)
  if not self.`seLinuxOptions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"seLinuxOptions\":")
    self.`seLinuxOptions`.dump(s)
  s.write("}")

proc isEmpty*(self: SELinuxStrategyOptions): bool =
  if not self.`rule`.isEmpty: return false
  if not self.`seLinuxOptions`.isEmpty: return false
  true

type
  AllowedHostPath* = object
    `pathPrefix`*: string
    `readOnly`*: bool

proc load*(self: var AllowedHostPath, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "pathPrefix":
            load(self.`pathPrefix`,parser)
          of "readOnly":
            load(self.`readOnly`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: AllowedHostPath, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`pathPrefix`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"pathPrefix\":")
    self.`pathPrefix`.dump(s)
  if not self.`readOnly`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnly\":")
    self.`readOnly`.dump(s)
  s.write("}")

proc isEmpty*(self: AllowedHostPath): bool =
  if not self.`pathPrefix`.isEmpty: return false
  if not self.`readOnly`.isEmpty: return false
  true

type
  AllowedCSIDriver* = object
    `name`*: string

proc load*(self: var AllowedCSIDriver, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc dump*(self: AllowedCSIDriver, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: AllowedCSIDriver): bool =
  if not self.`name`.isEmpty: return false
  true

type
  RunAsGroupStrategyOptions* = object
    `rule`*: string
    `ranges`*: seq[IDRange]

proc load*(self: var RunAsGroupStrategyOptions, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "rule":
            load(self.`rule`,parser)
          of "ranges":
            load(self.`ranges`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: RunAsGroupStrategyOptions, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`rule`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rule\":")
    self.`rule`.dump(s)
  if not self.`ranges`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ranges\":")
    self.`ranges`.dump(s)
  s.write("}")

proc isEmpty*(self: RunAsGroupStrategyOptions): bool =
  if not self.`rule`.isEmpty: return false
  if not self.`ranges`.isEmpty: return false
  true

type
  RunAsUserStrategyOptions* = object
    `rule`*: string
    `ranges`*: seq[IDRange]

proc load*(self: var RunAsUserStrategyOptions, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "rule":
            load(self.`rule`,parser)
          of "ranges":
            load(self.`ranges`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: RunAsUserStrategyOptions, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`rule`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rule\":")
    self.`rule`.dump(s)
  if not self.`ranges`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"ranges\":")
    self.`ranges`.dump(s)
  s.write("}")

proc isEmpty*(self: RunAsUserStrategyOptions): bool =
  if not self.`rule`.isEmpty: return false
  if not self.`ranges`.isEmpty: return false
  true

type
  PodSecurityPolicySpec* = object
    `allowedProcMountTypes`*: seq[string]
    `allowedCapabilities`*: seq[string]
    `runtimeClass`*: RuntimeClassStrategyOptions
    `readOnlyRootFilesystem`*: bool
    `fsGroup`*: FSGroupStrategyOptions
    `supplementalGroups`*: SupplementalGroupsStrategyOptions
    `seLinux`*: SELinuxStrategyOptions
    `defaultAddCapabilities`*: seq[string]
    `allowedHostPaths`*: seq[AllowedHostPath]
    `defaultAllowPrivilegeEscalation`*: bool
    `allowPrivilegeEscalation`*: bool
    `allowedUnsafeSysctls`*: seq[string]
    `allowedCSIDrivers`*: seq[AllowedCSIDriver]
    `hostPID`*: bool
    `hostPorts`*: seq[HostPortRange]
    `runAsGroup`*: RunAsGroupStrategyOptions
    `hostIPC`*: bool
    `hostNetwork`*: bool
    `requiredDropCapabilities`*: seq[string]
    `volumes`*: seq[string]
    `allowedFlexVolumes`*: seq[AllowedFlexVolume]
    `privileged`*: bool
    `forbiddenSysctls`*: seq[string]
    `runAsUser`*: RunAsUserStrategyOptions

proc load*(self: var PodSecurityPolicySpec, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "allowedProcMountTypes":
            load(self.`allowedProcMountTypes`,parser)
          of "allowedCapabilities":
            load(self.`allowedCapabilities`,parser)
          of "runtimeClass":
            load(self.`runtimeClass`,parser)
          of "readOnlyRootFilesystem":
            load(self.`readOnlyRootFilesystem`,parser)
          of "fsGroup":
            load(self.`fsGroup`,parser)
          of "supplementalGroups":
            load(self.`supplementalGroups`,parser)
          of "seLinux":
            load(self.`seLinux`,parser)
          of "defaultAddCapabilities":
            load(self.`defaultAddCapabilities`,parser)
          of "allowedHostPaths":
            load(self.`allowedHostPaths`,parser)
          of "defaultAllowPrivilegeEscalation":
            load(self.`defaultAllowPrivilegeEscalation`,parser)
          of "allowPrivilegeEscalation":
            load(self.`allowPrivilegeEscalation`,parser)
          of "allowedUnsafeSysctls":
            load(self.`allowedUnsafeSysctls`,parser)
          of "allowedCSIDrivers":
            load(self.`allowedCSIDrivers`,parser)
          of "hostPID":
            load(self.`hostPID`,parser)
          of "hostPorts":
            load(self.`hostPorts`,parser)
          of "runAsGroup":
            load(self.`runAsGroup`,parser)
          of "hostIPC":
            load(self.`hostIPC`,parser)
          of "hostNetwork":
            load(self.`hostNetwork`,parser)
          of "requiredDropCapabilities":
            load(self.`requiredDropCapabilities`,parser)
          of "volumes":
            load(self.`volumes`,parser)
          of "allowedFlexVolumes":
            load(self.`allowedFlexVolumes`,parser)
          of "privileged":
            load(self.`privileged`,parser)
          of "forbiddenSysctls":
            load(self.`forbiddenSysctls`,parser)
          of "runAsUser":
            load(self.`runAsUser`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: PodSecurityPolicySpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`allowedProcMountTypes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allowedProcMountTypes\":")
    self.`allowedProcMountTypes`.dump(s)
  if not self.`allowedCapabilities`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allowedCapabilities\":")
    self.`allowedCapabilities`.dump(s)
  if not self.`runtimeClass`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"runtimeClass\":")
    self.`runtimeClass`.dump(s)
  if not self.`readOnlyRootFilesystem`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"readOnlyRootFilesystem\":")
    self.`readOnlyRootFilesystem`.dump(s)
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
  if not self.`seLinux`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"seLinux\":")
    self.`seLinux`.dump(s)
  if not self.`defaultAddCapabilities`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"defaultAddCapabilities\":")
    self.`defaultAddCapabilities`.dump(s)
  if not self.`allowedHostPaths`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allowedHostPaths\":")
    self.`allowedHostPaths`.dump(s)
  if not self.`defaultAllowPrivilegeEscalation`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"defaultAllowPrivilegeEscalation\":")
    self.`defaultAllowPrivilegeEscalation`.dump(s)
  if not self.`allowPrivilegeEscalation`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allowPrivilegeEscalation\":")
    self.`allowPrivilegeEscalation`.dump(s)
  if not self.`allowedUnsafeSysctls`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allowedUnsafeSysctls\":")
    self.`allowedUnsafeSysctls`.dump(s)
  if not self.`allowedCSIDrivers`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allowedCSIDrivers\":")
    self.`allowedCSIDrivers`.dump(s)
  if not self.`hostPID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostPID\":")
    self.`hostPID`.dump(s)
  if not self.`hostPorts`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"hostPorts\":")
    self.`hostPorts`.dump(s)
  if not self.`runAsGroup`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"runAsGroup\":")
    self.`runAsGroup`.dump(s)
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
  if not self.`requiredDropCapabilities`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"requiredDropCapabilities\":")
    self.`requiredDropCapabilities`.dump(s)
  if not self.`volumes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumes\":")
    self.`volumes`.dump(s)
  if not self.`allowedFlexVolumes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allowedFlexVolumes\":")
    self.`allowedFlexVolumes`.dump(s)
  if not self.`privileged`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"privileged\":")
    self.`privileged`.dump(s)
  if not self.`forbiddenSysctls`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"forbiddenSysctls\":")
    self.`forbiddenSysctls`.dump(s)
  if not self.`runAsUser`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"runAsUser\":")
    self.`runAsUser`.dump(s)
  s.write("}")

proc isEmpty*(self: PodSecurityPolicySpec): bool =
  if not self.`allowedProcMountTypes`.isEmpty: return false
  if not self.`allowedCapabilities`.isEmpty: return false
  if not self.`runtimeClass`.isEmpty: return false
  if not self.`readOnlyRootFilesystem`.isEmpty: return false
  if not self.`fsGroup`.isEmpty: return false
  if not self.`supplementalGroups`.isEmpty: return false
  if not self.`seLinux`.isEmpty: return false
  if not self.`defaultAddCapabilities`.isEmpty: return false
  if not self.`allowedHostPaths`.isEmpty: return false
  if not self.`defaultAllowPrivilegeEscalation`.isEmpty: return false
  if not self.`allowPrivilegeEscalation`.isEmpty: return false
  if not self.`allowedUnsafeSysctls`.isEmpty: return false
  if not self.`allowedCSIDrivers`.isEmpty: return false
  if not self.`hostPID`.isEmpty: return false
  if not self.`hostPorts`.isEmpty: return false
  if not self.`runAsGroup`.isEmpty: return false
  if not self.`hostIPC`.isEmpty: return false
  if not self.`hostNetwork`.isEmpty: return false
  if not self.`requiredDropCapabilities`.isEmpty: return false
  if not self.`volumes`.isEmpty: return false
  if not self.`allowedFlexVolumes`.isEmpty: return false
  if not self.`privileged`.isEmpty: return false
  if not self.`forbiddenSysctls`.isEmpty: return false
  if not self.`runAsUser`.isEmpty: return false
  true

type
  PodSecurityPolicy* = object
    `apiVersion`*: string
    `spec`*: PodSecurityPolicySpec
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var PodSecurityPolicy, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc dump*(self: PodSecurityPolicy, s: Stream) =
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

proc isEmpty*(self: PodSecurityPolicy): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPodSecurityPolicy(parser: var JsonParser):PodSecurityPolicy = 
  var ret: PodSecurityPolicy
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[PodSecurityPolicy], name: string, namespace = "default"): Future[PodSecurityPolicy] {.async.}=
  return await client.get("/apis/policy/v1beta1", t, name, namespace, loadPodSecurityPolicy)

proc create*(client: Client, t: PodSecurityPolicy, namespace = "default"): Future[PodSecurityPolicy] {.async.}=
  t.apiVersion = "/apis/policy/v1beta1"
  t.kind = "PodSecurityPolicy"
  return await client.get("/apis/policy/v1beta1", t, name, namespace, loadPodSecurityPolicy)

type
  PodDisruptionBudgetStatus* = object
    `expectedPods`*: int
    `disruptedPods`*: Table[string,io_k8s_apimachinery_pkg_apis_meta_v1.Time]
    `observedGeneration`*: int
    `currentHealthy`*: int
    `disruptionsAllowed`*: int
    `desiredHealthy`*: int

proc load*(self: var PodDisruptionBudgetStatus, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "expectedPods":
            load(self.`expectedPods`,parser)
          of "disruptedPods":
            load(self.`disruptedPods`,parser)
          of "observedGeneration":
            load(self.`observedGeneration`,parser)
          of "currentHealthy":
            load(self.`currentHealthy`,parser)
          of "disruptionsAllowed":
            load(self.`disruptionsAllowed`,parser)
          of "desiredHealthy":
            load(self.`desiredHealthy`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: PodDisruptionBudgetStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`expectedPods`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"expectedPods\":")
    self.`expectedPods`.dump(s)
  if not self.`disruptedPods`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"disruptedPods\":")
    self.`disruptedPods`.dump(s)
  if not self.`observedGeneration`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"observedGeneration\":")
    self.`observedGeneration`.dump(s)
  if not self.`currentHealthy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"currentHealthy\":")
    self.`currentHealthy`.dump(s)
  if not self.`disruptionsAllowed`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"disruptionsAllowed\":")
    self.`disruptionsAllowed`.dump(s)
  if not self.`desiredHealthy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"desiredHealthy\":")
    self.`desiredHealthy`.dump(s)
  s.write("}")

proc isEmpty*(self: PodDisruptionBudgetStatus): bool =
  if not self.`expectedPods`.isEmpty: return false
  if not self.`disruptedPods`.isEmpty: return false
  if not self.`observedGeneration`.isEmpty: return false
  if not self.`currentHealthy`.isEmpty: return false
  if not self.`disruptionsAllowed`.isEmpty: return false
  if not self.`desiredHealthy`.isEmpty: return false
  true

type
  PodDisruptionBudget* = object
    `apiVersion`*: string
    `spec`*: PodDisruptionBudgetSpec
    `status`*: PodDisruptionBudgetStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var PodDisruptionBudget, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc dump*(self: PodDisruptionBudget, s: Stream) =
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

proc isEmpty*(self: PodDisruptionBudget): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPodDisruptionBudget(parser: var JsonParser):PodDisruptionBudget = 
  var ret: PodDisruptionBudget
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[PodDisruptionBudget], name: string, namespace = "default"): Future[PodDisruptionBudget] {.async.}=
  return await client.get("/apis/policy/v1beta1", t, name, namespace, loadPodDisruptionBudget)

proc create*(client: Client, t: PodDisruptionBudget, namespace = "default"): Future[PodDisruptionBudget] {.async.}=
  t.apiVersion = "/apis/policy/v1beta1"
  t.kind = "PodDisruptionBudget"
  return await client.get("/apis/policy/v1beta1", t, name, namespace, loadPodDisruptionBudget)

type
  Eviction* = object
    `apiVersion`*: string
    `deleteOptions`*: io_k8s_apimachinery_pkg_apis_meta_v1.DeleteOptions
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Eviction, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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
          of "deleteOptions":
            load(self.`deleteOptions`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: Eviction, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`deleteOptions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"deleteOptions\":")
    self.`deleteOptions`.dump(s)
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

proc isEmpty*(self: Eviction): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`deleteOptions`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadEviction(parser: var JsonParser):Eviction = 
  var ret: Eviction
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Eviction], name: string, namespace = "default"): Future[Eviction] {.async.}=
  return await client.get("/apis/policy/v1beta1", t, name, namespace, loadEviction)

proc create*(client: Client, t: Eviction, namespace = "default"): Future[Eviction] {.async.}=
  t.apiVersion = "/apis/policy/v1beta1"
  t.kind = "Eviction"
  return await client.get("/apis/policy/v1beta1", t, name, namespace, loadEviction)

type
  PodDisruptionBudgetList* = object
    `apiVersion`*: string
    `items`*: seq[PodDisruptionBudget]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var PodDisruptionBudgetList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc dump*(self: PodDisruptionBudgetList, s: Stream) =
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

proc isEmpty*(self: PodDisruptionBudgetList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPodDisruptionBudgetList(parser: var JsonParser):PodDisruptionBudgetList = 
  var ret: PodDisruptionBudgetList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[PodDisruptionBudget], namespace = "default"): Future[seq[PodDisruptionBudget]] {.async.}=
  return (await client.list("/apis/policy/v1beta1", PodDisruptionBudgetList, namespace, loadPodDisruptionBudgetList)).items

type
  PodSecurityPolicyList* = object
    `apiVersion`*: string
    `items`*: seq[PodSecurityPolicy]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var PodSecurityPolicyList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc dump*(self: PodSecurityPolicyList, s: Stream) =
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

proc isEmpty*(self: PodSecurityPolicyList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadPodSecurityPolicyList(parser: var JsonParser):PodSecurityPolicyList = 
  var ret: PodSecurityPolicyList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[PodSecurityPolicy], namespace = "default"): Future[seq[PodSecurityPolicy]] {.async.}=
  return (await client.list("/apis/policy/v1beta1", PodSecurityPolicyList, namespace, loadPodSecurityPolicyList)).items
