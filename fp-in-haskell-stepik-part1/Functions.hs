{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use guards" #-}
{-# HLINT ignore "Eta reduce" #-}

module Functions where

--(5 + 4 * 3) ^ 2
--(5 + 12) ^ 2
--17 ^ 2
--289

-- > acos (cos pi)
-- > max 5 42
-- > (max 5) 42
-- > 3 + sin 42
-- > 3 + (max 5) 42

--sumSquares :: Num a => a -> a -> a
sumSquares x y = x ^ 2 + y ^ 2

-- > let sumSquares x y = x ^ 2 + y ^ 2
-- > sumSquares 1 2


--lenVec3 :: Floating a => a -> a -> a -> a
lenVec3 x y z = sqrt (x ^ 2 + y ^ 2 + z ^ 2)


-- > let fortyTwo = 39 + 3
-- > fortyTwo

--f :: (Ord a, Num a, Num p) => a -> p
f x = if x > 0 then 1 else (-1)

-- > let f x = if x > 0 then 1 else (-1)
-- > f 5
-- > f (-5)

--g :: (Ord a1, Num a2, Num a1) => a1 -> a2
g x = (if x > 0 then 1 else (-1)) + 3

-- > let g x = (if x > 0 then 1 else (-1)) + 3
-- > g 5
-- > g (-7)


--sign :: (Ord a, Num a, Num p) => a -> p
sign x = if x > 0 then 1 else (if x < 0 then (-1) else 0)

--sign' :: (Ord a, Num a, Num p) => a -> p
sign' x
  | x > 0 = 1
  | x < 0 = -1
  | otherwise = 0


--max5 :: (Ord a, Num a) => a -> a
max5 x = max 5 x

-- > let max5 x = max 5 x
-- > max5 4
-- > max5 42

--max5' :: Integer -> Integer
max5' = max 5

-- > let max5' = max 5
-- > max5' 4
-- > max5' 42

--discount :: (Ord a, Fractional a) => a -> a -> a -> a
discount limit procent sum = if sum >= limit then sum * (100 - procent) / 100 else sum

--standardDiscount :: Double -> Double
standardDiscount = discount 1000 5

-- > let discount limit procent sum = if sum >= limit then sum * (100 - procent) / 100 else sum
-- > let standardDiscount = discount 1000 5
-- > standardDiscount 2000
-- > standardDiscount 900
