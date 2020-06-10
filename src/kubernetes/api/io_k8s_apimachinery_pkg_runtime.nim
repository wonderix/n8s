import ../client, ../base_types, sets, tables, options, times, asyncdispatch, parsejson, strutils, streams

type
  RawExtension* = distinct Table[string,string]
proc load*(self: var RawExtension, parser: var JsonParser) =
  load(Table[string,string](self),parser)
