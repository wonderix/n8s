import ../client
import ../base_types
import parsejson
import streams
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch
import io_k8s_api_core_v1
import tables

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

proc dump*(self: VolumeAttachmentSource, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`persistentVolumeName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"persistentVolumeName\":")
    self.`persistentVolumeName`.dump(s)
  if not self.`inlineVolumeSpec`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"inlineVolumeSpec\":")
    self.`inlineVolumeSpec`.dump(s)
  s.write("}")

proc isEmpty*(self: VolumeAttachmentSource): bool =
  if not self.`persistentVolumeName`.isEmpty: return false
  if not self.`inlineVolumeSpec`.isEmpty: return false
  true

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

proc dump*(self: VolumeAttachmentSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`nodeName`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nodeName\":")
    self.`nodeName`.dump(s)
  if not self.`attacher`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"attacher\":")
    self.`attacher`.dump(s)
  if not self.`source`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"source\":")
    self.`source`.dump(s)
  s.write("}")

proc isEmpty*(self: VolumeAttachmentSpec): bool =
  if not self.`nodeName`.isEmpty: return false
  if not self.`attacher`.isEmpty: return false
  if not self.`source`.isEmpty: return false
  true

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

proc dump*(self: VolumeError, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`message`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"message\":")
    self.`message`.dump(s)
  if not self.`time`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"time\":")
    self.`time`.dump(s)
  s.write("}")

proc isEmpty*(self: VolumeError): bool =
  if not self.`message`.isEmpty: return false
  if not self.`time`.isEmpty: return false
  true

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

proc dump*(self: VolumeAttachmentStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`attached`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"attached\":")
    self.`attached`.dump(s)
  if not self.`detachError`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"detachError\":")
    self.`detachError`.dump(s)
  if not self.`attachError`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"attachError\":")
    self.`attachError`.dump(s)
  if not self.`attachmentMetadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"attachmentMetadata\":")
    self.`attachmentMetadata`.dump(s)
  s.write("}")

proc isEmpty*(self: VolumeAttachmentStatus): bool =
  if not self.`attached`.isEmpty: return false
  if not self.`detachError`.isEmpty: return false
  if not self.`attachError`.isEmpty: return false
  if not self.`attachmentMetadata`.isEmpty: return false
  true

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

proc dump*(self: VolumeAttachment, s: Stream) =
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

proc isEmpty*(self: VolumeAttachment): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadVolumeAttachment(parser: var JsonParser):VolumeAttachment = 
  var ret: VolumeAttachment
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[VolumeAttachment], name: string, namespace = "default"): Future[VolumeAttachment] {.async.}=
  return await client.get("/apis/storage.k8s.io/v1beta1", t, name, namespace, loadVolumeAttachment)

proc create*(client: Client, t: VolumeAttachment, namespace = "default"): Future[VolumeAttachment] {.async.}=
  t.apiVersion = "/apis/storage.k8s.io/v1beta1"
  t.kind = "VolumeAttachment"
  return await client.get("/apis/storage.k8s.io/v1beta1", t, name, namespace, loadVolumeAttachment)

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

proc dump*(self: VolumeAttachmentList, s: Stream) =
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

proc isEmpty*(self: VolumeAttachmentList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadVolumeAttachmentList(parser: var JsonParser):VolumeAttachmentList = 
  var ret: VolumeAttachmentList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[VolumeAttachment], namespace = "default"): Future[seq[VolumeAttachment]] {.async.}=
  return (await client.list("/apis/storage.k8s.io/v1beta1", VolumeAttachmentList, namespace, loadVolumeAttachmentList)).items

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

proc dump*(self: VolumeNodeResources, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`count`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"count\":")
    self.`count`.dump(s)
  s.write("}")

proc isEmpty*(self: VolumeNodeResources): bool =
  if not self.`count`.isEmpty: return false
  true

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

proc dump*(self: CSINodeDriver, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`allocatable`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allocatable\":")
    self.`allocatable`.dump(s)
  if not self.`nodeID`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nodeID\":")
    self.`nodeID`.dump(s)
  if not self.`topologyKeys`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"topologyKeys\":")
    self.`topologyKeys`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: CSINodeDriver): bool =
  if not self.`allocatable`.isEmpty: return false
  if not self.`nodeID`.isEmpty: return false
  if not self.`topologyKeys`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: CSINodeSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`drivers`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"drivers\":")
    self.`drivers`.dump(s)
  s.write("}")

proc isEmpty*(self: CSINodeSpec): bool =
  if not self.`drivers`.isEmpty: return false
  true

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

proc dump*(self: CSINode, s: Stream) =
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

proc isEmpty*(self: CSINode): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadCSINode(parser: var JsonParser):CSINode = 
  var ret: CSINode
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[CSINode], name: string, namespace = "default"): Future[CSINode] {.async.}=
  return await client.get("/apis/storage.k8s.io/v1beta1", t, name, namespace, loadCSINode)

