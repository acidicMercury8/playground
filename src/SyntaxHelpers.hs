{-# LANGUAGE TypeSynonymInstances #-}

module SyntaxHelpers where

import Data.Char (isSpace)

import Syntax
  ( CodeBlock,
    Expr
      ( Int,
        Var,
        Def,
        Block,
        Call,
        Function,
        BinaryOp,
        If
      ),
    Pretty (prettify)
  )
import StringHelpers
  ( addToLast,
    joinS,
    joinN
  )

joinOrSplit :: Pretty a => [String] -> a -> [String]
joinOrSplit s e = case prettify e of
  [r] -> addToLast s (" (" ++ r ++ ")")
  listR -> addToLast s " (" ++ [" " ++ r' | r' <- listR] ++ [")"]

prettifyAST :: Pretty e => [e] -> [String]
prettifyAST = map (joinN . prettify)

joinedPrettyAST :: Pretty e => [e] -> String
joinedPrettyAST = joinN . prettifyAST

instance Pretty e => Pretty (CodeBlock e) where
  prettify exprs = concatMap tabExpr exprs
    where
      tabExpr e = map (" " ++) (prettify e)

smartJoin :: [String] -> [String]
smartJoin strs =
  if sum (map length strs) < 40
    then [joinS (map (dropWhile isSpace) strs)]
    else strs

instance Pretty Expr where
  prettify expr = case expr of
    (Int i) -> [joinS ["Int", show i]]
    (Var n) -> [joinS ["Var", show n]]
    (Def t n) -> [joinS ["Def", show t, show n]]
    (Block es) -> smartJoin ("Block {" : prettify es ++ ["}"])
    (Call f es) -> smartJoin (joinS ["Call", show f, "("] : prettify es ++ [")"])
    (Function t n a r body) ->
      joinS ["Function", show n, show t, "; args", show a, "; returns", show r, "{"] :
      prettify body ++ ["}"]
    (BinaryOp op e1 e2) -> joinOrSplit (joinOrSplit ["BinaryOp " ++ op] e1) e2
    (If eq bl1 bl2) -> addToLast (joinOrSplit ["If"] eq) " {" ++ prettify bl1 ++ ["}", "else {"] ++ prettify bl2 ++ ["}"]
