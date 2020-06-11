# Kubernetes client for nim


## Installation


## Example

```python
import n8s
# Import required k8s api
import n8s/api/io_k8s_api_core_v1

# Connect to kubernetes
let client = newClient()

# Prepare secret
var secret: Secret
secret.metadata.name = "test"

# Create secret in kubernetes
secret = await client.create(secret)

# Get secret
secret = await client.get(Secret,"test")
```