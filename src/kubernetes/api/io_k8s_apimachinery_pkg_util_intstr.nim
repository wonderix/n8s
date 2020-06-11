import ../client
import ../base_types
import parsejson
import ../jsonstream

type
  IntOrString* = distinct base_types.IntOrString

proc load*(self: var IntOrString, parser: var JsonParser) =
  load(base_types.IntOrString(self),parser)

proc dump*(self: IntOrString, s: JsonStream) =
  dump(base_types.IntOrString(self),s)

proc isEmpty*(self: IntOrString): bool = base_types.IntOrString(self).isEmpty
