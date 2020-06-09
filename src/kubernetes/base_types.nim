import yaml, base64, parsejson, times, tables

type 
    ByteArray* = distinct string
    IntOrStringKind* = enum 
        iosString,
        iosInt
    IntOrString* = object
        case kind: IntOrStringKind
        of iosString:
            svalue: string
        of iosInt:
            ivalue: int


setTagUri(ByteArray, "!string")

proc constructObject*( s: var YamlStream, c: ConstructionContext, result: var ByteArray)
    {.raises: [YamlConstructionError, YamlStreamError ].} =
  constructScalarItem(s, item, string):
    try:
      result = decode(item.scalarContent).ByteArray
    except ValueError:
      raise newException(YamlConstructionError,"error")

proc representObject*(value: ByteArray, ts: TagStyle, c: SerializationContext, tag: TagId) {.raises: [].} =
  ## represents an integer value as YAML scalar
  c.put(scalarEvent(encode(string(value)), tag, yAnchorNone))


proc load*(ios: var IntOrString,parser: var JsonParser )=
  case parser.kind:
    of jsonString:
      ios = IntOrString(kind:iosString,svalue:parser.str)
    of jsonInt:
      ios = IntOrString(kind:iosInt,ivalue:int(parser.getInt))
    else: raiseParseErr(parser,"string or int")
  parser.next

proc load*(bytes: var ByteArray, parser: var JsonParser )=
  if parser.kind != jsonString: raiseParseErr(parser,"string")
  bytes = decode(parser.str).ByteArray
  parser.next

proc load*(time: var DateTime, parser: var JsonParser )=
  if parser.kind != jsonString: raiseParseErr(parser,"string")
  time = parse(parser.str, """yyyy-MM-dd'T'HH:mm:ss'Z'""")
  parser.next

proc load*(value: var string, parser: var JsonParser )=
  if parser.kind != jsonString: raiseParseErr(parser,"string")
  value = parser.str
  parser.next

proc load*(value: var int,parser: var JsonParser )=
  if parser.kind != jsonInt: raiseParseErr(parser,"int")
  value = int(parser.getInt)
  parser.next

proc load*(value: var float,parser: var JsonParser )=
  if parser.kind != jsonFloat: raiseParseErr(parser,"float")
  value = parser.getFloat
  parser.next

proc load*(value: var bool,parser: var JsonParser )=
  case parser.kind:
    of jsonTrue:
      value = true
    of jsonFalse:
      value = false
    else: raiseParseErr(parser,"true or false")
  parser.next

proc load*[T](table: var Table[string,T],parser: var JsonParser )=
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        var item: T
        load(item, parser)
        table[key] = item
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc load*[T](sequence: var seq[T],parser: var JsonParser )=
  if parser.kind != jsonArrayStart: raiseParseErr(parser,"array start")
  parser.next
  while true:
    case parser.kind:
      of jsonArrayEnd:
        parser.next
        return
      else:
        var item: T
        load(item, parser)
        sequence.add(item)
