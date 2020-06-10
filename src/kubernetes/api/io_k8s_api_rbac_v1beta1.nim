import ../client
import ../base_types
import parsejson
import streams
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch

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

proc dump*(self: PolicyRule, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`resources`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resources\":")
    self.`resources`.dump(s)
  if not self.`apiGroups`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiGroups\":")
    self.`apiGroups`.dump(s)
  if not self.`verbs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"verbs\":")
    self.`verbs`.dump(s)
  if not self.`nonResourceURLs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nonResourceURLs\":")
    self.`nonResourceURLs`.dump(s)
  if not self.`resourceNames`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"resourceNames\":")
    self.`resourceNames`.dump(s)
  s.write("}")

proc isEmpty*(self: PolicyRule): bool =
  if not self.`resources`.isEmpty: return false
  if not self.`apiGroups`.isEmpty: return false
  if not self.`verbs`.isEmpty: return false
  if not self.`nonResourceURLs`.isEmpty: return false
  if not self.`resourceNames`.isEmpty: return false
  true

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

proc dump*(self: Role, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`rules`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rules\":")
    self.`rules`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: Role): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`rules`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadRole(parser: var JsonParser):Role = 
  var ret: Role
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[Role], name: string, namespace = "default"): Future[Role] {.async.}=
  return await client.get("/apis/rbac.authorization.k8s.io/v1beta1", t, name, namespace, loadRole)

proc create*(client: Client, t: Role, namespace = "default"): Future[Role] {.async.}=
  t.apiVersion = "/apis/rbac.authorization.k8s.io/v1beta1"
  t.kind = "Role"
  return await client.get("/apis/rbac.authorization.k8s.io/v1beta1", t, name, namespace, loadRole)

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

proc dump*(self: RoleList, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: RoleList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadRoleList(parser: var JsonParser):RoleList = 
  var ret: RoleList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[Role], namespace = "default"): Future[seq[Role]] {.async.}=
  return (await client.list("/apis/rbac.authorization.k8s.io/v1beta1", RoleList, namespace, loadRoleList)).items

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

proc dump*(self: AggregationRule, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`clusterRoleSelectors`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"clusterRoleSelectors\":")
    self.`clusterRoleSelectors`.dump(s)
  s.write("}")

proc isEmpty*(self: AggregationRule): bool =
  if not self.`clusterRoleSelectors`.isEmpty: return false
  true

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

proc dump*(self: ClusterRole, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`aggregationRule`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"aggregationRule\":")
    self.`aggregationRule`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`rules`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"rules\":")
    self.`rules`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: ClusterRole): bool =
  if not self.`aggregationRule`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`rules`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadClusterRole(parser: var JsonParser):ClusterRole = 
  var ret: ClusterRole
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[ClusterRole], name: string, namespace = "default"): Future[ClusterRole] {.async.}=
  return await client.get("/apis/rbac.authorization.k8s.io/v1beta1", t, name, namespace, loadClusterRole)

proc create*(client: Client, t: ClusterRole, namespace = "default"): Future[ClusterRole] {.async.}=
  t.apiVersion = "/apis/rbac.authorization.k8s.io/v1beta1"
  t.kind = "ClusterRole"
  return await client.get("/apis/rbac.authorization.k8s.io/v1beta1", t, name, namespace, loadClusterRole)

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

proc dump*(self: ClusterRoleList, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: ClusterRoleList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadClusterRoleList(parser: var JsonParser):ClusterRoleList = 
  var ret: ClusterRoleList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[ClusterRole], namespace = "default"): Future[seq[ClusterRole]] {.async.}=
  return (await client.list("/apis/rbac.authorization.k8s.io/v1beta1", ClusterRoleList, namespace, loadClusterRoleList)).items

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

proc dump*(self: RoleRef, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiGroup`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiGroup\":")
    self.`apiGroup`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  s.write("}")

proc isEmpty*(self: RoleRef): bool =
  if not self.`apiGroup`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

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

proc dump*(self: Subject, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`namespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespace\":")
    self.`namespace`.dump(s)
  if not self.`apiGroup`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiGroup\":")
    self.`apiGroup`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  s.write("}")

proc isEmpty*(self: Subject): bool =
  if not self.`namespace`.isEmpty: return false
  if not self.`apiGroup`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

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

proc dump*(self: ClusterRoleBinding, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`roleRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"roleRef\":")
    self.`roleRef`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`subjects`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"subjects\":")
    self.`subjects`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: ClusterRoleBinding): bool =
  if not self.`roleRef`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`subjects`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadClusterRoleBinding(parser: var JsonParser):ClusterRoleBinding = 
  var ret: ClusterRoleBinding
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[ClusterRoleBinding], name: string, namespace = "default"): Future[ClusterRoleBinding] {.async.}=
  return await client.get("/apis/rbac.authorization.k8s.io/v1beta1", t, name, namespace, loadClusterRoleBinding)

proc create*(client: Client, t: ClusterRoleBinding, namespace = "default"): Future[ClusterRoleBinding] {.async.}=
  t.apiVersion = "/apis/rbac.authorization.k8s.io/v1beta1"
  t.kind = "ClusterRoleBinding"
  return await client.get("/apis/rbac.authorization.k8s.io/v1beta1", t, name, namespace, loadClusterRoleBinding)

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

proc dump*(self: RoleBinding, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`roleRef`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"roleRef\":")
    self.`roleRef`.dump(s)
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`subjects`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"subjects\":")
    self.`subjects`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: RoleBinding): bool =
  if not self.`roleRef`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`subjects`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadRoleBinding(parser: var JsonParser):RoleBinding = 
  var ret: RoleBinding
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[RoleBinding], name: string, namespace = "default"): Future[RoleBinding] {.async.}=
  return await client.get("/apis/rbac.authorization.k8s.io/v1beta1", t, name, namespace, loadRoleBinding)

proc create*(client: Client, t: RoleBinding, namespace = "default"): Future[RoleBinding] {.async.}=
  t.apiVersion = "/apis/rbac.authorization.k8s.io/v1beta1"
  t.kind = "RoleBinding"
  return await client.get("/apis/rbac.authorization.k8s.io/v1beta1", t, name, namespace, loadRoleBinding)

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

proc dump*(self: ClusterRoleBindingList, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: ClusterRoleBindingList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadClusterRoleBindingList(parser: var JsonParser):ClusterRoleBindingList = 
  var ret: ClusterRoleBindingList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[ClusterRoleBinding], namespace = "default"): Future[seq[ClusterRoleBinding]] {.async.}=
  return (await client.list("/apis/rbac.authorization.k8s.io/v1beta1", ClusterRoleBindingList, namespace, loadClusterRoleBindingList)).items

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

proc dump*(self: RoleBindingList, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  if not self.`metadata`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"metadata\":")
    self.`metadata`.dump(s)
  s.write("}")

proc isEmpty*(self: RoleBindingList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadRoleBindingList(parser: var JsonParser):RoleBindingList = 
  var ret: RoleBindingList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[RoleBinding], namespace = "default"): Future[seq[RoleBinding]] {.async.}=
  return (await client.list("/apis/rbac.authorization.k8s.io/v1beta1", RoleBindingList, namespace, loadRoleBindingList)).items
