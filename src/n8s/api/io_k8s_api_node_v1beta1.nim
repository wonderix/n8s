import ../client
import ../base_types
import parsejson
import ../jsonstream
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch
import io_k8s_api_core_v1
import tables
import io_k8s_apimachinery_pkg_api_resource

type
  Scheduling* = object
    `tolerations`*: seq[io_k8s_api_core_v1.Toleration]
    `nodeSelector`*: Table[string,string]

proc load*(self: var Scheduling, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "tolerations":
            load(self.`tolerations`,parser)
          of "nodeSelector":
            load(self.`nodeSelector`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: Scheduling, s: JsonStream) =
  s.objectStart()
  if not self.`tolerations`.isEmpty:
    s.name("tolerations")
    self.`tolerations`.dump(s)
  if not self.`nodeSelector`.isEmpty:
    s.name("nodeSelector")
    self.`nodeSelector`.dump(s)
  s.objectEnd()

proc isEmpty*(self: Scheduling): bool =
  if not self.`tolerations`.isEmpty: return false
  if not self.`nodeSelector`.isEmpty: return false
  true

type
  Overhead* = object
    `podFixed`*: Table[string,io_k8s_apimachinery_pkg_api_resource.Quantity]

proc load*(self: var Overhead, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "podFixed":
            load(self.`podFixed`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: Overhead, s: JsonStream) =
  s.objectStart()
  if not self.`podFixed`.isEmpty:
    s.name("podFixed")
    self.`podFixed`.dump(s)
  s.objectEnd()

proc isEmpty*(self: Overhead): bool =
  if not self.`podFixed`.isEmpty: return false
  true

type
  RuntimeClass* = object
    `apiVersion`*: string
    `scheduling`*: Scheduling
    `handler`*: string
    `overhead`*: Overhead
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var RuntimeClass, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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
          of "scheduling":
            load(self.`scheduling`,parser)
          of "handler":
            load(self.`handler`,parser)
          of "overhead":
            load(self.`overhead`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: RuntimeClass, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("node.k8s.io/v1beta1")
  s.name("kind"); s.value("RuntimeClass")
  if not self.`scheduling`.isEmpty:
    s.name("scheduling")
    self.`scheduling`.dump(s)
  s.name("handler")
  self.`handler`.dump(s)
  if not self.`overhead`.isEmpty:
    s.name("overhead")
    self.`overhead`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: RuntimeClass): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`scheduling`.isEmpty: return false
  if not self.`handler`.isEmpty: return false
  if not self.`overhead`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadRuntimeClass(parser: var JsonParser):RuntimeClass = 
  var ret: RuntimeClass
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[RuntimeClass], name: string, namespace = "default"): Future[RuntimeClass] {.async.}=
  return await client.get("/apis/node.k8s.io/v1beta1", t, name, namespace, loadRuntimeClass)

proc create*(client: Client, t: RuntimeClass, namespace = "default"): Future[RuntimeClass] {.async.}=
  return await client.create("/apis/node.k8s.io/v1beta1", t, namespace, loadRuntimeClass)

proc delete*(client: Client, t: typedesc[RuntimeClass], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/node.k8s.io/v1beta1", t, name, namespace)

proc replace*(client: Client, t: RuntimeClass, namespace = "default"): Future[RuntimeClass] {.async.}=
  return await client.replace("/apis/node.k8s.io/v1beta1", t, t.metadata.name, namespace, loadRuntimeClass)

type
  RuntimeClassList* = object
    `apiVersion`*: string
    `items`*: seq[RuntimeClass]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var RuntimeClassList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc dump*(self: RuntimeClassList, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("node.k8s.io/v1beta1")
  s.name("kind"); s.value("RuntimeClassList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: RuntimeClassList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadRuntimeClassList(parser: var JsonParser):RuntimeClassList = 
  var ret: RuntimeClassList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[RuntimeClass], namespace = "default"): Future[seq[RuntimeClass]] {.async.}=
  return (await client.list("/apis/node.k8s.io/v1beta1", RuntimeClassList, namespace, loadRuntimeClassList)).items
