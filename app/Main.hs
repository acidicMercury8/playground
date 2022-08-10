module Main where

import System.Environment ( getArgs )

import Lib ( joinedPrettyAST, parseCode )

main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> putStrLn "Provide file name!"
    [filename] -> do
      code <- readFile filename
      case parseCode code of
        Left err -> print err
        Right ast -> putStrLn (joinedPrettyAST ast)
    _ -> putStrLn "Provide one file name!"
