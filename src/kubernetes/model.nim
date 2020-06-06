import json

type

    ObjectMeta* = object
        creationTimestamp*: string
        labels*: JsonNode
        name*: string
        namespace*: string
        resourceVersion*: string
        selfLink*: string
        uid*: string

    ServicePort* = object
        name*: string
        port*: int
        protocol*: string
        targetPort*: int

    ServiceSpec* = object
        clusterIP*: string
        ports*: seq[ServicePort]
        sessionAffinity*: string
        `type`*: string

    ServiceStatus* = object
      loadBalancer: JsonNode
      
    Service* = object
        apiVersion*: string
        kind*: string
        metadata*: ObjectMeta
        spec*: ServiceSpec
        status*: ServiceStatus

func groupVersion*(t: typedesc[Service]): string =
    return "/api/v1"

