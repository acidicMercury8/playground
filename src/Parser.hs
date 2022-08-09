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

incrParse :: Parser Integer
incrParse = do
  first <- integer
  reservedOp "++"
  return (first + 1)

runSumParse = parse sumParse "<stdin>"

runIncrParse = parse incrParse "<stdin>"
