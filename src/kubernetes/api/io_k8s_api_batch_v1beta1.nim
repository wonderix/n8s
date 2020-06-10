import ../client
import ../base_types
import parsejson
import io_k8s_api_batch_v1
import io_k8s_apimachinery_pkg_apis_meta_v1
import io_k8s_api_core_v1
import asyncdispatch

type
  JobTemplateSpec* = object
    `spec`*: io_k8s_api_batch_v1.JobSpec
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var JobTemplateSpec, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

type
  CronJobSpec* = object
    `failedJobsHistoryLimit`*: int
    `suspend`*: bool
    `concurrencyPolicy`*: string
    `jobTemplate`*: JobTemplateSpec
    `successfulJobsHistoryLimit`*: int
    `schedule`*: string
    `startingDeadlineSeconds`*: int

proc load*(self: var CronJobSpec, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "failedJobsHistoryLimit":
            load(self.`failedJobsHistoryLimit`,parser)
          of "suspend":
            load(self.`suspend`,parser)
          of "concurrencyPolicy":
            load(self.`concurrencyPolicy`,parser)
          of "jobTemplate":
            load(self.`jobTemplate`,parser)
          of "successfulJobsHistoryLimit":
            load(self.`successfulJobsHistoryLimit`,parser)
          of "schedule":
            load(self.`schedule`,parser)
          of "startingDeadlineSeconds":
            load(self.`startingDeadlineSeconds`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CronJobStatus* = object
    `lastScheduleTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `active`*: seq[io_k8s_api_core_v1.ObjectReference]

proc load*(self: var CronJobStatus, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "lastScheduleTime":
            load(self.`lastScheduleTime`,parser)
          of "active":
            load(self.`active`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CronJob* = object
    `apiVersion`*: string
    `spec`*: CronJobSpec
    `status`*: CronJobStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var CronJob, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc get*(client: Client, t: typedesc[CronJob], name: string, namespace = "default"): Future[CronJob] {.async.}=
  proc unmarshal(parser: var JsonParser):CronJob = 
    var ret: CronJob
    load(ret,parser)
    return ret 
  return await client.get("/apis/batch/v1beta1",t,name,namespace, unmarshal)

type
  CronJobList* = object
    `apiVersion`*: string
    `items`*: seq[CronJob]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var CronJobList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
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

proc get*(client: Client, t: typedesc[CronJobList], name: string, namespace = "default"): Future[CronJobList] {.async.}=
  proc unmarshal(parser: var JsonParser):CronJobList = 
    var ret: CronJobList
    load(ret,parser)
    return ret 
  return await client.get("/apis/batch/v1beta1",t,name,namespace, unmarshal)
