import ../client
import ../base_types
import parsejson

type
  IntOrString* = distinct base_types.IntOrString
proc load*(self: var IntOrString, parser: var JsonParser) =
  load(base_types.IntOrString(self),parser)
