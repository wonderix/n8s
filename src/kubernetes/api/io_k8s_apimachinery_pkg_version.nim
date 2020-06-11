import ../client
import ../base_types
import parsejson
import ../jsonstream

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

proc dump*(self: Info, s: JsonStream) =
  s.objectStart()
  if not self.`gitTreeState`.isEmpty:
    s.name("gitTreeState")
    self.`gitTreeState`.dump(s)
  if not self.`gitVersion`.isEmpty:
    s.name("gitVersion")
    self.`gitVersion`.dump(s)
  if not self.`platform`.isEmpty:
    s.name("platform")
    self.`platform`.dump(s)
  if not self.`buildDate`.isEmpty:
    s.name("buildDate")
    self.`buildDate`.dump(s)
  if not self.`major`.isEmpty:
    s.name("major")
    self.`major`.dump(s)
  if not self.`goVersion`.isEmpty:
    s.name("goVersion")
    self.`goVersion`.dump(s)
  if not self.`gitCommit`.isEmpty:
    s.name("gitCommit")
    self.`gitCommit`.dump(s)
  if not self.`compiler`.isEmpty:
    s.name("compiler")
    self.`compiler`.dump(s)
  if not self.`minor`.isEmpty:
    s.name("minor")
    self.`minor`.dump(s)
  s.objectEnd()

proc isEmpty*(self: Info): bool =
  if not self.`gitTreeState`.isEmpty: return false
  if not self.`gitVersion`.isEmpty: return false
  if not self.`platform`.isEmpty: return false
  if not self.`buildDate`.isEmpty: return false
  if not self.`major`.isEmpty: return false
  if not self.`goVersion`.isEmpty: return false
  if not self.`gitCommit`.isEmpty: return false
  if not self.`compiler`.isEmpty: return false
  if not self.`minor`.isEmpty: return false
  true
