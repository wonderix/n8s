import ../client
import ../base_types
import parsejson
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

proc get*(client: Client, t: typedesc[PodSecurityPolicy], name: string, namespace = "default"): Future[PodSecurityPolicy] {.async.}=
  proc unmarshal(parser: var JsonParser):PodSecurityPolicy = 
    var ret: PodSecurityPolicy
    load(ret,parser)
    return ret 
  return await client.get("/apis/policy/v1beta1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[PodDisruptionBudget], name: string, namespace = "default"): Future[PodDisruptionBudget] {.async.}=
  proc unmarshal(parser: var JsonParser):PodDisruptionBudget = 
    var ret: PodDisruptionBudget
    load(ret,parser)
    return ret 
  return await client.get("/apis/policy/v1beta1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[Eviction], name: string, namespace = "default"): Future[Eviction] {.async.}=
  proc unmarshal(parser: var JsonParser):Eviction = 
    var ret: Eviction
    load(ret,parser)
    return ret 
  return await client.get("/apis/policy/v1beta1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[PodDisruptionBudgetList], name: string, namespace = "default"): Future[PodDisruptionBudgetList] {.async.}=
  proc unmarshal(parser: var JsonParser):PodDisruptionBudgetList = 
    var ret: PodDisruptionBudgetList
    load(ret,parser)
    return ret 
  return await client.get("/apis/policy/v1beta1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[PodSecurityPolicyList], name: string, namespace = "default"): Future[PodSecurityPolicyList] {.async.}=
  proc unmarshal(parser: var JsonParser):PodSecurityPolicyList = 
    var ret: PodSecurityPolicyList
    load(ret,parser)
    return ret 
  return await client.get("/apis/policy/v1beta1",t,name,namespace, unmarshal)
