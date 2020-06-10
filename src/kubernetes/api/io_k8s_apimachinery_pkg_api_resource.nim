import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams

type
  Quantity* = distinct string
proc load*(self: var Quantity, parser: var JsonParser) =
  load(string(self),parser)

type
  Quantity_v2* = distinct string
proc load*(self: var Quantity_v2, parser: var JsonParser) =
  load(string(self),parser)
