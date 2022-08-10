{-# LANGUAGE ViewPatterns #-}

module StringHelpers where

import Data.ByteString (ByteString)
import Data.ByteString.Short (ShortByteString, toShort)
import Data.List (intercalate)

import qualified Data.ByteString as BS
import qualified Data.ByteString.UTF8 as BSU

show' :: Show a => a -> ByteString
show' = BSU.fromString . show

showShort :: Show a => a -> ShortByteString
showShort = toShort . show'

toShort' :: String -> ShortByteString
toShort' = toShort . BSU.fromString

addToLast :: [String] -> String -> [String]
addToLast [s] str = [s ++ str]
addToLast (reverse -> s : ss) str = reverse ss ++ [s ++ str]
addToLast [] _ = []
addToLast _ _ = []

joinS = unwords

joinN = intercalate "\n"

joinC = intercalate ", "
