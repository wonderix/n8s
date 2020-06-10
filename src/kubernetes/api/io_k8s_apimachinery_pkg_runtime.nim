import ../client
import ../base_types
import parsejson
import tables

type
  RawExtension* = distinct Table[string,string]
proc load*(self: var RawExtension, parser: var JsonParser) =
  load(Table[string,string](self),parser)

type
  RawExtension_v2* = object
    `Raw`*: ByteArray

proc load*(self: var RawExtension_v2, parser: var JsonParser) =
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
          of "Raw":
            load(self.`Raw`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))
