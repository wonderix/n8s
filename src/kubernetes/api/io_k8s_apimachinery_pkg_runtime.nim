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
