import httpClient, asyncdispatch, config, json, sequtils, options, strutils, streams, jsonwriter, uri, asyncstreams
import base_types
from sugar import `=>`

type

  Client* = ref object of RootObj
    config: Config
    client: AsyncHttpClient
    account: Account

  AlreadyExistsError* = object of CatchableError 
  NotFoundError* = object of CatchableError 

  APIResource = object
    name: string
    singularName: string
    namespaced: bool
    kind: string
    verbs: seq[string]
    shortNames: Option[seq[string]]
    storageVersionHash: Option[string]

proc newAsyncHttpClient(account: Account): AsyncHttpClient =
  newAsyncHttpClient(sslContext= account.sslContext,headers= account.authHeaders)

proc newClient*(kubeconfig: string = ""): Client =
  new(result)
  result.config = load(kubeconfig)
  result.account = result.config.account
  result.client = newAsyncHttpClient(result.account)


proc loadJson[T](stream: Stream, path: string, load: proc(parser: var JsonParser): T): T =
  var parser: JsonParser
  try:
    parser.open(stream,path)
    parser.next
    return load(parser)
  finally:
    parser.close

proc toStream(fs: FutureStream[string]): Future[Stream] {.async.} =
  return newStringStream(await fs.readAll())

proc raiseError(response: AsyncResponse, body: string) =
  let message = $parseJson(body)["message"].getStr
  case response.code:
    of Http404:
      raise newException(NotFoundError,message)
    of Http409:
      raise newException(AlreadyExistsError,message)
    else:
      raise newException(HttpRequestError,message)

proc splitInto(source: FutureStream[string], target: FutureStream[string]) {.async.} =
  var buffer = ""
  while true:
    let (hasData,data) = await source.read()
    if hasData:
      for c in data.items():
        buffer.add(c)
        if c == '\n':
          await target.write(buffer)
          buffer = ""
    else:
      if buffer.len() > 0:
        await target.write(buffer)
      break

proc loadWatchEvsInto[T](source: FutureStream[string], target: FutureStream[WatchEv[T]]) {.async.} =
  while true:
    let (hasData,data) = await source.read()
    if hasData:
      proc x(parser: var JsonParser): WatchEv[T] = 
        loadWatchEv(result,parser)
      let obj = loadJson(newStringStream(data),"",x)
      await target.write(obj)
    else:
      break

proc get(client: AsyncHttpClient, server: string, path: string): Future[FutureStream[string]] {.async.}=
  let response = await client.request(server & path, httpMethod = HttpGet)
  if not response.code.is2xx: raiseError(response, await response.body)
  return response.bodyStream

proc get*(client: Client, path: string): Future[FutureStream[string]]=
  client.client.get(client.config.server,path)

proc get*[T](client: Client, groupVersion: string, t: typedesc[T], name: string, namespace: string, load: proc(parser: var JsonParser): T): Future[T] {.async.}=
  let path = groupVersion & "/namespaces/" & namespace & "/" & ($t).toLowerAscii() & "s/" & name
  return loadJson(await toStream(await client.get(path)),path,load)

proc watch*[T](client: Client, groupVersion: string, t: typedesc[T], name: string, namespace: string, load: proc(parser: var JsonParser): T): Future[FutureStream[WatchEv[T]]] {.async.}=
  let res = newFutureStream[WatchEv[T]]()
  let path = groupVersion & "/namespaces/" & namespace & "/" & ($t).toLowerAscii() & "s/" & name
  let obj = loadJson(await toStream(await client.get(path)),path,load)
  await res.write(WatchEv[T](`type`:"",`object`:obj))
  proc background() {.async.} =
    let c = newAsyncHttpClient(client.account)
    let path = groupVersion & "/namespaces/" & namespace & "/" & ($t).toLowerAscii() & "s?" & encodeQuery({"watch" : "true", "resourceVersion": obj.metadata.resourceVersion,"fieldSelector" : "metadata.name=" & name})
    let fs = await c.get(client.config.server, path)
    let splitted = newFutureStream[string]()
    fs.splitInto(splitted).asyncCheck()
    loadWatchEvsInto[T](splitted, res).asyncCheck()
  background().asyncCheck()
  return res

proc list*[T](client: Client, groupVersion: string, t: typedesc[T], namespace: string, load: proc(parser: var JsonParser): T): Future[T] {.async.}=
  let path = groupVersion & "/namespaces/" & namespace & "/" & ($t).toLowerAscii()[0..^5] & "s"
  return loadJson(await toStream(await client.get(path)),path,load)

proc create*(client: Client, path: string, content: string): Future[Stream] {.async.}=
  let response = await client.client.request(client.config.server & path, httpMethod = HttpPost, body=content)
  let body = await response.body
  if not response.code.is2xx: raiseError(response, body)
  return newStringStream(body)

proc create*[T](client: Client, groupVersion: string, t: T, namespace: string, load: proc(parser: var JsonParser): T): Future[T] {.async.}=
  let path = groupVersion & "/namespaces/" & namespace & "/" & ($(typedesc[T])).toLowerAscii() & "s"
  let stream = newStringStream()
  t.dump(newJsonWriter(stream))
  stream.setPosition(0)
  return loadJson(await client.create(path,stream.readAll()),path,load)

proc delete*(client: Client, path: string) {.async.}=
  let response = await client.client.request(client.config.server & path, httpMethod = HttpDelete)
  let body = await response.body
  if not response.code.is2xx: raiseError(response, body)

proc delete*[T](client: Client, groupVersion: string, t: typedesc[T], name: string, namespace: string) {.async.}=
  let path = groupVersion & "/namespaces/" & namespace & "/" & ($t).toLowerAscii() & "s/" & name
  await client.delete(path)

proc replace*(client: Client, path: string, content: string): Future[Stream] {.async.}=
  let response = await client.client.request(client.config.server & path, httpMethod = HttpPut, body=content)
  let body = await response.body
  if not response.code.is2xx: raiseError(response, body)
  return newStringStream(body)

proc replace*[T](client: Client, groupVersion: string, t: T, name: string, namespace: string, load: proc(parser: var JsonParser): T): Future[T] {.async.}=
  let path = groupVersion & "/namespaces/" & namespace & "/" & ($(typedesc[T])).toLowerAscii() & "s/" & name
  let stream = newStringStream()
  t.dump(newJsonWriter(stream))
  stream.setPosition(0)
  return loadJson(await client.replace(path,stream.readAll()),path,load)

proc apiResources*(client: Client): Future[seq[APIResource]] {.async.}=
  let response = await client.client.request(client.config.server & "/api/v1", httpMethod = HttpGet)
  let resources = parseJson(await response.body)
  return resources["resources"].getElems.map((n) => to(n,APIResource))

proc openapi*(client: Client): Future[JsonNode] {.async.}=
  let response = await client.client.request(client.config.server & "/openapi/v2", httpMethod = HttpGet)
  return parseJson(await response.body)




