import httpClient, asyncdispatch, config, json, sequtils, options, strutils, streams, jsonstream
from sugar import `=>`

type
  Client* = ref object of RootObj
    config: Config
    client: AsyncHttpClient
    account: Account

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

proc get*(client: Client, path: string): Future[Stream] {.async.}=
  let response = await client.client.request(client.config.server & path, httpMethod = HttpGet, headers= client.account.authHeaders)
  let body = await response.body
  if not response.code.is2xx:
    raise newException(HttpRequestError,$parseJson(body)["message"].getStr & ": " & path)
  return newStringStream(body)

proc get*[T](client: Client, groupVersion: string, t: typedesc[T], name: string, namespace: string, load: proc(parser: var JsonParser): T): Future[T] {.async.}=
  let path = groupVersion & "/namespaces/" & namespace & "/" & ($t).toLowerAscii() & "s/" & name
  return loadJson(await client.get(path),path,load)

proc list*[T](client: Client, groupVersion: string, t: typedesc[T], namespace: string, load: proc(parser: var JsonParser): T): Future[T] {.async.}=
  let path = groupVersion & "/namespaces/" & namespace & "/" & ($t).toLowerAscii()[0..^5] & "s"
  return loadJson(await client.get(path),path,load)

proc create*(client: Client, path: string, content: string): Future[Stream] {.async.}=
  let response = await client.client.request(client.config.server & path, httpMethod = HttpPost, headers= client.account.authHeaders, body=content)
  let body = await response.body
  if not response.code.is2xx:
    raise newException(HttpRequestError,$parseJson(body)["message"].getStr & ": " & path)
  return newStringStream(body)

proc create*[T](client: Client, groupVersion: string, t: T, namespace: string, load: proc(parser: var JsonParser): T): Future[T] {.async.}=
  let path = groupVersion & "/namespaces/" & namespace & "/" & ($(typedesc[T])).toLowerAscii() & "s"
  let stream = newStringStream()
  t.dump(newJsonStream(stream))
  return loadJson(await client.create(path,stream.readAll()),path,load)

proc apiResources*(client: Client): Future[seq[APIResource]] {.async.}=
  let response = await client.client.request(client.config.server & "/api/v1", httpMethod = HttpGet, headers= client.account.authHeaders)
  let resources = parseJson(await response.body)
  return resources["resources"].getElems.map((n) => to(n,APIResource))

proc openapi*(client: Client): Future[JsonNode] {.async.}=
  let response = await client.client.request(client.config.server & "/openapi/v2", httpMethod = HttpGet, headers= client.account.authHeaders)
  return parseJson(await response.body)




