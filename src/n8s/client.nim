import httpClient, asyncdispatch, config, json, sequtils, options, strutils, streams, jsonwriter, uri, asyncstreams
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

proc newClient*(kubeconfig: string = ""): Client =
  new(result)
  result.config = load(kubeconfig)
  result.account = result.config.account
  result.client = newAsyncHttpClient(sslContext= result.account.sslContext)

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
  var counter = 0
  while true:
    let (hasData,data) = await source.read()
    if hasData:
      for c in data.items():
        buffer.add(c)
        if c == '\n':
          counter = counter + 1
          if counter == 2:
            await target.write(buffer)
            buffer = ""
            counter = 0
    else:
      if buffer.len() > 0:
        await target.write(buffer)
      break

proc loadInto[T](source: FutureStream[string], target: FutureStream[T], load: proc(parser: var JsonParser): T) {.async.} =
  while true:
    let (hasData,data) = await source.read()
    if hasData:
      let obj = loadJson(newStringStream(data),"",load)
      await target.write(obj)
    else:
      break

proc get*(client: Client, path: string): Future[FutureStream[string]] {.async.}=
  let response = await client.client.request(client.config.server & path, httpMethod = HttpGet, headers= client.account.authHeaders)
  if not response.code.is2xx: raiseError(response, await response.body)
  return response.bodyStream

proc get*[T](client: Client, groupVersion: string, t: typedesc[T], name: string, namespace: string, load: proc(parser: var JsonParser): T): Future[T] {.async.}=
  let path = groupVersion & "/namespaces/" & namespace & "/" & ($t).toLowerAscii() & "s/" & name
  return loadJson(await toStream(await client.get(path)),path,load)

proc watch*[T](client: Client, groupVersion: string, t: typedesc[T], name: string, namespace: string, load: proc(parser: var JsonParser): T): Future[FutureStream[T]] {.async.}=
  let res = newFutureStream[T]()
  var path = groupVersion & "/namespaces/" & namespace & "/" & ($t).toLowerAscii() & "s/" & name
  let obj = loadJson(await toStream(await client.get(path)),path,load)
  await res.write(obj)
  path = groupVersion & "/namespaces/" & namespace & "/" & ($t).toLowerAscii() & "s?" & encodeQuery({"watch" : "true", "resourceVersion": obj.metadata.resourceVersion,"fieldSelector" : "metadata.name=" & name})
  let fs = await client.get(path)
  let splitted = newFutureStream[string]()
  fs.splitInto(splitted).asyncCheck()
  splitted.loadInto(res,load).asyncCheck()
  return res

proc list*[T](client: Client, groupVersion: string, t: typedesc[T], namespace: string, load: proc(parser: var JsonParser): T): Future[T] {.async.}=
  let path = groupVersion & "/namespaces/" & namespace & "/" & ($t).toLowerAscii()[0..^5] & "s"
  return loadJson(await toStream(await client.get(path)),path,load)

proc create*(client: Client, path: string, content: string): Future[Stream] {.async.}=
  let response = await client.client.request(client.config.server & path, httpMethod = HttpPost, headers= client.account.authHeaders, body=content)
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
  let response = await client.client.request(client.config.server & path, httpMethod = HttpDelete, headers= client.account.authHeaders)
  let body = await response.body
  if not response.code.is2xx: raiseError(response, body)

proc delete*[T](client: Client, groupVersion: string, t: typedesc[T], name: string, namespace: string) {.async.}=
  let path = groupVersion & "/namespaces/" & namespace & "/" & ($t).toLowerAscii() & "s/" & name
  await client.delete(path)

proc replace*(client: Client, path: string, content: string): Future[Stream] {.async.}=
  let response = await client.client.request(client.config.server & path, httpMethod = HttpPut, headers= client.account.authHeaders, body=content)
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
  let response = await client.client.request(client.config.server & "/api/v1", httpMethod = HttpGet, headers= client.account.authHeaders)
  let resources = parseJson(await response.body)
  return resources["resources"].getElems.map((n) => to(n,APIResource))

proc openapi*(client: Client): Future[JsonNode] {.async.}=
  let response = await client.client.request(client.config.server & "/openapi/v2", httpMethod = HttpGet, headers= client.account.authHeaders)
  return parseJson(await response.body)




