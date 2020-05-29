import yaml, streams, byte_array, tables, strutils, sequtils
from sugar import `=>`

type 
    Cluster* = object
        `certificate-authority-data`: ByteArray
        server: string
    NamedCluster* = object
        cluster: Cluster
        name: string

    Context* = object
        cluster: string
        user: string

    NamedContext* = object
        context: Context
        name: string

    UserKind* = enum 
        ukToken,
        ukCert,
        ukBasic
    User* = object
        case kind: UserKind
        of ukToken:
            token: string
        of ukCert:
            `client-certificate-data`: ByteArray
            `client-key-data`: ByteArray
        of ukBasic:
            username: string
            password: string

    NamedUser* = object
        user: User
        name: string

    Config* = object
        apiVersion: string
        clusters: seq[NamedCluster]
        contexts: seq[NamedContext]
        `current-context`: string
        kind: string
        users: seq[NamedUser]
        preferences: Table[string,string]



proc constructObject*( s: var YamlStream, c: ConstructionContext, result: var User)
        {.raises: [YamlConstructionError, YamlStreamError ].} =
    let event = s.next()
    if event.kind != yamlStartMap:
        raise newException(YamlConstructionError,"Expected map start, got " & $event.kind)
    var token: string
    var password: string
    var username: string
    var client_certificate_data: ByteArray
    var client_key_data: ByteArray
    while s.peek().kind != yamlEndMap:
        var key: string
        constructChild(s, c, key)
        case key:
            of "token":
                constructChild(s, c, token)
            of "username":
                constructChild(s, c, username)
            of "password":
                constructChild(s, c, password)
            of "client-certificate-data":
                constructChild(s, c, client_certificate_data)
            of "client-key-data":
                constructChild(s, c, client_key_data)
    discard s.next()
    if token != "":
        result = User(kind: ukToken, token: token)
    elif username != "":
        result = User(kind: ukBasic, username: username, password: password)
    elif string(client_certificate_data) != "":
        result = User(kind: ukCert, `client-certificate-data`: client_certificate_data, `client-key-data`: client_key_data)
    else:
        raise newException(YamlConstructionError,"Invalid User type")
    


proc representObject*(value: User, ts: TagStyle, c: SerializationContext, tag: TagId) {.raises: [].} =
  ## represents an integer value as YAML scalar
  c.put(startMapEvent(tag))
  let childTagStyle = if ts == tsRootOnly: tsNone else: ts
  case value.kind:
    of ukToken:
        representChild("token", childTagStyle, c)
        representChild(value.token, childTagStyle, c)
    of ukCert:
        representChild("client-certificate-data", childTagStyle, c)
        representChild(value.`client-certificate-data`, childTagStyle, c)
        representChild("client-key-data", childTagStyle, c)
        representChild(value.`client-key-data`, childTagStyle, c)
    of ukBasic:
        representChild("username", childTagStyle, c)
        representChild(value.username, childTagStyle, c)
        representChild("password", childTagStyle, c)
        representChild(value.password, childTagStyle, c)
  c.put(endMapEvent())

setDefaultValue(Config, preferences, Table[string,string]())

proc load*(kubeconfig: string): Config =
    let s = newFileStream(kubeconfig)
    load(s, result)


proc server*(config: Config): string =
    let contexts = config.contexts.filter( (x) => x.name == config.`current-context` )
    if contexts.len != 1:
        raise newException(ValueError,"Invalid context " & config.`current-context`)
    let clusters = config.clusters.filter((x) => x.name == contexts[0].context.cluster)
    if clusters.len != 1:
        raise newException(ValueError,"Invalid cluster " & contexts[0].context.cluster)
    return clusters[0].cluster.server

when isMainModule: 
    let s = newStringStream("""
apiVersion: v1
kind: Config
clusters:
  - name: test-cluster
    cluster:
      server: 'https://localhost'
      certificate-authority-data: >-
        LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMyRENDQWNDZ0F3SUJBZ0lSQVBUb20xQTA4dU1Oa2VkQkcwZUZIWGN3RFFZSktvWklodmNOQVFFTEJRQXcKRlRFVE1CRUdBMVVFQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TURBek1qQXdOVEEwTVRkYUZ3MHpNREF6TWpBdwpOVEEwTVRkYU1CVXhFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBCkE0SUJEd0F3Z2dFS0FvSUJBUURDSjdmQ3pJSlZsemtrTUtobTQzY1drQUNEUUsyR0hreVFaVFVPMFBocjBqR1YKajljbS8wWk5NYlNTUEluNVhrU09WVWlJTE5ud054R2tWMnVDVmluMVB2ejRIS0xzMjArMTJGalQ5dzdjL2JrYQpNQWVzSnJKcEsyb1NtdUxHckdRdDNQcCtsVSt1bUNoRGw2R0wyQXBBUWwxSWxqOFlpRDBWMG9jZERFYnM0eFVLCldSejZmVjNVYnh0Q2ZWU0t0VGp5eGc1cXE0MHMxMkJ6U1BONDVOR0F0Q1VzVldVcVVEVmNyZWdYMkROQkJERWIKVDkxcjNML2p0NXFWS093RS9GSVZkQUFnZnV2VzA4Tm5zMCt6RGl5QzNJN3pHWnVsdTRMdUpRdzZTZDMvR2R2aQpaWFVNdmh5Mk9tWVM4UWN6YVNSU3dlbmxUMDRwQmdCYUN6d25JYktQQWdNQkFBR2pJekFoTUE0R0ExVWREd0VCCi93UUVBd0lCcGpBUEJnTlZIUk1CQWY4RUJUQURBUUgvTUEwR0NTcUdTSWIzRFFFQkN3VUFBNElCQVFBS2IvTTUKM1I3VlpLcGhXNG80QjI2R1ZPdXkxNU80b1pjRFhVTHRmdHFleEs3MnpSVzJ5R2luSXlqWHpGYmNsM1g4MmlGUwpJTUFsNUNvQ1Q3TWdzeGpnMUVtYUw4V0NXV3hib043MXJpVmwycWtUZHZZODJkQnM1ZmhYbzdTQmJGZUVwVGtPCkJhRTBmSUlJdUlsY3N6OEc5U2FOR3BSVkhkRThBWGsxeHVMcldiT0Q4dGFoOHZkMEdNRGZZdlBGOHZ2ZkJTc2MKVG9Oc0kvL3JMSHVveW9tZkVGRWhYYXZPRENVRTZtQkNrVEhHK045L09WY00rQ0dFazFiNFJuTWRqVHBja1pPRgpaYnoyZ1hmK2FZeFlVNWZwSWVqVlFqbEswbzF2RGJFSzVBdk4rK0YwOXR2amprdUJCdlNSb21wWXB3dmxkVkRNCi9qek0vbFQrTjRRa3p5SjYKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
contexts:
  - name: test-user
    context:
      cluster: test-cluster
      user: test-user-token
current-context: test-user
users:
  - name: test-user-token
    user:
      token: abc
  - name: test-user-basic-auth
    user:
      username: admin
      password: abc

    """)
    var config: Config
    load(s, config)
    doAssert(config.users.len == 2) 
    doAssert(config.users[0].user.kind == ukToken)
    doAssert(config.users[1].user.kind == ukBasic)
    doAssert(config.users[1].user.kind == ukBasic)
    doAssert(config.clusters.len == 1)
    doAssert(string(config.clusters[0].cluster.`certificate-authority-data`).startsWith("-----BEGIN CERTIFICATE-----"))
    doAssert(config.contexts.len == 1)
