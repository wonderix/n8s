import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams
import io_k8s_api_core_v1
import io_k8s_apimachinery_pkg_apis_meta_v1

type
  JobSpec* = object
    `completions`*: int
    `activeDeadlineSeconds`*: int
    `backoffLimit`*: int
    `manualSelector`*: bool
    `template`*: io_k8s_api_core_v1.PodTemplateSpec
    `selector`*: io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector
    `parallelism`*: int
    `ttlSecondsAfterFinished`*: int

proc load*(self: var JobSpec, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "completions":
            load(self.`completions`,parser)
          of "activeDeadlineSeconds":
            load(self.`activeDeadlineSeconds`,parser)
          of "backoffLimit":
            load(self.`backoffLimit`,parser)
          of "manualSelector":
            load(self.`manualSelector`,parser)
          of "template":
            load(self.`template`,parser)
          of "selector":
            load(self.`selector`,parser)
          of "parallelism":
            load(self.`parallelism`,parser)
          of "ttlSecondsAfterFinished":
            load(self.`ttlSecondsAfterFinished`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  JobCondition* = object
    `lastTransitionTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `type`*: string
    `message`*: string
    `lastProbeTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `reason`*: string
    `status`*: string

proc load*(self: var JobCondition, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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
  JobStatus* = object
    `failed`*: int
    `completionTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `startTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `succeeded`*: int
    `conditions`*: seq[JobCondition]
    `active`*: int

proc load*(self: var JobStatus, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "failed":
            load(self.`failed`,parser)
          of "completionTime":
            load(self.`completionTime`,parser)
          of "startTime":
            load(self.`startTime`,parser)
          of "succeeded":
            load(self.`succeeded`,parser)
          of "conditions":
            load(self.`conditions`,parser)
          of "active":
            load(self.`active`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  Job* = object
    `apiVersion`*: string
    `spec`*: JobSpec
    `status`*: JobStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Job, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc get*(client: Client, t: typedesc[Job], name: string, namespace = "default"): Future[Job] {.async.}=
  proc unmarshal(parser: var JsonParser):Job = 
    var ret: Job
    load(ret,parser)
    return ret 
  return await client.get("/apis/batch/v1",t,name,namespace, unmarshal)

type
  JobList* = object
    `apiVersion`*: string
    `items`*: seq[Job]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var JobList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc get*(client: Client, t: typedesc[JobList], name: string, namespace = "default"): Future[JobList] {.async.}=
  proc unmarshal(parser: var JsonParser):JobList = 
    var ret: JobList
    load(ret,parser)
    return ret 
  return await client.get("/apis/batch/v1",t,name,namespace, unmarshal)
