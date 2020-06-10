import ../client
import ../base_types
import parsejson
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

proc get*(client: Client, t: typedesc[RuntimeClass], name: string, namespace = "default"): Future[RuntimeClass] {.async.}=
  proc unmarshal(parser: var JsonParser):RuntimeClass = 
    var ret: RuntimeClass
    load(ret,parser)
    return ret 
  return await client.get("/apis/node.k8s.io/v1beta1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[RuntimeClassList], name: string, namespace = "default"): Future[RuntimeClassList] {.async.}=
  proc unmarshal(parser: var JsonParser):RuntimeClassList = 
    var ret: RuntimeClassList
    load(ret,parser)
    return ret 
  return await client.get("/apis/node.k8s.io/v1beta1",t,name,namespace, unmarshal)
