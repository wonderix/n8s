import asyncdispatch
import src/kubernetes
import src/kubernetes/api/io_k8s_api_core_v1
import streams

when isMainModule: 
    proc test() {.async.} = 
        let client = newClient()
        for service in await client.list(Service):
           echo service.metadata.name
        echo await client.get(Service,"kubernetes")
        for pod in await client.list(Pod,"cf-system"):
           pod.dump(newFileStream(stdout))

    waitFor test()
