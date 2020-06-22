import ../client
import ../base_types
import parsejson
import ../jsonwriter
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

proc dump*(self: HostPortRange, s: JsonWriter) =
  s.objectStart()
  s.name("max")
  self.`max`.dump(s)
  s.name("min")
  self.`min`.dump(s)
  s.objectEnd()

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

proc dump*(self: PodDisruptionBudgetSpec, s: JsonWriter) =
  s.objectStart()
  if not self.`maxUnavailable`.isEmpty:
    s.name("maxUnavailable")
    self.`maxUnavailable`.dump(s)
  if not self.`selector`.isEmpty:
    s.name("selector")
    self.`selector`.dump(s)
  if not self.`minAvailable`.isEmpty:
    s.name("minAvailable")
    self.`minAvailable`.dump(s)
  s.objectEnd()

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

proc dump*(self: AllowedFlexVolume, s: JsonWriter) =
  s.objectStart()
  s.name("driver")
  self.`driver`.dump(s)
  s.objectEnd()

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

proc dump*(self: RuntimeClassStrategyOptions, s: JsonWriter) =
  s.objectStart()
  s.name("allowedRuntimeClassNames")
  self.`allowedRuntimeClassNames`.dump(s)
  if not self.`defaultRuntimeClassName`.isEmpty:
    s.name("defaultRuntimeClassName")
    self.`defaultRuntimeClassName`.dump(s)
  s.objectEnd()

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

proc dump*(self: IDRange, s: JsonWriter) =
  s.objectStart()
  s.name("max")
  self.`max`.dump(s)
  s.name("min")
  self.`min`.dump(s)
  s.objectEnd()

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

proc dump*(self: FSGroupStrategyOptions, s: JsonWriter) =
  s.objectStart()
  if not self.`rule`.isEmpty:
    s.name("rule")
    self.`rule`.dump(s)
  if not self.`ranges`.isEmpty:
    s.name("ranges")
    self.`ranges`.dump(s)
  s.objectEnd()

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

proc dump*(self: SupplementalGroupsStrategyOptions, s: JsonWriter) =
  s.objectStart()
  if not self.`rule`.isEmpty:
    s.name("rule")
    self.`rule`.dump(s)
  if not self.`ranges`.isEmpty:
    s.name("ranges")
    self.`ranges`.dump(s)
  s.objectEnd()

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

proc dump*(self: SELinuxStrategyOptions, s: JsonWriter) =
  s.objectStart()
  s.name("rule")
  self.`rule`.dump(s)
  if not self.`seLinuxOptions`.isEmpty:
    s.name("seLinuxOptions")
    self.`seLinuxOptions`.dump(s)
  s.objectEnd()

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

proc dump*(self: AllowedHostPath, s: JsonWriter) =
  s.objectStart()
  if not self.`pathPrefix`.isEmpty:
    s.name("pathPrefix")
    self.`pathPrefix`.dump(s)
  if not self.`readOnly`.isEmpty:
    s.name("readOnly")
    self.`readOnly`.dump(s)
  s.objectEnd()

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

proc dump*(self: AllowedCSIDriver, s: JsonWriter) =
  s.objectStart()
  s.name("name")
  self.`name`.dump(s)
  s.objectEnd()

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

proc dump*(self: RunAsGroupStrategyOptions, s: JsonWriter) =
  s.objectStart()
  s.name("rule")
  self.`rule`.dump(s)
  if not self.`ranges`.isEmpty:
    s.name("ranges")
    self.`ranges`.dump(s)
  s.objectEnd()

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

proc dump*(self: RunAsUserStrategyOptions, s: JsonWriter) =
  s.objectStart()
  s.name("rule")
  self.`rule`.dump(s)
  if not self.`ranges`.isEmpty:
    s.name("ranges")
    self.`ranges`.dump(s)
  s.objectEnd()

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

proc dump*(self: PodSecurityPolicySpec, s: JsonWriter) =
  s.objectStart()
  if not self.`allowedProcMountTypes`.isEmpty:
    s.name("allowedProcMountTypes")
    self.`allowedProcMountTypes`.dump(s)
  if not self.`allowedCapabilities`.isEmpty:
    s.name("allowedCapabilities")
    self.`allowedCapabilities`.dump(s)
  if not self.`runtimeClass`.isEmpty:
    s.name("runtimeClass")
    self.`runtimeClass`.dump(s)
  if not self.`readOnlyRootFilesystem`.isEmpty:
    s.name("readOnlyRootFilesystem")
    self.`readOnlyRootFilesystem`.dump(s)
  s.name("fsGroup")
  self.`fsGroup`.dump(s)
  s.name("supplementalGroups")
  self.`supplementalGroups`.dump(s)
  s.name("seLinux")
  self.`seLinux`.dump(s)
  if not self.`defaultAddCapabilities`.isEmpty:
    s.name("defaultAddCapabilities")
    self.`defaultAddCapabilities`.dump(s)
  if not self.`allowedHostPaths`.isEmpty:
    s.name("allowedHostPaths")
    self.`allowedHostPaths`.dump(s)
  if not self.`defaultAllowPrivilegeEscalation`.isEmpty:
    s.name("defaultAllowPrivilegeEscalation")
    self.`defaultAllowPrivilegeEscalation`.dump(s)
  if not self.`allowPrivilegeEscalation`.isEmpty:
    s.name("allowPrivilegeEscalation")
    self.`allowPrivilegeEscalation`.dump(s)
  if not self.`allowedUnsafeSysctls`.isEmpty:
    s.name("allowedUnsafeSysctls")
    self.`allowedUnsafeSysctls`.dump(s)
  if not self.`allowedCSIDrivers`.isEmpty:
    s.name("allowedCSIDrivers")
    self.`allowedCSIDrivers`.dump(s)
  if not self.`hostPID`.isEmpty:
    s.name("hostPID")
    self.`hostPID`.dump(s)
  if not self.`hostPorts`.isEmpty:
    s.name("hostPorts")
    self.`hostPorts`.dump(s)
  if not self.`runAsGroup`.isEmpty:
    s.name("runAsGroup")
    self.`runAsGroup`.dump(s)
  if not self.`hostIPC`.isEmpty:
    s.name("hostIPC")
    self.`hostIPC`.dump(s)
  if not self.`hostNetwork`.isEmpty:
    s.name("hostNetwork")
    self.`hostNetwork`.dump(s)
  if not self.`requiredDropCapabilities`.isEmpty:
    s.name("requiredDropCapabilities")
    self.`requiredDropCapabilities`.dump(s)
  if not self.`volumes`.isEmpty:
    s.name("volumes")
    self.`volumes`.dump(s)
  if not self.`allowedFlexVolumes`.isEmpty:
    s.name("allowedFlexVolumes")
    self.`allowedFlexVolumes`.dump(s)
  if not self.`privileged`.isEmpty:
    s.name("privileged")
    self.`privileged`.dump(s)
  if not self.`forbiddenSysctls`.isEmpty:
    s.name("forbiddenSysctls")
    self.`forbiddenSysctls`.dump(s)
  s.name("runAsUser")
  self.`runAsUser`.dump(s)
  s.objectEnd()

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

