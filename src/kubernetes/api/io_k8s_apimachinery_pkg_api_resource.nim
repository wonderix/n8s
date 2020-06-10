import ../client
import ../base_types
import parsejson

type
  Quantity* = distinct string
proc load*(self: var Quantity, parser: var JsonParser) =
  load(string(self),parser)
