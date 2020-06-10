import ../client
import ../base_types
import parsejson
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch

type
  Subject* = object
    `namespace`*: string
    `apiGroup`*: string
    `name`*: string
    `kind`*: string

proc load*(self: var Subject, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "namespace":
            load(self.`namespace`,parser)
          of "apiGroup":
            load(self.`apiGroup`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  RoleRef* = object
    `apiGroup`*: string
    `name`*: string
    `kind`*: string

proc load*(self: var RoleRef, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "apiGroup":
            load(self.`apiGroup`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  RoleBinding* = object
    `roleRef`*: RoleRef
    `apiVersion`*: string
    `subjects`*: seq[Subject]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var RoleBinding, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "roleRef":
            load(self.`roleRef`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "subjects":
            load(self.`subjects`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[RoleBinding], name: string, namespace = "default"): Future[RoleBinding] {.async.}=
  proc unmarshal(parser: var JsonParser):RoleBinding = 
    var ret: RoleBinding
    load(ret,parser)
    return ret 
  return await client.get("/apis/rbac.authorization.k8s.io/v1",t,name,namespace, unmarshal)

type
  ClusterRoleBinding* = object
    `roleRef`*: RoleRef
    `apiVersion`*: string
    `subjects`*: seq[Subject]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var ClusterRoleBinding, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "roleRef":
            load(self.`roleRef`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "subjects":
            load(self.`subjects`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[ClusterRoleBinding], name: string, namespace = "default"): Future[ClusterRoleBinding] {.async.}=
  proc unmarshal(parser: var JsonParser):ClusterRoleBinding = 
    var ret: ClusterRoleBinding
    load(ret,parser)
    return ret 
  return await client.get("/apis/rbac.authorization.k8s.io/v1",t,name,namespace, unmarshal)

type
  ClusterRoleBindingList* = object
    `apiVersion`*: string
    `items`*: seq[ClusterRoleBinding]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var ClusterRoleBindingList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "items":
            load(self.`items`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[ClusterRoleBindingList], name: string, namespace = "default"): Future[ClusterRoleBindingList] {.async.}=
  proc unmarshal(parser: var JsonParser):ClusterRoleBindingList = 
    var ret: ClusterRoleBindingList
    load(ret,parser)
    return ret 
  return await client.get("/apis/rbac.authorization.k8s.io/v1",t,name,namespace, unmarshal)

type
  PolicyRule* = object
    `resources`*: seq[string]
    `apiGroups`*: seq[string]
    `verbs`*: seq[string]
    `nonResourceURLs`*: seq[string]
    `resourceNames`*: seq[string]

proc load*(self: var PolicyRule, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "resources":
            load(self.`resources`,parser)
          of "apiGroups":
            load(self.`apiGroups`,parser)
          of "verbs":
            load(self.`verbs`,parser)
          of "nonResourceURLs":
            load(self.`nonResourceURLs`,parser)
          of "resourceNames":
            load(self.`resourceNames`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  RoleBindingList* = object
    `apiVersion`*: string
    `items`*: seq[RoleBinding]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var RoleBindingList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "items":
            load(self.`items`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[RoleBindingList], name: string, namespace = "default"): Future[RoleBindingList] {.async.}=
  proc unmarshal(parser: var JsonParser):RoleBindingList = 
    var ret: RoleBindingList
    load(ret,parser)
    return ret 
  return await client.get("/apis/rbac.authorization.k8s.io/v1",t,name,namespace, unmarshal)

type
  Role* = object
    `apiVersion`*: string
    `rules`*: seq[PolicyRule]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Role, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "rules":
            load(self.`rules`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[Role], name: string, namespace = "default"): Future[Role] {.async.}=
  proc unmarshal(parser: var JsonParser):Role = 
    var ret: Role
    load(ret,parser)
    return ret 
  return await client.get("/apis/rbac.authorization.k8s.io/v1",t,name,namespace, unmarshal)

type
  AggregationRule* = object
    `clusterRoleSelectors`*: seq[io_k8s_apimachinery_pkg_apis_meta_v1.LabelSelector]

proc load*(self: var AggregationRule, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "clusterRoleSelectors":
            load(self.`clusterRoleSelectors`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ClusterRole* = object
    `aggregationRule`*: AggregationRule
    `apiVersion`*: string
    `rules`*: seq[PolicyRule]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var ClusterRole, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "aggregationRule":
            load(self.`aggregationRule`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "rules":
            load(self.`rules`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[ClusterRole], name: string, namespace = "default"): Future[ClusterRole] {.async.}=
  proc unmarshal(parser: var JsonParser):ClusterRole = 
    var ret: ClusterRole
    load(ret,parser)
    return ret 
  return await client.get("/apis/rbac.authorization.k8s.io/v1",t,name,namespace, unmarshal)

type
  ClusterRoleList* = object
    `apiVersion`*: string
    `items`*: seq[ClusterRole]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var ClusterRoleList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "items":
            load(self.`items`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[ClusterRoleList], name: string, namespace = "default"): Future[ClusterRoleList] {.async.}=
  proc unmarshal(parser: var JsonParser):ClusterRoleList = 
    var ret: ClusterRoleList
    load(ret,parser)
    return ret 
  return await client.get("/apis/rbac.authorization.k8s.io/v1",t,name,namespace, unmarshal)

type
  RoleList* = object
    `apiVersion`*: string
    `items`*: seq[Role]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var RoleList, parser: var JsonParser) =
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        case key:
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "items":
            load(self.`items`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[RoleList], name: string, namespace = "default"): Future[RoleList] {.async.}=
  proc unmarshal(parser: var JsonParser):RoleList = 
    var ret: RoleList
    load(ret,parser)
    return ret 
  return await client.get("/apis/rbac.authorization.k8s.io/v1",t,name,namespace, unmarshal)
