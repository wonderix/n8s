import ../client
import ../base_types
import parsejson
import ../jsonwriter

type
  Quantity* = distinct string

proc load*(self: var Quantity, parser: var JsonParser) =
  load(string(self),parser)

proc dump*(self: Quantity, s: JsonWriter) =
  dump(string(self),s)

proc isEmpty*(self: Quantity): bool = string(self).isEmpty
