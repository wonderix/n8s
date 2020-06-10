import ../client
import ../base_types
import parsejson
import streams

type
  Quantity* = distinct string

proc load*(self: var Quantity, parser: var JsonParser) =
  load(string(self),parser)

proc dump*(self: Quantity, s: Stream) =
  dump(string(self),s)

proc isEmpty*(self: Quantity): bool = string(self).isEmpty

type
  Quantity_v2* = distinct string

proc load*(self: var Quantity_v2, parser: var JsonParser) =
  load(string(self),parser)

proc dump*(self: Quantity_v2, s: Stream) =
  dump(string(self),s)

proc isEmpty*(self: Quantity_v2): bool = string(self).isEmpty
