module Parser where

import Text.Parsec (parse)
import Text.Parsec.String (Parser)

import Lexer (integer, reservedOp)

sumParse :: Parser Integer
sumParse = do
  first <- integer
  reservedOp "+"
  second <- integer
  return (first + second)

runSumParse = parse sumParse "<stdin>"
