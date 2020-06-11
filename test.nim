import asyncdispatch
import src/kubernetes
import src/kubernetes/api/io_k8s_api_core_v1
import streams
import tables

when isMainModule: 
  proc test() {.async.} = 
    let client = newClient()
    let service = await client.get(Service,"kubernetes")
    service.dump(newFileStream(stdout))
    # for service in await client.list(Service):
    #   service.dump(newFileStream(stdout))
    # for pod in await client.list(Pod):
    #   pod.dump(newFileStream(stdout))

    # var secret: Secret
    # secret.data["test"] = "test".ByteArray
    # secret.metadata.name = "test"
    # secret = await client.create(secret)
    # secret.dump(newFileStream(stdout))


waitFor test()


{"apiVersion":"v1","kind":"Service","spec":{"type":"ClusterIP","ports":{{"targetPort":6443,"protocol":"TCP","port":443,"name":"https"}},"sessionAffinity":"None","clusterIP":"10.96.0.1"},"metadata":{"uid":"31adc2e2-cd0b-4a4a-a1c6-6d892095b4f4","creationTimestamp":"2020-06-06T09:26:25Z","labels":{"provider":"kubernetes","component":"apiserver"},"resourceVersion":"151","selfLink":"/api/v1/namespaces/default/services/kubernetes","namespace":"default","name":"kubernetes"}}%                                                                                                                                                                                        
