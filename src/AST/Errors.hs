module AST.Errors where

class GError e where
  showE :: e -> String

newtype GTypeError = GTypeError String
  deriving (Show)

instance GError GTypeError where
  showE (GTypeError err) = "Type Error: <" ++ err ++ ">"
