import asyncdispatch
import test/io_k8s_api_core_v1
import src/kubernetes

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
