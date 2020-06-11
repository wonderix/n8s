import ../client
import ../base_types
import parsejson
import ../jsonstream
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

proc dump*(self: CertificateSigningRequestSpec, s: JsonStream) =
  s.objectStart()
  if not self.`uid`.isEmpty:
    s.name("uid")
    self.`uid`.dump(s)
  if not self.`username`.isEmpty:
    s.name("username")
    self.`username`.dump(s)
  if not self.`usages`.isEmpty:
    s.name("usages")
    self.`usages`.dump(s)
  if not self.`groups`.isEmpty:
    s.name("groups")
    self.`groups`.dump(s)
  if not self.`request`.isEmpty:
    s.name("request")
    self.`request`.dump(s)
  if not self.`extra`.isEmpty:
    s.name("extra")
    self.`extra`.dump(s)
  s.objectEnd()

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

proc dump*(self: CertificateSigningRequestCondition, s: JsonStream) =
  s.objectStart()
  if not self.`type`.isEmpty:
    s.name("type")
    self.`type`.dump(s)
  if not self.`message`.isEmpty:
    s.name("message")
    self.`message`.dump(s)
  if not self.`lastUpdateTime`.isEmpty:
    s.name("lastUpdateTime")
    self.`lastUpdateTime`.dump(s)
  if not self.`reason`.isEmpty:
    s.name("reason")
    self.`reason`.dump(s)
  s.objectEnd()

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

proc dump*(self: CertificateSigningRequestStatus, s: JsonStream) =
  s.objectStart()
  if not self.`conditions`.isEmpty:
    s.name("conditions")
    self.`conditions`.dump(s)
  if not self.`certificate`.isEmpty:
    s.name("certificate")
    self.`certificate`.dump(s)
  s.objectEnd()

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

proc dump*(self: CertificateSigningRequest, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("certificates.k8s.io/v1beta1")
  s.name("kind"); s.value("CertificateSigningRequest")
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
  return await client.get("/apis/certificates.k8s.io/v1beta1", t, name, namespace, loadCertificateSigningRequest)

proc create*(client: Client, t: CertificateSigningRequest, namespace = "default"): Future[CertificateSigningRequest] {.async.}=
  return await client.create("/apis/certificates.k8s.io/v1beta1", t, namespace, loadCertificateSigningRequest)

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

proc dump*(self: CertificateSigningRequestList, s: JsonStream) =
  s.objectStart()
  s.name("apiVersion"); s.value("certificates.k8s.io/v1beta1")
  s.name("kind"); s.value("CertificateSigningRequestList")
  if not self.`items`.isEmpty:
    s.name("items")
    self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

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
  return (await client.list("/apis/certificates.k8s.io/v1beta1", CertificateSigningRequestList, namespace, loadCertificateSigningRequestList)).items
