import streams, json

type
  JsonWriter* = ref object
   stream: owned Stream
   seperator: char

proc newJsonWriter*(stream: owned Stream): JsonWriter = JsonWriter(stream: stream, seperator: ' ')

proc newJsonWriter*(file: File): JsonWriter =  JsonWriter(stream: newFileStream(file), seperator: ' ')

proc objectStart*(j: JsonWriter) =
  j.stream.write(j.seperator)
  j.seperator = '{'

proc objectEnd*(j: JsonWriter) =
  j.stream.write('}')
  j.seperator = ','

proc arrayStart*(j: JsonWriter) =
  j.stream.write(j.seperator)
  j.seperator = '['

proc arrayEnd*(j: JsonWriter) =
  j.stream.write(']')
  j.seperator = ','

proc name*(j: JsonWriter, name: string) =
  j.stream.write(j.seperator)
  j.stream.write(escapeJson(name))
  j.seperator = ':'

proc value*(j: JsonWriter, v: string) =
  j.stream.write(j.seperator)
  j.stream.write(escapeJson(v))
  j.seperator = ','

proc value*(j: JsonWriter, v: int) =
  j.stream.write(j.seperator)
  var buffer: string
  buffer.addInt(v)
  j.stream.write(buffer)
  j.seperator = ','

proc value*(j: JsonWriter, v: float) =
  j.stream.write(j.seperator)
  var buffer: string
  buffer.addFloat(v)
  j.stream.write(buffer)
  j.seperator = ','

proc value*(j: JsonWriter, v: bool) =
  j.stream.write(j.seperator)
  if v:
    j.stream.write("true")
  else:
    j.stream.write("false")
  j.seperator = ','

proc null*(j: JsonWriter) =
  j.stream.write(j.seperator)
  j.stream.write("null")
  j.seperator = ','
 
