import ../client
import ../base_types
import parsejson
import streams
import tables
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch

type
  CertificateSigningRequestSpec* = object
    `uid`*: string
    `username`*: string
    `usages`*: seq[string]
    `groups`*: seq[string]
    `request`*: ByteArray
    `extra`*: Table[string,seq[string]]

proc load*(self: var CertificateSigningRequestSpec, parser: var JsonParser) =
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
          of "uid":
            load(self.`uid`,parser)
          of "username":
            load(self.`username`,parser)
          of "usages":
            load(self.`usages`,parser)
          of "groups":
            load(self.`groups`,parser)
          of "request":
            load(self.`request`,parser)
          of "extra":
            load(self.`extra`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: CertificateSigningRequestSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`uid`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"uid\":")
    self.`uid`.dump(s)
  if not self.`username`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"username\":")
    self.`username`.dump(s)
  if not self.`usages`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"usages\":")
    self.`usages`.dump(s)
  if not self.`groups`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"groups\":")
    self.`groups`.dump(s)
  if not self.`request`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"request\":")
    self.`request`.dump(s)
  if not self.`extra`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"extra\":")
    self.`extra`.dump(s)
  s.write("}")

proc isEmpty*(self: CertificateSigningRequestSpec): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`username`.isEmpty: return false
  if not self.`usages`.isEmpty: return false
  if not self.`groups`.isEmpty: return false
  if not self.`request`.isEmpty: return false
  if not self.`extra`.isEmpty: return false
  true

type
  CertificateSigningRequestCondition* = object
    `type`*: string
    `message`*: string
    `lastUpdateTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `reason`*: string

proc load*(self: var CertificateSigningRequestCondition, parser: var JsonParser) =
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
          of "type":
            load(self.`type`,parser)
          of "message":
            load(self.`message`,parser)
          of "lastUpdateTime":
            load(self.`lastUpdateTime`,parser)
          of "reason":
            load(self.`reason`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: CertificateSigningRequestCondition, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`message`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"message\":")
    self.`message`.dump(s)
  if not self.`lastUpdateTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastUpdateTime\":")
    self.`lastUpdateTime`.dump(s)
  if not self.`reason`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"reason\":")
    self.`reason`.dump(s)
  s.write("}")

proc isEmpty*(self: CertificateSigningRequestCondition): bool =
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`lastUpdateTime`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  true

type
  CertificateSigningRequestStatus* = object
    `conditions`*: seq[CertificateSigningRequestCondition]
    `certificate`*: ByteArray

proc load*(self: var CertificateSigningRequestStatus, parser: var JsonParser) =
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
          of "conditions":
            load(self.`conditions`,parser)
          of "certificate":
            load(self.`certificate`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: CertificateSigningRequestStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`conditions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conditions\":")
    self.`conditions`.dump(s)
  if not self.`certificate`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"certificate\":")
    self.`certificate`.dump(s)
  s.write("}")

proc isEmpty*(self: CertificateSigningRequestStatus): bool =
  if not self.`conditions`.isEmpty: return false
  if not self.`certificate`.isEmpty: return false
  true

type
  CertificateSigningRequest* = object
    `apiVersion`*: string
    `spec`*: CertificateSigningRequestSpec
    `status`*: CertificateSigningRequestStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var CertificateSigningRequest, parser: var JsonParser) =
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

proc dump*(self: CertificateSigningRequest, s: Stream) =
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

proc isEmpty*(self: CertificateSigningRequest): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadCertificateSigningRequest(parser: var JsonParser):CertificateSigningRequest = 
  var ret: CertificateSigningRequest
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[CertificateSigningRequest], name: string, namespace = "default"): Future[CertificateSigningRequest] {.async.}=
  return await client.get("/apis/certificates.k8s.io/v1beta1",t,name,namespace, loadCertificateSigningRequest)

type
  CertificateSigningRequestList* = object
    `apiVersion`*: string
    `items`*: seq[CertificateSigningRequest]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var CertificateSigningRequestList, parser: var JsonParser) =
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

proc dump*(self: CertificateSigningRequestList, s: Stream) =
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

proc isEmpty*(self: CertificateSigningRequestList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadCertificateSigningRequestList(parser: var JsonParser):CertificateSigningRequestList = 
  var ret: CertificateSigningRequestList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[CertificateSigningRequest], namespace = "default"): Future[seq[CertificateSigningRequest]] {.async.}=
  return (await client.list("/apis/certificates.k8s.io/v1beta1",CertificateSigningRequestList,namespace, loadCertificateSigningRequestList)).items
