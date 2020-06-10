import ../client
import ../base_types
import parsejson
import streams
import tables
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch

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

proc dump*(self: CustomResourceColumnDefinition, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`format`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"format\":")
    self.`format`.dump(s)
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`priority`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"priority\":")
    self.`priority`.dump(s)
  if not self.`JSONPath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"JSONPath\":")
    self.`JSONPath`.dump(s)
  if not self.`description`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"description\":")
    self.`description`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: CustomResourceColumnDefinition): bool =
  if not self.`format`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`priority`.isEmpty: return false
  if not self.`JSONPath`.isEmpty: return false
  if not self.`description`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: CustomResourceSubresourceScale, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`specReplicasPath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"specReplicasPath\":")
    self.`specReplicasPath`.dump(s)
  if not self.`labelSelectorPath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"labelSelectorPath\":")
    self.`labelSelectorPath`.dump(s)
  if not self.`statusReplicasPath`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"statusReplicasPath\":")
    self.`statusReplicasPath`.dump(s)
  s.write("}")

proc isEmpty*(self: CustomResourceSubresourceScale): bool =
  if not self.`specReplicasPath`.isEmpty: return false
  if not self.`labelSelectorPath`.isEmpty: return false
  if not self.`statusReplicasPath`.isEmpty: return false
  true

type
  CustomResourceSubresourceStatus* = distinct Table[string,string]

proc load*(self: var CustomResourceSubresourceStatus, parser: var JsonParser) =
  load(Table[string,string](self),parser)

proc dump*(self: CustomResourceSubresourceStatus, s: Stream) =
  dump(Table[string,string](self),s)

proc isEmpty*(self: CustomResourceSubresourceStatus): bool = Table[string,string](self).isEmpty

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

proc dump*(self: CustomResourceSubresources, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`scale`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"scale\":")
    self.`scale`.dump(s)
  if not self.`status`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"status\":")
    self.`status`.dump(s)
  s.write("}")

proc isEmpty*(self: CustomResourceSubresources): bool =
  if not self.`scale`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

type
  JSON* = distinct string

proc load*(self: var JSON, parser: var JsonParser) =
  load(string(self),parser)

proc dump*(self: JSON, s: Stream) =
  dump(string(self),s)

proc isEmpty*(self: JSON): bool = string(self).isEmpty

type
  JSONSchemaPropsOrArray* = distinct string

proc load*(self: var JSONSchemaPropsOrArray, parser: var JsonParser) =
  load(string(self),parser)

proc dump*(self: JSONSchemaPropsOrArray, s: Stream) =
  dump(string(self),s)

proc isEmpty*(self: JSONSchemaPropsOrArray): bool = string(self).isEmpty

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

proc dump*(self: ExternalDocumentation, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`url`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"url\":")
    self.`url`.dump(s)
  if not self.`description`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"description\":")
    self.`description`.dump(s)
  s.write("}")

proc isEmpty*(self: ExternalDocumentation): bool =
  if not self.`url`.isEmpty: return false
  if not self.`description`.isEmpty: return false
  true

type
  JSONSchemaPropsOrBool* = distinct string

proc load*(self: var JSONSchemaPropsOrBool, parser: var JsonParser) =
  load(string(self),parser)

proc dump*(self: JSONSchemaPropsOrBool, s: Stream) =
  dump(string(self),s)

proc isEmpty*(self: JSONSchemaPropsOrBool): bool = string(self).isEmpty

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

proc dump*(self: JSONSchemaProps, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`maxLength`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"maxLength\":")
    self.`maxLength`.dump(s)
  if not self.`definitions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"definitions\":")
    self.`definitions`.dump(s)
  if not self.`properties`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"properties\":")
    self.`properties`.dump(s)
  if not self.`example`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"example\":")
    self.`example`.dump(s)
  if not self.`nullable`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"nullable\":")
    self.`nullable`.dump(s)
  if not self.`enum`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"enum\":")
    self.`enum`.dump(s)
  if not self.`exclusiveMinimum`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"exclusiveMinimum\":")
    self.`exclusiveMinimum`.dump(s)
  if not self.`format`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"format\":")
    self.`format`.dump(s)
  if not self.`multipleOf`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"multipleOf\":")
    self.`multipleOf`.dump(s)
  if not self.`x-kubernetes-list-map-keys`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"x-kubernetes-list-map-keys\":")
    self.`x-kubernetes-list-map-keys`.dump(s)
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`allOf`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"allOf\":")
    self.`allOf`.dump(s)
  if not self.`x-kubernetes-embedded-resource`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"x-kubernetes-embedded-resource\":")
    self.`x-kubernetes-embedded-resource`.dump(s)
  if not self.`minProperties`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"minProperties\":")
    self.`minProperties`.dump(s)
  if not self.`items`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"items\":")
    self.`items`.dump(s)
  if not self.`externalDocs`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"externalDocs\":")
    self.`externalDocs`.dump(s)
  if not self.`patternProperties`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"patternProperties\":")
    self.`patternProperties`.dump(s)
  if not self.`default`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"default\":")
    self.`default`.dump(s)
  if not self.`required`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"required\":")
    self.`required`.dump(s)
  if not self.`id`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"id\":")
    self.`id`.dump(s)
  if not self.`dependencies`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"dependencies\":")
    self.`dependencies`.dump(s)
  if not self.`minimum`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"minimum\":")
    self.`minimum`.dump(s)
  if not self.`$schema`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"$schema\":")
    self.`$schema`.dump(s)
  if not self.`maxProperties`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"maxProperties\":")
    self.`maxProperties`.dump(s)
  if not self.`minLength`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"minLength\":")
    self.`minLength`.dump(s)
  if not self.`additionalItems`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"additionalItems\":")
    self.`additionalItems`.dump(s)
  if not self.`oneOf`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"oneOf\":")
    self.`oneOf`.dump(s)
  if not self.`uniqueItems`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"uniqueItems\":")
    self.`uniqueItems`.dump(s)
  if not self.`maximum`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"maximum\":")
    self.`maximum`.dump(s)
  if not self.`x-kubernetes-list-type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"x-kubernetes-list-type\":")
    self.`x-kubernetes-list-type`.dump(s)
  if not self.`description`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"description\":")
    self.`description`.dump(s)
  if not self.`exclusiveMaximum`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"exclusiveMaximum\":")
    self.`exclusiveMaximum`.dump(s)
  if not self.`x-kubernetes-preserve-unknown-fields`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"x-kubernetes-preserve-unknown-fields\":")
    self.`x-kubernetes-preserve-unknown-fields`.dump(s)
  if not self.`additionalProperties`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"additionalProperties\":")
    self.`additionalProperties`.dump(s)
  if not self.`pattern`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"pattern\":")
    self.`pattern`.dump(s)
  if not self.`maxItems`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"maxItems\":")
    self.`maxItems`.dump(s)
  if not self.`not`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"not\":")
    self.`not`.dump(s)
  if not self.`$ref`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"$ref\":")
    self.`$ref`.dump(s)
  if not self.`title`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"title\":")
    self.`title`.dump(s)
  if not self.`x-kubernetes-int-or-string`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"x-kubernetes-int-or-string\":")
    self.`x-kubernetes-int-or-string`.dump(s)
  if not self.`anyOf`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"anyOf\":")
    self.`anyOf`.dump(s)
  if not self.`minItems`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"minItems\":")
    self.`minItems`.dump(s)
  s.write("}")

proc isEmpty*(self: JSONSchemaProps): bool =
  if not self.`maxLength`.isEmpty: return false
  if not self.`definitions`.isEmpty: return false
  if not self.`properties`.isEmpty: return false
  if not self.`example`.isEmpty: return false
  if not self.`nullable`.isEmpty: return false
  if not self.`enum`.isEmpty: return false
  if not self.`exclusiveMinimum`.isEmpty: return false
  if not self.`format`.isEmpty: return false
  if not self.`multipleOf`.isEmpty: return false
  if not self.`x-kubernetes-list-map-keys`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`allOf`.isEmpty: return false
  if not self.`x-kubernetes-embedded-resource`.isEmpty: return false
  if not self.`minProperties`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`externalDocs`.isEmpty: return false
  if not self.`patternProperties`.isEmpty: return false
  if not self.`default`.isEmpty: return false
  if not self.`required`.isEmpty: return false
  if not self.`id`.isEmpty: return false
  if not self.`dependencies`.isEmpty: return false
  if not self.`minimum`.isEmpty: return false
  if not self.`$schema`.isEmpty: return false
  if not self.`maxProperties`.isEmpty: return false
  if not self.`minLength`.isEmpty: return false
  if not self.`additionalItems`.isEmpty: return false
  if not self.`oneOf`.isEmpty: return false
  if not self.`uniqueItems`.isEmpty: return false
  if not self.`maximum`.isEmpty: return false
  if not self.`x-kubernetes-list-type`.isEmpty: return false
  if not self.`description`.isEmpty: return false
  if not self.`exclusiveMaximum`.isEmpty: return false
  if not self.`x-kubernetes-preserve-unknown-fields`.isEmpty: return false
  if not self.`additionalProperties`.isEmpty: return false
  if not self.`pattern`.isEmpty: return false
  if not self.`maxItems`.isEmpty: return false
  if not self.`not`.isEmpty: return false
  if not self.`$ref`.isEmpty: return false
  if not self.`title`.isEmpty: return false
  if not self.`x-kubernetes-int-or-string`.isEmpty: return false
  if not self.`anyOf`.isEmpty: return false
  if not self.`minItems`.isEmpty: return false
  true

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

proc dump*(self: CustomResourceValidation, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`openAPIV3Schema`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"openAPIV3Schema\":")
    self.`openAPIV3Schema`.dump(s)
  s.write("}")

proc isEmpty*(self: CustomResourceValidation): bool =
  if not self.`openAPIV3Schema`.isEmpty: return false
  true

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

proc dump*(self: CustomResourceDefinitionVersion, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`served`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"served\":")
    self.`served`.dump(s)
  if not self.`additionalPrinterColumns`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"additionalPrinterColumns\":")
    self.`additionalPrinterColumns`.dump(s)
  if not self.`storage`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"storage\":")
    self.`storage`.dump(s)
  if not self.`subresources`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"subresources\":")
    self.`subresources`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  if not self.`schema`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"schema\":")
    self.`schema`.dump(s)
  s.write("}")

proc isEmpty*(self: CustomResourceDefinitionVersion): bool =
  if not self.`served`.isEmpty: return false
  if not self.`additionalPrinterColumns`.isEmpty: return false
  if not self.`storage`.isEmpty: return false
  if not self.`subresources`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`schema`.isEmpty: return false
  true

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

proc dump*(self: ServiceReference, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`path`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"path\":")
    self.`path`.dump(s)
  if not self.`namespace`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"namespace\":")
    self.`namespace`.dump(s)
  if not self.`port`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"port\":")
    self.`port`.dump(s)
  if not self.`name`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"name\":")
    self.`name`.dump(s)
  s.write("}")

proc isEmpty*(self: ServiceReference): bool =
  if not self.`path`.isEmpty: return false
  if not self.`namespace`.isEmpty: return false
  if not self.`port`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  true

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

proc dump*(self: WebhookClientConfig, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`caBundle`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"caBundle\":")
    self.`caBundle`.dump(s)
  if not self.`url`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"url\":")
    self.`url`.dump(s)
  if not self.`service`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"service\":")
    self.`service`.dump(s)
  s.write("}")

proc isEmpty*(self: WebhookClientConfig): bool =
  if not self.`caBundle`.isEmpty: return false
  if not self.`url`.isEmpty: return false
  if not self.`service`.isEmpty: return false
  true

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

proc dump*(self: CustomResourceConversion, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`strategy`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"strategy\":")
    self.`strategy`.dump(s)
  if not self.`webhookClientConfig`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"webhookClientConfig\":")
    self.`webhookClientConfig`.dump(s)
  if not self.`conversionReviewVersions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conversionReviewVersions\":")
    self.`conversionReviewVersions`.dump(s)
  s.write("}")

