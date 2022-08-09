module Lexer
  ( lexer,
  )
  where

import Text.Parsec (parse)
import Text.Parsec.Language (emptyDef)
import Text.Parsec.String (Parser)
import qualified Text.Parsec.Token as Tok

lexer :: Tok.TokenParser ()
lexer = Tok.makeTokenParser style
  where
    operators = ["+", "*", "-", "/"]
    names = ["if", "else"]
    style =
      emptyDef
        { Tok.commentLine = "//",
          Tok.commentStart = "/*",
          Tok.commentEnd = "*/",
          Tok.caseSensitive = True,
          Tok.reservedOpNames = operators,
          Tok.reservedNames = names
        }
