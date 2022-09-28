module AST.Helpers where

import Syntax (Expr (..), Pretty)
import SyntaxHelpers (joinedPrettyAST)

extractFuncRet :: Expr -> Maybe Expr
extractFuncRet (Function t n a r b) = case r of
  Nothing -> Nothing
  Just name -> Just $ Def t name

ppAST :: Pretty e => [e] -> IO ()
ppAST ast = putStrLn (joinedPrettyAST ast)