proc isEmpty*(self: CustomResourceConversion): bool =
  if not self.`strategy`.isEmpty: return false
  if not self.`webhookClientConfig`.isEmpty: return false
  if not self.`conversionReviewVersions`.isEmpty: return false
  true

type
  JSONSchemaPropsOrStringArray* = distinct string

proc load*(self: var JSONSchemaPropsOrStringArray, parser: var JsonParser) =
  load(string(self),parser)

proc dump*(self: JSONSchemaPropsOrStringArray, s: Stream) =
  dump(string(self),s)

proc isEmpty*(self: JSONSchemaPropsOrStringArray): bool = string(self).isEmpty

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

proc dump*(self: CustomResourceDefinitionNames, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`shortNames`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"shortNames\":")
    self.`shortNames`.dump(s)
  if not self.`categories`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"categories\":")
    self.`categories`.dump(s)
  if not self.`plural`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"plural\":")
    self.`plural`.dump(s)
  if not self.`singular`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"singular\":")
    self.`singular`.dump(s)
  if not self.`listKind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"listKind\":")
    self.`listKind`.dump(s)
  if not self.`kind`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"kind\":")
    self.`kind`.dump(s)
  s.write("}")

proc isEmpty*(self: CustomResourceDefinitionNames): bool =
  if not self.`shortNames`.isEmpty: return false
  if not self.`categories`.isEmpty: return false
  if not self.`plural`.isEmpty: return false
  if not self.`singular`.isEmpty: return false
  if not self.`listKind`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

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

proc dump*(self: CustomResourceDefinitionCondition, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`lastTransitionTime`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"lastTransitionTime\":")
    self.`lastTransitionTime`.dump(s)
  if not self.`type`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"type\":")
    self.`type`.dump(s)
  if not self.`message`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"message\":")
    self.`message`.dump(s)
  if not self.`reason`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"reason\":")
    self.`reason`.dump(s)
  if not self.`status`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"status\":")
    self.`status`.dump(s)
  s.write("}")

proc isEmpty*(self: CustomResourceDefinitionCondition): bool =
  if not self.`lastTransitionTime`.isEmpty: return false
  if not self.`type`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  true

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

proc dump*(self: CustomResourceDefinitionStatus, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`storedVersions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"storedVersions\":")
    self.`storedVersions`.dump(s)
  if not self.`acceptedNames`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"acceptedNames\":")
    self.`acceptedNames`.dump(s)
  if not self.`conditions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conditions\":")
    self.`conditions`.dump(s)
  s.write("}")

proc isEmpty*(self: CustomResourceDefinitionStatus): bool =
  if not self.`storedVersions`.isEmpty: return false
  if not self.`acceptedNames`.isEmpty: return false
  if not self.`conditions`.isEmpty: return false
  true

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

proc dump*(self: CustomResourceDefinitionSpec, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`version`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"version\":")
    self.`version`.dump(s)
  if not self.`names`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"names\":")
    self.`names`.dump(s)
  if not self.`additionalPrinterColumns`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"additionalPrinterColumns\":")
    self.`additionalPrinterColumns`.dump(s)
  if not self.`group`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"group\":")
    self.`group`.dump(s)
  if not self.`subresources`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"subresources\":")
    self.`subresources`.dump(s)
  if not self.`versions`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"versions\":")
    self.`versions`.dump(s)
  if not self.`validation`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"validation\":")
    self.`validation`.dump(s)
  if not self.`preserveUnknownFields`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"preserveUnknownFields\":")
    self.`preserveUnknownFields`.dump(s)
  if not self.`scope`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"scope\":")
    self.`scope`.dump(s)
  if not self.`conversion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"conversion\":")
    self.`conversion`.dump(s)
  s.write("}")

