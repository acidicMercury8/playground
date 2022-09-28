module Parser where

import Control.Applicative ((<$>))
import Data.Functor.Identity (Identity)
import Data.Maybe (fromMaybe)
import Text.Parsec (eof, many, optionMaybe, try, (<|>))
import Text.Parsec.String (Parser)

import qualified Text.Parsec.Expr as Ex
import qualified Text.Parsec.Token as Tok

import Lexer
  ( braces,
    commaSep,
    float,
    identifier,
    integer,
    lexer,
    operator,
    parens,
    reserved,
    reservedOp,
    whitespace,
  )
import Syntax (Expr (..), ExprType (..))

op :: Parser String
op = do
  whitespace
  o <- operator
  whitespace
  return o

binary :: String -> Ex.Assoc -> Ex.Operator String () Identity Expr
binary s = Ex.Infix (reservedOp s >> return (BinaryOp s))

opList :: (t -> Ex.Assoc -> a) -> [t] -> [a]
opList arity = opList'
  where
    opList' [op] = [arity op Ex.AssocLeft]
    opList' (op : ops) = arity op Ex.AssocLeft : opList' ops
    opList' [] = []

binList :: [String] -> [Ex.Operator String () Identity Expr]
binList = opList binary

binops :: [[Ex.Operator String () Identity Expr]]
binops =
  [ binList ["*", "/", "//", "%"],
    binList ["+", "-"],
    binList ["<", "=", "<=", ">=", "==", "!="]
  ]

expr :: Parser Expr
expr = Ex.buildExpressionParser binops factor

exprType :: Parser ExprType
exprType =
  try
    ( do
        typeID <- identifier
        return $ case typeID of
          "int" -> IntType
          "float" -> FloatType
          "void" -> VoidType
          "bytes" -> BytesType
          "auto" -> AutoType
    )
    <|> try
      ( parens $ do
          fromTypes <- commaSep exprType
          reserved "->"
          CallableType fromTypes <$> exprType
      )

int :: Parser Expr
int = Int <$> integer

floating :: Parser Expr
floating = Float <$> float

variable :: Parser Expr
variable = Var <$> identifier

definition :: Parser Expr
definition = do
  varType <- exprType
  whitespace
  Def varType <$> identifier

codeBlock :: Parser [Expr]
codeBlock = braces $
  many $
    do
      e <- expr
      reserved ";"
      return e

block :: Parser Expr
block = Block <$> codeBlock

function :: Parser Expr
function = do
  funcType <- exprType
  name <- identifier
  args <- parens $ commaSep definition
  mReturns <- optionMaybe $ do
    reserved "returns"
    identifier
  body <- do
    reserved "="
    block <- optionMaybe codeBlock
    case block of
      Just codeBlock -> return codeBlock
      Nothing -> do
        e <- expr
        return [e]
  return $ Function funcType name args mReturns body

call :: Parser Expr
call = do
  name <- identifier
  args <- parens $ commaSep expr
  return $ Call name args

ifelse :: Parser Expr
ifelse = do
  reserved "if"
  cond <- parens expr
  tr <- codeBlock
  fl <- optionMaybe $ do
    reserved "else"
    codeBlock
  return $ If cond tr (fromMaybe [] fl)

while :: Parser Expr
while = do
  reserved "while"
  cond <- parens expr
  While cond <$> codeBlock

cast :: Parser Expr
cast = do
  castedT <- parens exprType
  TypeCast castedT <$> expr

factor :: Parser Expr
factor =
  try cast
    <|> try block
    <|> try function
    <|> try floating
    <|> try int
    <|> try call
    <|> try definition
    <|> try variable
    <|> try ifelse
    <|> try while
    <|> parens expr

contents :: Parser a -> Parser a
contents p = do
  Tok.whiteSpace lexer
  r <- p
  eof
  return r

toplevel :: Parser [Expr]
toplevel = many $ do
  def <- function
  reservedOp ";"
  return def
