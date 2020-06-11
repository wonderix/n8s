import asyncdispatch
import ../src/kubernetes
import ../src/kubernetes/api/io_k8s_api_core_v1
import tables

proc createSecret() {.async.} = 
  let client = newClient()

  try:
    await client.delete(Secret,"test")
  except NotFoundError:
    discard

  let secretData = "test".ByteArray
  var secret: Secret
  secret.data["test"] = secretData
  secret.metadata.name = "test"

  secret = await client.create(secret)
  doAssert secret.data["test"] == secretData
  
  secret.data["test"] = "hello".ByteArray
  secret = await client.replace(secret)
  doAssert secret.data["test"] == "hello".ByteArray

  await client.delete(Secret,"test")


waitFor createSecret()
