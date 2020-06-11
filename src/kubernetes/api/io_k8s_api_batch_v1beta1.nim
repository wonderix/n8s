import ../client
import ../base_types
import parsejson
import ../jsonstream
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

proc dump*(self: JobTemplateSpec, s: JsonStream) =
  s.objectStart()
  if not self.`spec`.isEmpty:
    s.name("spec")
    self.`spec`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: JobTemplateSpec): bool =
  if not self.`spec`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

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

proc dump*(self: CronJobSpec, s: JsonStream) =
  s.objectStart()
  if not self.`failedJobsHistoryLimit`.isEmpty:
    s.name("failedJobsHistoryLimit")
    self.`failedJobsHistoryLimit`.dump(s)
  if not self.`suspend`.isEmpty:
    s.name("suspend")
    self.`suspend`.dump(s)
  if not self.`concurrencyPolicy`.isEmpty:
    s.name("concurrencyPolicy")
    self.`concurrencyPolicy`.dump(s)
  s.name("jobTemplate")
  self.`jobTemplate`.dump(s)
  if not self.`successfulJobsHistoryLimit`.isEmpty:
    s.name("successfulJobsHistoryLimit")
    self.`successfulJobsHistoryLimit`.dump(s)
  s.name("schedule")
  self.`schedule`.dump(s)
  if not self.`startingDeadlineSeconds`.isEmpty:
    s.name("startingDeadlineSeconds")
    self.`startingDeadlineSeconds`.dump(s)
  s.objectEnd()

proc isEmpty*(self: CronJobSpec): bool =
  if not self.`failedJobsHistoryLimit`.isEmpty: return false
  if not self.`suspend`.isEmpty: return false
  if not self.`concurrencyPolicy`.isEmpty: return false
  if not self.`jobTemplate`.isEmpty: return false
  if not self.`successfulJobsHistoryLimit`.isEmpty: return false
  if not self.`schedule`.isEmpty: return false
  if not self.`startingDeadlineSeconds`.isEmpty: return false
  true

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

proc dump*(self: CronJobStatus, s: JsonStream) =
  s.objectStart()
  if not self.`lastScheduleTime`.isEmpty:
    s.name("lastScheduleTime")
    self.`lastScheduleTime`.dump(s)
  if not self.`active`.isEmpty:
    s.name("active")
    self.`active`.dump(s)
  s.objectEnd()

proc isEmpty*(self: CronJobStatus): bool =
  if not self.`lastScheduleTime`.isEmpty: return false
  if not self.`active`.isEmpty: return false
  true

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

proc dump*(self: CronJob, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("batch/v1beta1")
  s.name("kind"); s.value("CronJob")
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

proc isEmpty*(self: CronJob): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadCronJob(parser: var JsonParser):CronJob = 
  var ret: CronJob
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[CronJob], name: string, namespace = "default"): Future[CronJob] {.async.}=
  return await client.get("/apis/batch/v1beta1", t, name, namespace, loadCronJob)

proc create*(client: Client, t: CronJob, namespace = "default"): Future[CronJob] {.async.}=
  return await client.create("/apis/batch/v1beta1", t, namespace, loadCronJob)

proc delete*(client: Client, t: typedesc[CronJob], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/batch/v1beta1", t, name, namespace)

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

proc dump*(self: CronJobList, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("batch/v1beta1")
  s.name("kind"); s.value("CronJobList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: CronJobList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadCronJobList(parser: var JsonParser):CronJobList = 
  var ret: CronJobList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[CronJob], namespace = "default"): Future[seq[CronJob]] {.async.}=
  return (await client.list("/apis/batch/v1beta1", CronJobList, namespace, loadCronJobList)).items
