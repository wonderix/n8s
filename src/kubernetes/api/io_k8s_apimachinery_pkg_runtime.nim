import ../client
import ../base_types
import parsejson
import streams
import tables

type
  RawExtension* = distinct Table[string,string]

proc load*(self: var RawExtension, parser: var JsonParser) =
  load(Table[string,string](self),parser)

proc dump*(self: RawExtension, s: Stream) =
  dump(Table[string,string](self),s)

proc isEmpty*(self: RawExtension): bool = Table[string,string](self).isEmpty

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

proc dump*(self: RawExtension_v2, s: Stream) =
  s.write("{")
  var firstIteration = true
  if not self.`Raw`.isEmpty:
    if not firstIteration:
      s.write(",")
    firstIteration = false
    s.write("\"Raw\":")
    self.`Raw`.dump(s)
  s.write("}")

proc isEmpty*(self: RawExtension_v2): bool =
  if not self.`Raw`.isEmpty: return false
  true
