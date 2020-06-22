import asyncdispatch
import ../n8s/client
import json


when isMainModule: 
  let c = newClient()

  let api = waitFor c.openapi()
  let definitions = api["definitions"]
  writeFile("src/n8s/api/api.json",pretty(definitions))