proc dump*(self: PodSecurityPolicy, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("policy/v1beta1")
  s.name("kind"); s.value("PodSecurityPolicy")
  if not self.`spec`.isEmpty:
    s.name("spec")
    self.`spec`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

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
  return await client.create("/apis/policy/v1beta1", t, namespace, loadPodSecurityPolicy)

proc delete*(client: Client, t: typedesc[PodSecurityPolicy], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/policy/v1beta1", t, name, namespace)

proc replace*(client: Client, t: PodSecurityPolicy, namespace = "default"): Future[PodSecurityPolicy] {.async.}=
  return await client.replace("/apis/policy/v1beta1", t, t.metadata.name, namespace, loadPodSecurityPolicy)

proc watch*(client: Client, t: typedesc[PodSecurityPolicy], name: string, namespace = "default"): Future[FutureStream[WatchEv[PodSecurityPolicy]]] {.async.}=
  return await client.watch("/apis/policy/v1beta1", t, name, namespace, loadPodSecurityPolicy)

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

proc dump*(self: PodDisruptionBudgetStatus, s: JsonWriter) =
  s.objectStart()
  s.name("expectedPods")
  self.`expectedPods`.dump(s)
  if not self.`disruptedPods`.isEmpty:
    s.name("disruptedPods")
    self.`disruptedPods`.dump(s)
  if not self.`observedGeneration`.isEmpty:
    s.name("observedGeneration")
    self.`observedGeneration`.dump(s)
  s.name("currentHealthy")
  self.`currentHealthy`.dump(s)
  s.name("disruptionsAllowed")
  self.`disruptionsAllowed`.dump(s)
  s.name("desiredHealthy")
  self.`desiredHealthy`.dump(s)
  s.objectEnd()

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

proc dump*(self: PodDisruptionBudget, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("policy/v1beta1")
  s.name("kind"); s.value("PodDisruptionBudget")
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
  return await client.create("/apis/policy/v1beta1", t, namespace, loadPodDisruptionBudget)

proc delete*(client: Client, t: typedesc[PodDisruptionBudget], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/policy/v1beta1", t, name, namespace)

proc replace*(client: Client, t: PodDisruptionBudget, namespace = "default"): Future[PodDisruptionBudget] {.async.}=
  return await client.replace("/apis/policy/v1beta1", t, t.metadata.name, namespace, loadPodDisruptionBudget)

proc watch*(client: Client, t: typedesc[PodDisruptionBudget], name: string, namespace = "default"): Future[FutureStream[WatchEv[PodDisruptionBudget]]] {.async.}=
  return await client.watch("/apis/policy/v1beta1", t, name, namespace, loadPodDisruptionBudget)

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

proc dump*(self: Eviction, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("policy/v1beta1")
  s.name("kind"); s.value("Eviction")
  if not self.`deleteOptions`.isEmpty:
    s.name("deleteOptions")
    self.`deleteOptions`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

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
  return await client.create("/apis/policy/v1beta1", t, namespace, loadEviction)

proc delete*(client: Client, t: typedesc[Eviction], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/policy/v1beta1", t, name, namespace)

proc replace*(client: Client, t: Eviction, namespace = "default"): Future[Eviction] {.async.}=
  return await client.replace("/apis/policy/v1beta1", t, t.metadata.name, namespace, loadEviction)

proc watch*(client: Client, t: typedesc[Eviction], name: string, namespace = "default"): Future[FutureStream[WatchEv[Eviction]]] {.async.}=
  return await client.watch("/apis/policy/v1beta1", t, name, namespace, loadEviction)

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

proc dump*(self: PodDisruptionBudgetList, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("policy/v1beta1")
  s.name("kind"); s.value("PodDisruptionBudgetList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

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

proc dump*(self: PodSecurityPolicyList, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("policy/v1beta1")
  s.name("kind"); s.value("PodSecurityPolicyList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

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
