import httpClient, asyncdispatch, config, net

type
    Client = ref object of RootObj
        config: Config
        client: AsyncHttpClient

proc newClient(kubeconfig: string): Client =
    new(result)
    let sslContext = newContext(verifyMode = CVerifyNone)
    proc getPsk (hint: string): tuple[identity: string, psk: string] =
        return ("","")
    sslContext.clientGetPskFunc = getPsk
    result.client = newAsyncHttpClient(sslContext= sslContext)
    result.config = load(kubeconfig)

proc get(client: Client, namespace: string, kind: string): Future[string] {.async.}=
    let response = await client.client.request(client.config.server, httpMethod = HttpGet)
    return await response.body

when isMainModule: 
    proc test() {.async.} = 
        let client = newClient(getHomeDir & "/.kube/config")
        echo await client.get("default","pods")

    waitFor test()
