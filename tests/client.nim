import asyncdispatch
import ../src/n8s
import ../src/n8s/api/io_k8s_api_core_v1
import ../src/n8s/api/io_k8s_api_apps_v1
import tables
import json
import unittest

suite "n8s client":
  let client = newClient()

  test "modify secret":

    proc testSecret() {.async.} = 

      try:
        await client.delete(Secret,"test")
      except NotFoundError:
        discard

      var secret: Secret
      secret.data["test"] = "test"
      secret.metadata.name = "test"

      secret = await client.create(secret)
      doAssert secret.data["test"] == "test"
      
      secret.data["test"] = "hello"
      secret = await client.replace(secret)
      doAssert secret.data["test"] == "hello"

      # let fs = await client.watch(Secret,"test")
      # while not fs.finished():
      # echo await fs.read()
      
      await client.delete(Secret,"test")

    waitFor testSecret()
  
  test "RawExtension":

    proc testRawExtension() {.async.} = 
      let controllerRevisions = await client.list(ControllerRevision,namespace="kube-system")
      doAssert controllerRevisions.len == 1
      for controllerRevision in controllerRevisions:
        doAssert controllerRevision.data["spec"].kind == JObject

    waitFor testRawExtension()
