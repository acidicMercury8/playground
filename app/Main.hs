module Main where

import Lib (runIncrParse, runSumParse)

main :: IO ()
main = do
  lineSum <- getLine
  case runSumParse lineSum of
    Right result -> putStrLn ("Result: " ++ show result)
    Left error -> print error
  lineIncr <- getLine
  case runIncrParse lineIncr of
    Right result -> putStrLn ("Result: " ++ show result)
    Left error -> print error
