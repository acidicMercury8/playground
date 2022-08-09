module Main where

import Lib (runSumParse)

main :: IO ()
main = do
  line <- getLine
  case runSumParse line of
    Right result -> putStrLn ("Result: " ++ show result)
    Left error -> print error
