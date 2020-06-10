import ../client
import ../base_types
import parsejson
import streams
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

proc dump*(self: JobTemplateSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`spec`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"spec\":")
    self.`spec`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

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

proc dump*(self: CronJobSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`failedJobsHistoryLimit`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"failedJobsHistoryLimit\":")
    self.`failedJobsHistoryLimit`.dump(s)
  if not self.`suspend`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"suspend\":")
    self.`suspend`.dump(s)
  if not self.`concurrencyPolicy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"concurrencyPolicy\":")
    self.`concurrencyPolicy`.dump(s)
  if not self.`jobTemplate`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"jobTemplate\":")
    self.`jobTemplate`.dump(s)
  if not self.`successfulJobsHistoryLimit`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"successfulJobsHistoryLimit\":")
    self.`successfulJobsHistoryLimit`.dump(s)
  if not self.`schedule`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"schedule\":")
    self.`schedule`.dump(s)
  if not self.`startingDeadlineSeconds`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"startingDeadlineSeconds\":")
    self.`startingDeadlineSeconds`.dump(s)
  s.write("}")

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

proc dump*(self: CronJobStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`lastScheduleTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastScheduleTime\":")
    self.`lastScheduleTime`.dump(s)
  if not self.`active`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"active\":")
    self.`active`.dump(s)
  s.write("}")

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

proc dump*(self: CronJob, s: Stream) =
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
  return await client.get("/apis/batch/v1beta1",t,name,namespace, loadCronJob)

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

proc dump*(self: CronJobList, s: Stream) =
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
  return (await client.list("/apis/batch/v1beta1",CronJobList,namespace, loadCronJobList)).items
