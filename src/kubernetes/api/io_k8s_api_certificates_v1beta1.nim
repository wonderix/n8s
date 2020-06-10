import ../client
import ../base_types
import parsejson
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

proc get*(client: Client, t: typedesc[CertificateSigningRequest], name: string, namespace = "default"): Future[CertificateSigningRequest] {.async.}=
  proc unmarshal(parser: var JsonParser):CertificateSigningRequest = 
    var ret: CertificateSigningRequest
    load(ret,parser)
    return ret 
  return await client.get("/apis/certificates.k8s.io/v1beta1",t,name,namespace, unmarshal)

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

proc get*(client: Client, t: typedesc[CertificateSigningRequestList], name: string, namespace = "default"): Future[CertificateSigningRequestList] {.async.}=
  proc unmarshal(parser: var JsonParser):CertificateSigningRequestList = 
    var ret: CertificateSigningRequestList
    load(ret,parser)
    return ret 
  return await client.get("/apis/certificates.k8s.io/v1beta1",t,name,namespace, unmarshal)
