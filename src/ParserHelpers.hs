module ParserHelpers where

import Text.Parsec (ParseError, parse)

import Parser (expr, contents, toplevel)
import Syntax (Expr, AST)

parseExpr :: String -> Either ParseError Expr
parseExpr = parse (contents expr) "<stdin>"

parseCode :: String -> Either ParseError AST
parseCode = parse (contents toplevel) "<stdin>"