proc isEmpty*(self: CustomResourceDefinitionSpec): bool =
  if not self.`version`.isEmpty: return false
  if not self.`names`.isEmpty: return false
  if not self.`additionalPrinterColumns`.isEmpty: return false
  if not self.`group`.isEmpty: return false
  if not self.`subresources`.isEmpty: return false
  if not self.`versions`.isEmpty: return false
  if not self.`validation`.isEmpty: return false
  if not self.`preserveUnknownFields`.isEmpty: return false
  if not self.`scope`.isEmpty: return false
  if not self.`conversion`.isEmpty: return false
  true

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

proc dump*(self: CustomResourceDefinition, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`apiVersion`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"apiVersion\":")
    self.`apiVersion`.dump(s)
  if not self.`spec`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"spec\":")
    self.`spec`.dump(s)
  if not self.`status`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"status\":")
    self.`status`.dump(s)
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

proc isEmpty*(self: CustomResourceDefinition): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadCustomResourceDefinition(parser: var JsonParser):CustomResourceDefinition = 
  var ret: CustomResourceDefinition
  load(ret,parser)
  return ret 

proc get*(client: Client, t: typedesc[CustomResourceDefinition], name: string, namespace = "default"): Future[CustomResourceDefinition] {.async.}=
  return await client.get("/apis/apiextensions.k8s.io/v1beta1", t, name, namespace, loadCustomResourceDefinition)

proc create*(client: Client, t: CustomResourceDefinition, namespace = "default"): Future[CustomResourceDefinition] {.async.}=
  t.apiVersion = "/apis/apiextensions.k8s.io/v1beta1"
  t.kind = "CustomResourceDefinition"
  return await client.get("/apis/apiextensions.k8s.io/v1beta1", t, name, namespace, loadCustomResourceDefinition)

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

proc dump*(self: CustomResourceDefinitionList, s: Stream) =
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

proc isEmpty*(self: CustomResourceDefinitionList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true

proc loadCustomResourceDefinitionList(parser: var JsonParser):CustomResourceDefinitionList = 
  var ret: CustomResourceDefinitionList
  load(ret,parser)
  return ret 

proc list*(client: Client, t: typedesc[CustomResourceDefinition], namespace = "default"): Future[seq[CustomResourceDefinition]] {.async.}=
  return (await client.list("/apis/apiextensions.k8s.io/v1beta1", CustomResourceDefinitionList, namespace, loadCustomResourceDefinitionList)).items
