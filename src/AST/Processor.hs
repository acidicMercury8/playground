module AST.Processor where

import AST.Errors (GTypeError)
import AST.Helpers (extractFuncRet)
import AST.Typing (annotateTypes)
import Syntax (AST, Expr (..), TAST)

use [] x = x
use [f] x = f x
use (f : fs) x = use fs (f x)

processAST :: AST -> Either TAST [GTypeError]
processAST ast =
  annotateTypes $
    use
      [desugarFunctions]
      ast

walkAST :: (Expr -> Expr) -> AST -> AST
walkAST m = map (process m)

process :: (Expr -> Expr) -> Expr -> Expr
process m expr = m (process' m expr)

mapP m = map (process m)

process' m (Block codeBlock) = Block (walkAST m codeBlock)
process' m (Call name args) = Call name (mapP m args)
process' m (Function t n args r body) = Function t n (mapP m args) r (walkAST m body)
process' m (BinaryOp op e1 e2) = BinaryOp op (process m e1) (process m e2)
process' m (UnaryOp op e) = UnaryOp op (process m e)
process' m (If cond brT brF) = If (process m cond) (walkAST m brT) (walkAST m brF)
process' m e = e

desugarFunctions =
  walkAST
    ( \expr -> case expr of
        Function {} -> desugarFunc expr
        _ -> expr
    )

desugarFunc func@(Function t n a r body) =
  Function t n a Nothing $ case extractFuncRet func of
    Nothing -> body
    Just (Def t name) -> Def t name : body ++ [Var name]
