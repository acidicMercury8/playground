module BasicTypes where

import Data.Char

-- > :type 'c'
-- ~ 'c' :: Char
-- > :type '\n'
-- ~ '\n' :: Char
-- > :type True
-- ~ True :: Bool
-- > :t False
-- ~ False :: Bool

-- > :t 3
-- ~ 3 :: Num a => a
-- > let x = 3 :: Int
-- > x
-- ~ 3
-- > :type x
-- ~ x :: Int
-- > let y = 3 :: Double
-- > y
-- ~ 3.0
-- > :t y
-- ~ y :: Double
-- > let z = y + 17
-- > :t z
-- ~ z :: Double
-- > :t 3.5
-- ~ 3.5 :: Fractional a => a


-- (3.2 :: Double) + (5 :: Double)
-- (3 :: Integer) + (5 :: Integer)


-- > not False
-- ~ True
-- > :t not
-- ~ not :: Bool -> Bool
-- > (&&) False True
-- ~ False
-- > ((&&) False) True
-- ~ False
-- > :t (&&)
-- ~ (&&) :: Bool -> Bool -> Bool


discount :: Double -> Double -> Double -> Double
discount limit proc sum = if sum >= limit then sum * (100 - proc) / 100 else sum

standardDiscount :: Double -> Double
standardDiscount = discount 1000 5


--test :: Bool
test = isDigit '7'
-- > test
-- ~ True
-- > import Data.Complex


-- Char -> Char
-- toLower

twoDigits2Int :: Char -> Char -> Int
twoDigits2Int x y = if isDigit x && isDigit y then digitToInt x * 10 + digitToInt y else 100


-- > (2, True)
-- ~ (2, True)
-- > (2, True, 'c')
-- ~ (2, True, 'c')
-- > fst (2, True)
-- ~ 2
-- > snd (2, True)
-- ~ True
-- > :t ('x', True)
-- ~ ('x', True) :: (Char, Bool)
-- > :t ('x', True, 's')
-- ~ ('x', True, 's') :: (Char, Bool, Char)
-- > (3)
-- ~ 3
-- > ()
-- ~ ()
-- > :t ()
-- ~ () :: ()


dist :: (Double, Double) -> (Double, Double) -> Double
dist p1 p2 = sqrt $ (fst p1 - fst p2) ^ 2 + (snd p1 - snd p2) ^ 2


-- > [1, 2, 3]
-- > [False, True]
-- > :t [False, True]
-- ~ [False, True] :: [Bool]
-- > ['H', 'i']
-- ~ "Hi"
-- > :t ['H', 'i']
-- ~ ['H', 'i'] :: [Char]
-- > :t "Hi"
-- ~ "Hi" :: [Char]
-- > "Hi" :: String
-- ~ "Hi"

-- > let str = 'H' : "ello"
-- > str
-- ~ "Hello"
-- > str ++ " world"
-- ~ "Hello world"


-- > :i (:)
{-
type [] :: * -> *
data [] a = ... | a : [a]
infixr 5 :
-}
-- > :i (++)
{-
(++) :: [a] -> [a] -> [a]
infixr 5 ++
-}

-- > [1, 2] ++ 3 : [4, 5, 6]
-- > [1, 2] ++ (:) 3 [4, 5, 6]
-- > 1 : [2, 3] ++ [4, 5, 6]
-- > (:) 1 ((++) [2, 3] [4, 5, 6])
