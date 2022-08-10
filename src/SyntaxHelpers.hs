{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE ViewPatterns #-}

module SyntaxHelpers where

import Data.Char ( isSpace )

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
    Pretty ( prettify ),
    TypedExpr ( TypedExpr ),
    TExpr
      ( TInt,
        TFloat,
        TVar,
        TDef,
        TBlock,
        TCall,
        TFunction,
        TBinaryOp,
        TUnaryOp,
        TIf,
        TWhile
      )
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
  prettify = concatMap tabExpr
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

typedTuple (TypedExpr type_ tExpr) = (show type_, tExpr)
tT = typedTuple

instance Pretty TypedExpr where
  prettify expr = case expr of
    (tT -> (t, TInt i)) -> [joinS [t, show i]]
    (tT -> (t, TFloat f)) -> [joinS [t, show f]]
    (tT -> (t, TVar v)) -> [joinS ["Var", t, show v]]
    (tT -> (t, TDef d)) -> [joinS ["Def", t, show d]]
    (tT -> (t, TBlock es)) -> smartJoin (joinS ["Block", t, "{"] : prettify es ++ ["}"])
    (tT -> (t, TCall f es)) -> smartJoin (joinS ["Call", t, show f, "("] : prettify es ++ [")"])
    (tT -> (t, TFunction n argN body)) ->
      joinS ["Function", t, n, show argN, "{"]
      : prettify body ++ ["}"]
    (tT -> (t, TBinaryOp op e1 e2)) -> joinOrSplit (joinOrSplit ["BinaryOp " ++ [head t] ++ op] e1) e2
    (tT -> (t, TUnaryOp op e)) -> joinOrSplit ["UnaryOp " ++ [head t] ++ op] e
    (tT -> (t, TIf eq bl1 bl2)) -> addToLast (joinOrSplit ["If " ++ t] eq) " {" ++ prettify bl1 ++ ["}", "else {"] ++ prettify bl2 ++ ["}"]
    (tT -> (t, TWhile eq bl)) -> addToLast (joinOrSplit ["While " ++ t] eq) " {" ++ prettify bl ++ ["}"]

view (TypedExpr t e) = (t, e)
typeOnly (TypedExpr t _) = t
exprOnly (TypedExpr _ e) = e
