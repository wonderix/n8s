import ../client
import ../base_types
import parsejson
import ../jsonstream

type
  Quantity* = distinct string

proc load*(self: var Quantity, parser: var JsonParser) =
  load(string(self),parser)

proc dump*(self: Quantity, s: JsonStream) =
  dump(string(self),s)

proc isEmpty*(self: Quantity): bool = string(self).isEmpty
