module AST.Helpers where

import Syntax (Expr (..))
import SyntaxHelpers (joinedPrettyAST)

extractFuncRet :: Expr -> Maybe Expr
extractFuncRet (Function t n a r b) = case r of
  Nothing -> Nothing
  Just name -> Just $ Def t name

ppAST ast = putStrLn (joinedPrettyAST ast)
