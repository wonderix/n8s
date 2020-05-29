import yaml, base64

type 
    ByteArray* = distinct string

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

