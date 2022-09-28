module Lexer where

import Data.Functor.Identity (Identity)
import Text.Parsec.Language (emptyDef)
import Text.Parsec.Prim (many, ParsecT)
import Text.Parsec.String (Parser)

import qualified Text.Parsec.Token as Tok

lexer :: Tok.TokenParser ()
lexer = Tok.makeTokenParser style
  where
    ops =
      [ "+", "*", "-", "/"
      , "//", "%"
      , "<", ">", ">=", "<=", "==", "!="
      , ";", "=", ",", "->"
      ]
    names =
      [ "if", "else"
      , "while", "for"
      , "returns"
      , "@target", "@args"
      ]
    style =
      emptyDef
        { Tok.commentLine = "//"
        , Tok.commentStart = "/*"
        , Tok.commentEnd = "*/"
        , Tok.caseSensitive = True
        , Tok.reservedOpNames = ops
        , Tok.reservedNames = names
        }

integer :: ParsecT String () Identity Integer
integer = Tok.integer lexer

float :: ParsecT String () Identity Double
float = Tok.float lexer

parens :: ParsecT String () Identity a -> ParsecT String () Identity a
parens = Tok.parens lexer

braces :: ParsecT String () Identity a -> ParsecT String () Identity a
braces = Tok.braces lexer

commaSep :: ParsecT String () Identity a -> ParsecT String () Identity [a]
commaSep = Tok.commaSep lexer

semiSep :: ParsecT String () Identity a -> ParsecT String () Identity [a]
semiSep = Tok.semiSep lexer

identifier :: ParsecT String () Identity String
identifier = Tok.identifier lexer

whitespace :: ParsecT String () Identity ()
whitespace = Tok.whiteSpace lexer

reserved :: String -> ParsecT String () Identity ()
reserved = Tok.reserved lexer

reservedOp :: String -> ParsecT String () Identity ()
reservedOp = Tok.reservedOp lexer

operator :: Parser String
operator = do
  c <- Tok.opStart emptyDef
  cs <- many $ Tok.opLetter emptyDef
  return (c : cs)
