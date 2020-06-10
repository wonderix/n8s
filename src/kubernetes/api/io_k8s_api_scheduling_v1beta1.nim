import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams
import io_k8s_apimachinery_pkg_apis_meta_v1

type
  PriorityClass* = object
    `globalDefault`*: bool
    `apiVersion`*: string
    `description`*: string
    `value`*: int
    `preemptionPolicy`*: string
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var PriorityClass, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "globalDefault":
            load(self.`globalDefault`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "description":
            load(self.`description`,parser)
          of "value":
            load(self.`value`,parser)
          of "preemptionPolicy":
            load(self.`preemptionPolicy`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[PriorityClass], name: string, namespace = "default"): Future[PriorityClass] {.async.}=
  proc unmarshal(parser: var JsonParser):PriorityClass = 
    var ret: PriorityClass
    load(ret,parser)
    return ret 
  return await client.get("/apis/scheduling.k8s.io/v1beta1",t,name,namespace, unmarshal)

type
  PriorityClassList* = object
    `apiVersion`*: string
    `items`*: seq[PriorityClass]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var PriorityClassList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc get*(client: Client, t: typedesc[PriorityClassList], name: string, namespace = "default"): Future[PriorityClassList] {.async.}=
  proc unmarshal(parser: var JsonParser):PriorityClassList = 
    var ret: PriorityClassList
    load(ret,parser)
    return ret 
  return await client.get("/apis/scheduling.k8s.io/v1beta1",t,name,namespace, unmarshal)
