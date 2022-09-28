{-# LANGUAGE ViewPatterns #-}

module Main where

import Data.List (intersect)
import Control.Monad (unless)
import System.Environment (getArgs)

import Lib
  ( joinN
  , parseCode
  , ppAST
  , processAST
  , showE
  )

debugFlag :: [String]
debugFlag = ["--debug", "-d"]

parseArgs :: [String] -> ([String], String)
parseArgs (reverse -> (filename : args)) = (args, filename)
parseArgs _ = ([], [])

main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> putStrLn "Provide file name!"
    args -> do
      code <- readFile filename
      case parseCode code of
        Left err -> print err
        Right ast -> do
          actionFor debugFlag (ppAST ast >> putStrLn "")
          let maybeTAST = processAST ast
          case maybeTAST of
            Right errors -> putStrLn $ joinN (map showE errors)
            Left tast -> ppAST tast
      return ()
      where
        actionFor key = unless (null (key `intersect` flags))
        (flags, filename) = parseArgs args
