import ../client
import ../base_types
import parsejson
import ../jsonstream
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch
import io_k8s_api_core_v1

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

proc dump*(self: JobSpec, s: JsonStream) =
  s.objectStart()
  if not self.`completions`.isEmpty:
    s.name("completions")
    self.`completions`.dump(s)
  if not self.`activeDeadlineSeconds`.isEmpty:
    s.name("activeDeadlineSeconds")
    self.`activeDeadlineSeconds`.dump(s)
  if not self.`backoffLimit`.isEmpty:
    s.name("backoffLimit")
    self.`backoffLimit`.dump(s)
  if not self.`manualSelector`.isEmpty:
    s.name("manualSelector")
    self.`manualSelector`.dump(s)
  s.name("template")
  self.`template`.dump(s)
  if not self.`selector`.isEmpty:
    s.name("selector")
    self.`selector`.dump(s)
  if not self.`parallelism`.isEmpty:
    s.name("parallelism")
    self.`parallelism`.dump(s)
  if not self.`ttlSecondsAfterFinished`.isEmpty:
    s.name("ttlSecondsAfterFinished")
    self.`ttlSecondsAfterFinished`.dump(s)
  s.objectEnd()

proc isEmpty*(self: JobSpec): bool =
  if not self.`completions`.isEmpty: return false
  if not self.`activeDeadlineSeconds`.isEmpty: return false
  if not self.`backoffLimit`.isEmpty: return false
  if not self.`manualSelector`.isEmpty: return false
  if not self.`template`.isEmpty: return false
  if not self.`selector`.isEmpty: return false
  if not self.`parallelism`.isEmpty: return false
  if not self.`ttlSecondsAfterFinished`.isEmpty: return false
  true

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

proc dump*(self: JobCondition, s: JsonStream) =
  s.objectStart()
  if not self.`lastTransitionTime`.isEmpty:
    s.name("lastTransitionTime")
    self.`lastTransitionTime`.dump(s)
  s.name("type")
  self.`type`.dump(s)
  if not self.`message`.isEmpty:
    s.name("message")
    self.`message`.dump(s)
  if not self.`lastProbeTime`.isEmpty:
    s.name("lastProbeTime")
    self.`lastProbeTime`.dump(s)
  if not self.`reason`.isEmpty:
    s.name("reason")
    self.`reason`.dump(s)
  s.name("status")
  self.`status`.dump(s)
  s.objectEnd()

proc isEmpty*(self: JobCondition): bool =
  if not self.`lastTransitionTime`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`lastProbeTime`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

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

proc dump*(self: JobStatus, s: JsonStream) =
  s.objectStart()
  if not self.`failed`.isEmpty:
    s.name("failed")
    self.`failed`.dump(s)
  if not self.`completionTime`.isEmpty:
    s.name("completionTime")
    self.`completionTime`.dump(s)
  if not self.`startTime`.isEmpty:
    s.name("startTime")
    self.`startTime`.dump(s)
  if not self.`succeeded`.isEmpty:
    s.name("succeeded")
    self.`succeeded`.dump(s)
  if not self.`conditions`.isEmpty:
    s.name("conditions")
    self.`conditions`.dump(s)
  if not self.`active`.isEmpty:
    s.name("active")
    self.`active`.dump(s)
  s.objectEnd()

proc isEmpty*(self: JobStatus): bool =
  if not self.`failed`.isEmpty: return false
  if not self.`completionTime`.isEmpty: return false
  if not self.`startTime`.isEmpty: return false
  if not self.`succeeded`.isEmpty: return false
  if not self.`conditions`.isEmpty: return false
  if not self.`active`.isEmpty: return false
  true

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

proc dump*(self: Job, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("batch/v1")
  s.name("kind"); s.value("Job")
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

proc isEmpty*(self: Job): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadJob(parser: var JsonParser):Job = 
  var ret: Job
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Job], name: string, namespace = "default"): Future[Job] {.async.}=
  return await client.get("/apis/batch/v1", t, name, namespace, loadJob)

proc create*(client: Client, t: Job, namespace = "default"): Future[Job] {.async.}=
  return await client.create("/apis/batch/v1", t, namespace, loadJob)

proc delete*(client: Client, t: typedesc[Job], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/batch/v1", t, name, namespace)

proc replace*(client: Client, t: Job, namespace = "default"): Future[Job] {.async.}=
  return await client.replace("/apis/batch/v1", t, t.metadata.name, namespace, loadJob)

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

proc dump*(self: JobList, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("batch/v1")
  s.name("kind"); s.value("JobList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: JobList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadJobList(parser: var JsonParser):JobList = 
  var ret: JobList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[Job], namespace = "default"): Future[seq[Job]] {.async.}=
  return (await client.list("/apis/batch/v1", JobList, namespace, loadJobList)).items
