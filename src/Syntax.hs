module Syntax where

import StringHelpers ( joinC )

type Name = String

type CodeBlock term = [term]

data ExprType
  = VoidType
  | IntType
  | FloatType
  | BytesType
  | BooleanType
  | CallableType [ExprType] ExprType
  | AutoType
  deriving (Eq, Ord)

instance Show ExprType where
  show VoidType = "void"
  show IntType = "int"
  show FloatType = "float"
  show BytesType = "bytes"
  show BooleanType = "bool"
  show (CallableType from to) = "(" ++ fromRepr ++ " -> " ++ show to ++ ")"
    where
      fromRepr = case from of
        [] -> "()"
        from' -> joinC (map show from')
  show AutoType = "auto"

data Expr
  = Int Integer
  | Var Name
  | Def ExprType Name
  | Block (CodeBlock Expr)
  | Call String [Expr]
  | Function ExprType Name [Expr] (Maybe Name) (CodeBlock Expr)
  | BinaryOp String Expr Expr
  | If Expr (CodeBlock Expr) (CodeBlock Expr)
  deriving (Eq, Ord, Show)

class Show e => Pretty e where
  prettify :: e -> [String]

data TypedExpr = TypedExpr ExprType TExpr
  deriving (Eq, Ord, Show)

data TExpr
  = TInt Integer
  | TFloat Double
  | TVar Name
  | TDef Name
  | TBlock (CodeBlock TypedExpr)
  | TCall String [TypedExpr]
  | TFunction Name [Name] (CodeBlock TypedExpr)
  | TBinaryOp String TypedExpr TypedExpr
  | TUnaryOp String TypedExpr
  | TIf TypedExpr (CodeBlock TypedExpr) (CodeBlock TypedExpr)
  | TWhile TypedExpr (CodeBlock TypedExpr)
  deriving (Eq, Ord, Show)

type AST = [Expr]

type TAST = [TypedExpr]
