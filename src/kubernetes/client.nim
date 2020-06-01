import httpClient, asyncdispatch, config, json, sequtils, options
from sugar import `=>`

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

proc newClient(kubeconfig: string = ""): Client =
    new(result)
    result.config = load(kubeconfig)
    result.account = result.config.account
    result.client = newAsyncHttpClient(sslContext= result.account.sslContext)

proc get(client: Client, kind: string, name: string, namespace = "default"): Future[string] {.async.}=
    let response = await client.client.request(client.config.server & "/api/v1/namespaces/" & namespace & "/" & kind & "/" & name, httpMethod = HttpGet, headers= client.account.authHeaders)
    return await response.body

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
        echo await client.openapi()
        # for resource in await client.apiResources():
        #    echo resource.kind
        # echo await client.get("services","kubernetes")

    waitFor test()
