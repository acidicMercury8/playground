module Main where

import Lib (runIncrParse, runSumParse)

main :: IO ()
main = do
  putStrLn "Enter an expression like <integer_number_1>+<integer_number_2>"
  lineSum <- getLine
  case runSumParse lineSum of
    Right result -> putStrLn ("Result: " ++ show result)
    Left error -> print error
  putStrLn "Enter an expression like <integer_number>++"
  lineIncr <- getLine
  case runIncrParse lineIncr of
    Right result -> putStrLn ("Result: " ++ show result)
    Left error -> print error
