import httpClient, asyncdispatch, config, json, sequtils, options, strutils, tables
from sugar import `=>`
import typetraits

type
    Client = ref object of RootObj
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

    ObjectMeta* = object
        creationTimestamp*: string
        labels*: Table[string,string]
        name*: string
        namespace*: string
        resourceVersion*: string
        selfLink*: string
        uid*: string

    ServicePort* = object
        name*: string
        port*: int
        protocol*: string
        targetPort*: int

    ServiceSpec* = object
        clusterIP*: string
        ports*: seq[ServicePort]
        sessionAffinity*: string
        `type`*: string

    ServiceStatus* = object
      loadBalancer: Table[string,string]
      
    Service* = object
        apiVersion*: string
        kind*: string
        metadata*: ObjectMeta
        spec*: JsonNode
        status*: ServiceStatus


func groupVersion(t: typedesc[Service]): string =
    return "/api/v1"

proc newClient*(kubeconfig: string = ""): Client =
    new(result)
    result.config = load(kubeconfig)
    result.account = result.config.account
    result.client = newAsyncHttpClient(sslContext= result.account.sslContext)

proc get(client: Client, kind: string, name: string, namespace = "default"): Future[string] {.async.}=
    let response = await client.client.request(client.config.server & "/api/v1/namespaces/" & namespace & "/" & kind & "/" & name, httpMethod = HttpGet, headers= client.account.authHeaders)
    return await response.body

 

proc get[T](client: Client, t: typedesc[T], name: string, namespace = "default"): Future[T] {.async.}=
    let kind = ($t).toLowerAscii() & "s"
    let p = groupVersion(t)
    let response = await client.client.request(client.config.server & p & "/namespaces/" & namespace & "/" & kind & "/" & name, httpMethod = HttpGet, headers= client.account.authHeaders)
    let body = await response.body
    if not response.code.is2xx:
        raise newException(HttpRequestError,$parseJson(body)["message"].getStr)
    return to(parseJson(body),T)

proc apiResources(client: Client): Future[seq[APIResource]] {.async.}=
    let response = await client.client.request(client.config.server & "/api/v1", httpMethod = HttpGet, headers= client.account.authHeaders)
    let resources = parseJson(await response.body)
    return resources["resources"].getElems.map((n) => to(n,APIResource))

proc openapi(client: Client): Future[JsonNode] {.async.}=
    let response = await client.client.request(client.config.server & "/openapi/v2", httpMethod = HttpGet, headers= client.account.authHeaders)
    return parseJson(await response.body)

when isMainModule: 
    proc test() {.async.} = 
        let client = newClient()
        echo await client.get(Service,"kubernetes")
        # echo await client.openapi()
        # for resource in await client.apiResources():
        #    echo resource.kind
        # echo await client.get("services","kubernetes")
        #echo await client.get( "test",Pod)

    waitFor test()
