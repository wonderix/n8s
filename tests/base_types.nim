import ../src/n8s/base_types
import json
import parsejson
import streams
import unittest

suite "n8s base types":
  test "load for JsonNode":
    var node: JsonNode
    var parser: JsonParser

    open(parser, newStringStream("""{ "a": "b","b": [ 1, 2.0, true]}"""), "")
    parser.next
    load(node,parser)
    doAssert node.kind == JObject
    doAssert node.len == 2
    doAssert node["a"].getStr == "b"
    let ary = node["b"]
    doAssert ary.kind == JArray
    doAssert ary.len == 3
    doAssert ary[0].getInt == 1
    doAssert ary[1].getFloat == 2.0
    doAssert ary[2].getBool == true

    parser.close()
