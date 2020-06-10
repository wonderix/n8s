import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams
import io_k8s_apimachinery_pkg_apis_meta_v1

type
  CustomResourceColumnDefinition* = object
    `format`*: string
    `type`*: string
    `priority`*: int
    `JSONPath`*: string
    `description`*: string
    `name`*: string

proc load*(self: var CustomResourceColumnDefinition, parser: var JsonParser) =
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
          of "format":
            load(self.`format`,parser)
          of "type":
            load(self.`type`,parser)
          of "priority":
            load(self.`priority`,parser)
          of "JSONPath":
            load(self.`JSONPath`,parser)
          of "description":
            load(self.`description`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CustomResourceSubresourceScale* = object
    `specReplicasPath`*: string
    `labelSelectorPath`*: string
    `statusReplicasPath`*: string

proc load*(self: var CustomResourceSubresourceScale, parser: var JsonParser) =
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
          of "specReplicasPath":
            load(self.`specReplicasPath`,parser)
          of "labelSelectorPath":
            load(self.`labelSelectorPath`,parser)
          of "statusReplicasPath":
            load(self.`statusReplicasPath`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CustomResourceSubresourceStatus* = distinct Table[string,string]
proc load*(self: var CustomResourceSubresourceStatus, parser: var JsonParser) =
  load(Table[string,string](self),parser)

type
  CustomResourceSubresources* = object
    `scale`*: CustomResourceSubresourceScale
    `status`*: CustomResourceSubresourceStatus

proc load*(self: var CustomResourceSubresources, parser: var JsonParser) =
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
          of "scale":
            load(self.`scale`,parser)
          of "status":
            load(self.`status`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  JSON* = distinct string
proc load*(self: var JSON, parser: var JsonParser) =
  load(string(self),parser)

type
  JSONSchemaPropsOrArray* = distinct string
proc load*(self: var JSONSchemaPropsOrArray, parser: var JsonParser) =
  load(string(self),parser)

type
  ExternalDocumentation* = object
    `url`*: string
    `description`*: string

proc load*(self: var ExternalDocumentation, parser: var JsonParser) =
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
          of "url":
            load(self.`url`,parser)
          of "description":
            load(self.`description`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  JSONSchemaPropsOrBool* = distinct string
proc load*(self: var JSONSchemaPropsOrBool, parser: var JsonParser) =
  load(string(self),parser)

type
  JSONSchemaProps* = object
    `maxLength`*: int
    `definitions`*: Table[string,JSONSchemaProps]
    `properties`*: Table[string,JSONSchemaProps]
    `example`*: JSON
    `nullable`*: bool
    `enum`*: seq[JSON]
    `exclusiveMinimum`*: bool
    `format`*: string
    `multipleOf`*: 
    `x-kubernetes-list-map-keys`*: seq[string]
    `type`*: string
    `allOf`*: seq[JSONSchemaProps]
    `x-kubernetes-embedded-resource`*: bool
    `minProperties`*: int
    `items`*: JSONSchemaPropsOrArray
    `externalDocs`*: ExternalDocumentation
    `patternProperties`*: Table[string,JSONSchemaProps]
    `default`*: JSON
    `required`*: seq[string]
    `id`*: string
    `dependencies`*: Table[string,JSONSchemaPropsOrStringArray]
    `minimum`*: 
    `$schema`*: string
    `maxProperties`*: int
    `minLength`*: int
    `additionalItems`*: JSONSchemaPropsOrBool
    `oneOf`*: seq[JSONSchemaProps]
    `uniqueItems`*: bool
    `maximum`*: 
    `x-kubernetes-list-type`*: string
    `description`*: string
    `exclusiveMaximum`*: bool
    `x-kubernetes-preserve-unknown-fields`*: bool
    `additionalProperties`*: JSONSchemaPropsOrBool
    `pattern`*: string
    `maxItems`*: int
    `not`*: JSONSchemaProps
    `$ref`*: string
    `title`*: string
    `x-kubernetes-int-or-string`*: bool
    `anyOf`*: seq[JSONSchemaProps]
    `minItems`*: int

proc load*(self: var JSONSchemaProps, parser: var JsonParser) =
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
          of "maxLength":
            load(self.`maxLength`,parser)
          of "definitions":
            load(self.`definitions`,parser)
          of "properties":
            load(self.`properties`,parser)
          of "example":
            load(self.`example`,parser)
          of "nullable":
            load(self.`nullable`,parser)
          of "enum":
            load(self.`enum`,parser)
          of "exclusiveMinimum":
            load(self.`exclusiveMinimum`,parser)
          of "format":
            load(self.`format`,parser)
          of "multipleOf":
            load(self.`multipleOf`,parser)
          of "x-kubernetes-list-map-keys":
            load(self.`x-kubernetes-list-map-keys`,parser)
          of "type":
            load(self.`type`,parser)
          of "allOf":
            load(self.`allOf`,parser)
          of "x-kubernetes-embedded-resource":
            load(self.`x-kubernetes-embedded-resource`,parser)
          of "minProperties":
            load(self.`minProperties`,parser)
          of "items":
            load(self.`items`,parser)
          of "externalDocs":
            load(self.`externalDocs`,parser)
          of "patternProperties":
            load(self.`patternProperties`,parser)
          of "default":
            load(self.`default`,parser)
          of "required":
            load(self.`required`,parser)
          of "id":
            load(self.`id`,parser)
          of "dependencies":
            load(self.`dependencies`,parser)
          of "minimum":
            load(self.`minimum`,parser)
          of "$schema":
            load(self.`$schema`,parser)
          of "maxProperties":
            load(self.`maxProperties`,parser)
          of "minLength":
            load(self.`minLength`,parser)
          of "additionalItems":
            load(self.`additionalItems`,parser)
          of "oneOf":
            load(self.`oneOf`,parser)
          of "uniqueItems":
            load(self.`uniqueItems`,parser)
          of "maximum":
            load(self.`maximum`,parser)
          of "x-kubernetes-list-type":
            load(self.`x-kubernetes-list-type`,parser)
          of "description":
            load(self.`description`,parser)
          of "exclusiveMaximum":
            load(self.`exclusiveMaximum`,parser)
          of "x-kubernetes-preserve-unknown-fields":
            load(self.`x-kubernetes-preserve-unknown-fields`,parser)
          of "additionalProperties":
            load(self.`additionalProperties`,parser)
          of "pattern":
            load(self.`pattern`,parser)
          of "maxItems":
            load(self.`maxItems`,parser)
          of "not":
            load(self.`not`,parser)
          of "$ref":
            load(self.`$ref`,parser)
          of "title":
            load(self.`title`,parser)
          of "x-kubernetes-int-or-string":
            load(self.`x-kubernetes-int-or-string`,parser)
          of "anyOf":
            load(self.`anyOf`,parser)
          of "minItems":
            load(self.`minItems`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CustomResourceValidation* = object
    `openAPIV3Schema`*: JSONSchemaProps

proc load*(self: var CustomResourceValidation, parser: var JsonParser) =
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
          of "openAPIV3Schema":
            load(self.`openAPIV3Schema`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CustomResourceDefinitionVersion* = object
    `served`*: bool
    `additionalPrinterColumns`*: seq[CustomResourceColumnDefinition]
    `storage`*: bool
    `subresources`*: CustomResourceSubresources
    `name`*: string
    `schema`*: CustomResourceValidation

proc load*(self: var CustomResourceDefinitionVersion, parser: var JsonParser) =
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
          of "served":
            load(self.`served`,parser)
          of "additionalPrinterColumns":
            load(self.`additionalPrinterColumns`,parser)
          of "storage":
            load(self.`storage`,parser)
          of "subresources":
            load(self.`subresources`,parser)
          of "name":
            load(self.`name`,parser)
          of "schema":
            load(self.`schema`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  ServiceReference* = object
    `path`*: string
    `namespace`*: string
    `port`*: int
    `name`*: string

proc load*(self: var ServiceReference, parser: var JsonParser) =
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
          of "path":
            load(self.`path`,parser)
          of "namespace":
            load(self.`namespace`,parser)
          of "port":
            load(self.`port`,parser)
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  WebhookClientConfig* = object
    `caBundle`*: ByteArray
    `url`*: string
    `service`*: ServiceReference

proc load*(self: var WebhookClientConfig, parser: var JsonParser) =
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
          of "caBundle":
            load(self.`caBundle`,parser)
          of "url":
            load(self.`url`,parser)
          of "service":
            load(self.`service`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CustomResourceConversion* = object
    `strategy`*: string
    `webhookClientConfig`*: WebhookClientConfig
    `conversionReviewVersions`*: seq[string]

proc load*(self: var CustomResourceConversion, parser: var JsonParser) =
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
          of "strategy":
            load(self.`strategy`,parser)
          of "webhookClientConfig":
            load(self.`webhookClientConfig`,parser)
          of "conversionReviewVersions":
            load(self.`conversionReviewVersions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  JSONSchemaPropsOrStringArray* = distinct string
proc load*(self: var JSONSchemaPropsOrStringArray, parser: var JsonParser) =
  load(string(self),parser)

type
  CustomResourceDefinitionNames* = object
    `shortNames`*: seq[string]
    `categories`*: seq[string]
    `plural`*: string
    `singular`*: string
    `listKind`*: string
    `kind`*: string

proc load*(self: var CustomResourceDefinitionNames, parser: var JsonParser) =
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
          of "shortNames":
            load(self.`shortNames`,parser)
          of "categories":
            load(self.`categories`,parser)
          of "plural":
            load(self.`plural`,parser)
          of "singular":
            load(self.`singular`,parser)
          of "listKind":
            load(self.`listKind`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CustomResourceDefinitionCondition* = object
    `lastTransitionTime`*: io_k8s_apimachinery_pkg_apis_meta_v1.Time
    `type`*: string
    `message`*: string
    `reason`*: string
    `status`*: string

proc load*(self: var CustomResourceDefinitionCondition, parser: var JsonParser) =
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
          of "lastTransitionTime":
            load(self.`lastTransitionTime`,parser)
          of "type":
            load(self.`type`,parser)
          of "message":
            load(self.`message`,parser)
          of "reason":
            load(self.`reason`,parser)
          of "status":
            load(self.`status`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CustomResourceDefinitionStatus* = object
    `storedVersions`*: seq[string]
    `acceptedNames`*: CustomResourceDefinitionNames
    `conditions`*: seq[CustomResourceDefinitionCondition]

proc load*(self: var CustomResourceDefinitionStatus, parser: var JsonParser) =
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
          of "storedVersions":
            load(self.`storedVersions`,parser)
          of "acceptedNames":
            load(self.`acceptedNames`,parser)
          of "conditions":
            load(self.`conditions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CustomResourceDefinitionSpec* = object
    `version`*: string
    `names`*: CustomResourceDefinitionNames
    `additionalPrinterColumns`*: seq[CustomResourceColumnDefinition]
    `group`*: string
    `subresources`*: CustomResourceSubresources
    `versions`*: seq[CustomResourceDefinitionVersion]
    `validation`*: CustomResourceValidation
    `preserveUnknownFields`*: bool
    `scope`*: string
    `conversion`*: CustomResourceConversion

proc load*(self: var CustomResourceDefinitionSpec, parser: var JsonParser) =
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
          of "version":
            load(self.`version`,parser)
          of "names":
            load(self.`names`,parser)
          of "additionalPrinterColumns":
            load(self.`additionalPrinterColumns`,parser)
          of "group":
            load(self.`group`,parser)
          of "subresources":
            load(self.`subresources`,parser)
          of "versions":
            load(self.`versions`,parser)
          of "validation":
            load(self.`validation`,parser)
          of "preserveUnknownFields":
            load(self.`preserveUnknownFields`,parser)
          of "scope":
            load(self.`scope`,parser)
          of "conversion":
            load(self.`conversion`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

type
  CustomResourceDefinition* = object
    `apiVersion`*: string
    `spec`*: CustomResourceDefinitionSpec
    `status`*: CustomResourceDefinitionStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var CustomResourceDefinition, parser: var JsonParser) =
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
          of "spec":
            load(self.`spec`,parser)
          of "status":
            load(self.`status`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc get*(client: Client, t: typedesc[CustomResourceDefinition], name: string, namespace = "default"): Future[CustomResourceDefinition] {.async.}=
  proc unmarshal(parser: var JsonParser):CustomResourceDefinition = 
    var ret: CustomResourceDefinition
    load(ret,parser)
    return ret 
  return await client.get("/apis/apiextensions.k8s.io/v1beta1",t,name,namespace, unmarshal)

type
  CustomResourceDefinitionList* = object
    `apiVersion`*: string
    `items`*: seq[CustomResourceDefinition]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var CustomResourceDefinitionList, parser: var JsonParser) =
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

proc get*(client: Client, t: typedesc[CustomResourceDefinitionList], name: string, namespace = "default"): Future[CustomResourceDefinitionList] {.async.}=
  proc unmarshal(parser: var JsonParser):CustomResourceDefinitionList = 
    var ret: CustomResourceDefinitionList
    load(ret,parser)
    return ret 
  return await client.get("/apis/apiextensions.k8s.io/v1beta1",t,name,namespace, unmarshal)
