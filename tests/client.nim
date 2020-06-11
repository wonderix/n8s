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

  var secret: Secret
  secret.data["test"] = "test".ByteArray
  secret.metadata.name = "test"

  secret = await client.create(secret)

  await client.delete(Secret,"test")


waitFor createSecret()
