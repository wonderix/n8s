import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams
import io_k8s_api_core_v1
import io_k8s_apimachinery_pkg_apis_meta_v1

type
  VolumeAttachmentSource* = object
    `persistentVolumeName`*: string
    `inlineVolumeSpec`*: io_k8s_api_core_v1.PersistentVolumeSpec

proc load*(self: var VolumeAttachmentSource, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "persistentVolumeName":
            load(self.`persistentVolumeName`,parser)
          of "inlineVolumeSpec":
            load(self.`inlineVolumeSpec`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  VolumeAttachmentSpec* = object
    `nodeName`*: string
    `attacher`*: string
    `source`*: VolumeAttachmentSource

proc load*(self: var VolumeAttachmentSpec, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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
          of "attacher":
            load(self.`attacher`,parser)
          of "source":
            load(self.`source`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  VolumeError* = object
    `message`*: string
    `time`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time

proc load*(self: var VolumeError, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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
          of "time":
            load(self.`time`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  VolumeAttachmentStatus* = object
    `attached`*: bool
    `detachError`*: VolumeError
    `attachError`*: VolumeError
    `attachmentMetadata`*: Table[string,string]

proc load*(self: var VolumeAttachmentStatus, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "attached":
            load(self.`attached`,parser)
          of "detachError":
            load(self.`detachError`,parser)
          of "attachError":
            load(self.`attachError`,parser)
          of "attachmentMetadata":
            load(self.`attachmentMetadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  VolumeAttachment* = object
    `apiVersion`*: string
    `spec`*: VolumeAttachmentSpec
    `status`*: VolumeAttachmentStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var VolumeAttachment, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc get*(client: Client, t: typedesc[VolumeAttachment], name: string, namespace = "default"): Future[VolumeAttachment] {.async.}=
  proc unmarshal(parser: var JsonParser):VolumeAttachment = 
    var ret: VolumeAttachment
    load(ret,parser)
    return ret 
  return await client.get("/apis/storage.k8s.io/v1beta1",t,name,namespace, unmarshal)

type
  VolumeAttachmentList* = object
    `apiVersion`*: string
    `items`*: seq[VolumeAttachment]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var VolumeAttachmentList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc get*(client: Client, t: typedesc[VolumeAttachmentList], name: string, namespace = "default"): Future[VolumeAttachmentList] {.async.}=
  proc unmarshal(parser: var JsonParser):VolumeAttachmentList = 
    var ret: VolumeAttachmentList
    load(ret,parser)
    return ret 
  return await client.get("/apis/storage.k8s.io/v1beta1",t,name,namespace, unmarshal)

type
  VolumeNodeResources* = object
    `count`*: int

proc load*(self: var VolumeNodeResources, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CSINodeDriver* = object
    `allocatable`*: VolumeNodeResources
    `nodeID`*: string
    `topologyKeys`*: seq[string]
    `name`*: string

proc load*(self: var CSINodeDriver, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "allocatable":
            load(self.`allocatable`,parser)
          of "nodeID":
            load(self.`nodeID`,parser)
          of "topologyKeys":
            load(self.`topologyKeys`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CSINodeSpec* = object
    `drivers`*: seq[CSINodeDriver]

proc load*(self: var CSINodeSpec, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "drivers":
            load(self.`drivers`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CSINode* = object
    `apiVersion`*: string
    `spec`*: CSINodeSpec
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var CSINode, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc get*(client: Client, t: typedesc[CSINode], name: string, namespace = "default"): Future[CSINode] {.async.}=
  proc unmarshal(parser: var JsonParser):CSINode = 
    var ret: CSINode
    load(ret,parser)
    return ret 
  return await client.get("/apis/storage.k8s.io/v1beta1",t,name,namespace, unmarshal)

type
  CSIDriverSpec* = object
    `attachRequired`*: bool
    `podInfoOnMount`*: bool
    `volumeLifecycleModes`*: seq[string]

proc load*(self: var CSIDriverSpec, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "attachRequired":
            load(self.`attachRequired`,parser)
          of "podInfoOnMount":
            load(self.`podInfoOnMount`,parser)
          of "volumeLifecycleModes":
            load(self.`volumeLifecycleModes`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CSIDriver* = object
    `apiVersion`*: string
    `spec`*: CSIDriverSpec
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var CSIDriver, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc get*(client: Client, t: typedesc[CSIDriver], name: string, namespace = "default"): Future[CSIDriver] {.async.}=
  proc unmarshal(parser: var JsonParser):CSIDriver = 
    var ret: CSIDriver
    load(ret,parser)
    return ret 
  return await client.get("/apis/storage.k8s.io/v1beta1",t,name,namespace, unmarshal)

type
  CSIDriverList* = object
    `apiVersion`*: string
    `items`*: seq[CSIDriver]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var CSIDriverList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc get*(client: Client, t: typedesc[CSIDriverList], name: string, namespace = "default"): Future[CSIDriverList] {.async.}=
  proc unmarshal(parser: var JsonParser):CSIDriverList = 
    var ret: CSIDriverList
    load(ret,parser)
    return ret 
  return await client.get("/apis/storage.k8s.io/v1beta1",t,name,namespace, unmarshal)

type
  CSINodeList* = object
    `apiVersion`*: string
    `items`*: seq[CSINode]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var CSINodeList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc get*(client: Client, t: typedesc[CSINodeList], name: string, namespace = "default"): Future[CSINodeList] {.async.}=
  proc unmarshal(parser: var JsonParser):CSINodeList = 
    var ret: CSINodeList
    load(ret,parser)
    return ret 
  return await client.get("/apis/storage.k8s.io/v1beta1",t,name,namespace, unmarshal)

type
  StorageClass* = object
    `reclaimPolicy`*: string
    `allowedTopologies`*: seq[io_k8s_api_core_v1.TopologySelectorTerm]
    `apiVersion`*: string
    `parameters`*: Table[string,string]
    `provisioner`*: string
    `volumeBindingMode`*: string
    `mountOptions`*: seq[string]
    `kind`*: string
    `allowVolumeExpansion`*: bool
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var StorageClass, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "reclaimPolicy":
            load(self.`reclaimPolicy`,parser)
          of "allowedTopologies":
            load(self.`allowedTopologies`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "parameters":
            load(self.`parameters`,parser)
          of "provisioner":
            load(self.`provisioner`,parser)
          of "volumeBindingMode":
            load(self.`volumeBindingMode`,parser)
          of "mountOptions":
            load(self.`mountOptions`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "allowVolumeExpansion":
            load(self.`allowVolumeExpansion`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[StorageClass], name: string, namespace = "default"): Future[StorageClass] {.async.}=
  proc unmarshal(parser: var JsonParser):StorageClass = 
    var ret: StorageClass
    load(ret,parser)
    return ret 
  return await client.get("/apis/storage.k8s.io/v1beta1",t,name,namespace, unmarshal)

type
  StorageClassList* = object
    `apiVersion`*: string
    `items`*: seq[StorageClass]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var StorageClassList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc get*(client: Client, t: typedesc[StorageClassList], name: string, namespace = "default"): Future[StorageClassList] {.async.}=
  proc unmarshal(parser: var JsonParser):StorageClassList = 
    var ret: StorageClassList
    load(ret,parser)
    return ret 
  return await client.get("/apis/storage.k8s.io/v1beta1",t,name,namespace, unmarshal)
