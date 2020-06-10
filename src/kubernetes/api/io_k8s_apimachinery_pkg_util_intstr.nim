import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams

type
  IntOrString* = distinct base_types.IntOrString
proc load*(self: var IntOrString, parser: var JsonParser) =
  load(base_types.IntOrString(self),parser)
