import ../client
import ../base_types
import parsejson

type
  Info* = object
    `gitTreeState`*: string
    `gitVersion`*: string
    `platform`*: string
    `buildDate`*: string
    `major`*: string
    `goVersion`*: string
    `gitCommit`*: string
    `compiler`*: string
    `minor`*: string

proc load*(self: var Info, parser: var JsonParser) =
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
        case key:
          of "gitTreeState":
            load(self.`gitTreeState`,parser)
          of "gitVersion":
            load(self.`gitVersion`,parser)
          of "platform":
            load(self.`platform`,parser)
          of "buildDate":
            load(self.`buildDate`,parser)
          of "major":
            load(self.`major`,parser)
          of "goVersion":
            load(self.`goVersion`,parser)
          of "gitCommit":
            load(self.`gitCommit`,parser)
          of "compiler":
            load(self.`compiler`,parser)
          of "minor":
            load(self.`minor`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))
