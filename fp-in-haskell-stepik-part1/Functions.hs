{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use guards" #-}
{-# HLINT ignore "Eta reduce" #-}

module Functions where

--sumSquares :: Num a => a -> a -> a
sumSquares x y = x ^ 2 + y ^ 2


--lenVec3 :: Floating a => a -> a -> a -> a
lenVec3 x y z = sqrt (x ^ 2 + y ^ 2 + z ^ 2)


--f :: (Ord a, Num a, Num p) => a -> p
f x = if x > 0 then 1 else (-1)

--g :: (Ord a1, Num a2, Num a1) => a1 -> a2
g x = (if x > 0 then 1 else (-1)) + 3


--sign :: (Ord a, Num a, Num p) => a -> p
sign x = if x > 0 then 1 else (if x < 0 then (-1) else 0)

--sign' :: (Ord a, Num a, Num p) => a -> p
sign' x
  | x > 0 = 1
  | x < 0 = -1
  | otherwise = 0


--max5 :: (Ord a, Num a) => a -> a
max5 x = max 5 x

--max5' :: Integer -> Integer
max5' = max 5


--discount :: (Ord a, Fractional a) => a -> a -> a -> a
discount limit procent sum = if sum >= limit then sum * (100 - procent) / 100 else sum

--standardDiscount :: Double -> Double
standardDiscount = discount 1000 5
