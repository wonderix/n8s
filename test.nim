import asyncdispatch
import src/kubernetes
import src/kubernetes/api/io_k8s_api_core_v1
import tables
import streams

when isMainModule: 
  proc test() {.async.} = 
    let client = newClient()
    # let service = await client.get(Service,"kubernetes")
    # service.dump(newJsonStream(stdout))
    # for service in await client.list(Service):
    #   service.dump(newJsonStream(stdout))
    # for pod in await client.list(Pod):
    #   pod.dump(newJsonStream(stdout))

    var secret: Secret
    secret.data["test"] = "test".ByteArray
    secret.metadata.name = "test"

    secret = await client.create(secret)
    secret.dump(newJsonStream(stdout))


waitFor test()
