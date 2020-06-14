import streams, json

type
  JsonStream* = ref object
   stream: owned Stream
   commaRequired: bool

proc newJsonStream*(stream: owned Stream): JsonStream = JsonStream(stream: stream, commaRequired: false)

proc newJsonStream*(file: File): JsonStream =  JsonStream(stream: newFileStream(file), commaRequired: false)

proc objectStart*(j: JsonStream) =
  if j.commaRequired:
    j.stream.write(",")
  j.stream.write("{")
  j.commaRequired = false

proc objectEnd*(j: JsonStream) =
  j.stream.write("}")
  j.commaRequired = true

proc arrayStart*(j: JsonStream) =
  if j.commaRequired:
    j.stream.write(",")
  j.stream.write("[")
  j.commaRequired = false

proc arrayEnd*(j: JsonStream) =
  j.stream.write("]")
  j.commaRequired = true

proc name*(j: JsonStream, name: string) =
  if j.commaRequired:
    j.stream.write(",")
  j.stream.write(escapeJson(name))
  j.stream.write(":")
  j.commaRequired = false

proc value*(j: JsonStream, v: string) =
  if j.commaRequired:
    j.stream.write(",")
  j.stream.write(escapeJson(v))
  j.commaRequired = true


proc value*(j: JsonStream, v: int) =
  if j.commaRequired:
    j.stream.write(",")
  var buffer: string
  buffer.addInt(v)
  j.stream.write(buffer)
  j.commaRequired = true

proc value*(j: JsonStream, v: float) =
  if j.commaRequired:
    j.stream.write(",")
  var buffer: string
  buffer.addFloat(v)
  j.stream.write(buffer)
  j.commaRequired = true

proc value*(j: JsonStream, v: bool) =
  if j.commaRequired:
    j.stream.write(",")
  if v:
    j.stream.write("true")
  else:
    j.stream.write("false")
  j.commaRequired = true

proc null*(j: JsonStream) =
  if j.commaRequired:
    j.stream.write(",")
  j.stream.write("null")
  j.commaRequired = true
 