proc create*(client: Client, t: CSINode, namespace = "default"): Future[CSINode] {.async.}=
  t.apiVersion = "/apis/storage.k8s.io/v1beta1"
  t.kind = "CSINode"
  return await client.get("/apis/storage.k8s.io/v1beta1", t, name, namespace, loadCSINode)

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

proc dump*(self: CSIDriverSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`attachRequired`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"attachRequired\":")
    self.`attachRequired`.dump(s)
  if not self.`podInfoOnMount`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"podInfoOnMount\":")
    self.`podInfoOnMount`.dump(s)
  if not self.`volumeLifecycleModes`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeLifecycleModes\":")
    self.`volumeLifecycleModes`.dump(s)
  s.write("}")

proc isEmpty*(self: CSIDriverSpec): bool =
  if not self.`attachRequired`.isEmpty: return false
  if not self.`podInfoOnMount`.isEmpty: return false
  if not self.`volumeLifecycleModes`.isEmpty: return false
  true

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

proc dump*(self: CSIDriver, s: Stream) =
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

proc isEmpty*(self: CSIDriver): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadCSIDriver(parser: var JsonParser):CSIDriver = 
  var ret: CSIDriver
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[CSIDriver], name: string, namespace = "default"): Future[CSIDriver] {.async.}=
  return await client.get("/apis/storage.k8s.io/v1beta1", t, name, namespace, loadCSIDriver)

proc create*(client: Client, t: CSIDriver, namespace = "default"): Future[CSIDriver] {.async.}=
  t.apiVersion = "/apis/storage.k8s.io/v1beta1"
  t.kind = "CSIDriver"
  return await client.get("/apis/storage.k8s.io/v1beta1", t, name, namespace, loadCSIDriver)

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

proc dump*(self: CSIDriverList, s: Stream) =
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

proc isEmpty*(self: CSIDriverList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadCSIDriverList(parser: var JsonParser):CSIDriverList = 
  var ret: CSIDriverList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[CSIDriver], namespace = "default"): Future[seq[CSIDriver]] {.async.}=
  return (await client.list("/apis/storage.k8s.io/v1beta1", CSIDriverList, namespace, loadCSIDriverList)).items

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

proc dump*(self: CSINodeList, s: Stream) =
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

proc isEmpty*(self: CSINodeList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadCSINodeList(parser: var JsonParser):CSINodeList = 
  var ret: CSINodeList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[CSINode], namespace = "default"): Future[seq[CSINode]] {.async.}=
  return (await client.list("/apis/storage.k8s.io/v1beta1", CSINodeList, namespace, loadCSINodeList)).items

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

proc dump*(self: StorageClass, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`reclaimPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"reclaimPolicy\":")
    self.`reclaimPolicy`.dump(s)
  if not self.`allowedTopologies`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allowedTopologies\":")
    self.`allowedTopologies`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`parameters`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"parameters\":")
    self.`parameters`.dump(s)
  if not self.`provisioner`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"provisioner\":")
    self.`provisioner`.dump(s)
  if not self.`volumeBindingMode`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"volumeBindingMode\":")
    self.`volumeBindingMode`.dump(s)
  if not self.`mountOptions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"mountOptions\":")
    self.`mountOptions`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`allowVolumeExpansion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allowVolumeExpansion\":")
    self.`allowVolumeExpansion`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: StorageClass): bool =
  if not self.`reclaimPolicy`.isEmpty: return false
  if not self.`allowedTopologies`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`parameters`.isEmpty: return false
  if not self.`provisioner`.isEmpty: return false
  if not self.`volumeBindingMode`.isEmpty: return false
  if not self.`mountOptions`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`allowVolumeExpansion`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadStorageClass(parser: var JsonParser):StorageClass = 
  var ret: StorageClass
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[StorageClass], name: string, namespace = "default"): Future[StorageClass] {.async.}=
  return await client.get("/apis/storage.k8s.io/v1beta1", t, name, namespace, loadStorageClass)

proc create*(client: Client, t: StorageClass, namespace = "default"): Future[StorageClass] {.async.}=
  t.apiVersion = "/apis/storage.k8s.io/v1beta1"
  t.kind = "StorageClass"
  return await client.get("/apis/storage.k8s.io/v1beta1", t, name, namespace, loadStorageClass)

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

proc dump*(self: StorageClassList, s: Stream) =
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

proc isEmpty*(self: StorageClassList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadStorageClassList(parser: var JsonParser):StorageClassList = 
  var ret: StorageClassList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[StorageClass], namespace = "default"): Future[seq[StorageClass]] {.async.}=
  return (await client.list("/apis/storage.k8s.io/v1beta1", StorageClassList, namespace, loadStorageClassList)).items
