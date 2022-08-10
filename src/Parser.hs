module Parser where

import Control.Applicative ( (<$>) )
import Data.Maybe ( fromMaybe )
import Text.Parsec ( (<|>), many, try, optionMaybe )
import Text.Parsec.String ( Parser )

import qualified Text.Parsec.Expr as Ex
import qualified Text.Parsec.Token as Tok

import Lexer
    ( integer,
      parens,
      braces,
      commaSep,
      identifier,
      whitespace,
      reserved,
      reservedOp,
      operator )
import Syntax
    ( ExprType(CallableType, IntType, FloatType, VoidType, BytesType,
               AutoType),
      Expr(..) )

op :: Parser String
op = do
  whitespace
  o <- operator
  whitespace
  return o

binary s assoc = Ex.Infix (reservedOp s >> return (BinaryOp s)) assoc

opList arity = opList'
  where
    opList' [op] = [arity op Ex.AssocLeft]
    opList' (op : ops) = arity op Ex.AssocLeft : opList' ops

binList = opList binary

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

variable :: Parser Expr
variable = Var <$> identifier

definition :: Parser Expr
definition = do
  varType <- exprType
  whitespace
  varName <- identifier
  return $ Def varType varName

codeBlock :: Parser [Expr]
codeBlock = braces $ many $
  do e <- expr
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
    id <- identifier
    return id
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
    code <- codeBlock
    return code
  return $ If cond tr (fromMaybe [] fl)
 
factor :: Parser Expr
factor = try block
      <|> try function
      <|> try int
      <|> try call
      <|> try definition
      <|> try variable
      <|> try ifelse
      <|> parens expr
