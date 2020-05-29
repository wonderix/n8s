import httpClient, asyncdispatch, config, net

type
    Client = ref object of RootObj
        config: Config
        client: AsyncHttpClient

proc newClient(kubeconfig: string = ""): Client =
    new(result)
    let sslContext = newContext(verifyMode = CVerifyNone)
    # proc getPsk (hint: string): tuple[identity: string, psk: string] =
    #     return ("","")
    # sslContext.clientGetPskFunc = getPsk
    result.client = newAsyncHttpClient(sslContext= sslContext)
    result.config = load(kubeconfig)

proc get(client: Client, kind: string, name: string, namespace = "default"): Future[string] {.async.}=
    let response = await client.client.request(client.config.server & "/api/v1/namespaces/" & namespace & "/" & kind & "/" & name, httpMethod = HttpGet, headers= client.config.authHeaders)
    return await response.body

proc apiResources(client: Client): Future[string] {.async.}=
    let response = await client.client.request(client.config.server & "/api/v1", httpMethod = HttpGet, headers= client.config.authHeaders)
    return await response.body

when isMainModule: 
    proc test() {.async.} = 
        let client = newClient()
        echo await client.apiResources()
        echo await client.get("services","kubernetes")

    waitFor test()
