{-# LANGUAGE ViewPatterns #-}

module StringHelpers where

import Data.ByteString (ByteString)
import Data.ByteString.Short (ShortByteString, toShort)
import Data.List (intercalate)
import Data.String (fromString)

import qualified Data.ByteString as BS

show' :: Show a => a -> ByteString
show' = fromString . show

showShort :: Show a => a -> ShortByteString
showShort = toShort . show'

toShort' :: String -> ShortByteString
toShort' = toShort . fromString

addToLast :: [String] -> String -> [String]
addToLast [s] str = [s ++ str]
addToLast (reverse -> s : ss) str = reverse ss ++ [s ++ str]
addToLast [] _ = []
addToLast _ _ = []

joinS :: [String] -> String
joinS = unwords

joinN :: [String] -> String
joinN = intercalate "\n"

joinC :: [String] -> String
joinC = intercalate ", "
