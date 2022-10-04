{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Avoid lambda" #-}

module ParametricPolymorphism where

import Data.Function

-- > let id x = x
-- > :t id
-- ~ id :: t -> t
-- > id True
-- ~ True
-- > id 5
-- ~ 5
-- > (id id) 4
-- ~ 4
-- > :t id True
-- ~ id True :: Bool
-- > :t (id id)
-- ~ (id id) :: t -> t
-- > let k x y = x
-- > k 42 True
-- ~ 42
-- > k 42 55
-- ~ 42
-- > :t k
-- ~ k :: t1 -> t -> t1
-- > :t const
-- ~ const :: a -> b -> a
-- > :t const True
-- ~ const True :: b -> Bool
-- > undefined
-- ~ *** Exception: Prelude.indefined
-- > :t undefined
-- ~ undefined :: a
-- > error "AAA!!!!111"
-- ~ *** Exception: AAA!!!!111
-- > :t error "AAA!!!!111"
-- ~ error "AAA!!!!111" :: a
-- > :t error
-- ~ error :: [Char] -> a


-- >> getSecondFrom True 'x' "Hello"
-- ~ 'x'
-- > getSecondFrom 'x' 42 True
-- ~ 42

getSecondFrom :: a -> b -> c -> b
getSecondFrom first second third = second


mono :: Char -> Char
mono x = x

--semiMono :: Char -> a -> Char
--semiMono :: p1 -> p2 -> p1
semiMono x y = x

-- > :t semiMono
-- ~ semiMono :: t1 -> t -> t1

-- > :t ($)
-- ~ ($) :: (a -> b) -> a -> b

--apply2 :: (t -> t) -> t -> t
apply2 f x = f (f x)

-- > :t apply2
-- ~ apply2 :: (t -> t) -> t -> t
-- > apply2 (+5) 22
-- ~ 32
-- > apply2 (++ "AB") "CD"
-- ~ "CDABAB"

-- From standard library
-- flip f y x = f x y
-- > flip (/) 4 2
-- ~ 0.5
-- > (/) 4 2
-- ~ 2.0
-- > flip const 5 True
-- ~ True
-- > :t flip
-- ~ flip :: (a -> b -> c) -> b -> a -> c
-- > :t flip const
-- ~ flip const :: b -> c -> c


-- From standard library
-- on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
-- on op f x y = f x `op` f y

-- sumSquares = (+) `on` (^2)

--multSecond :: (a, Integer) -> (a, Integer) -> Integer
multSecond = g `on` h

--g :: Integer -> Integer -> Integer
g = (*)

--h :: (a, b) -> b
h = snd


-- > let f x = 2 * x + 7
-- > f 10
-- ~ 27
-- > (\x -> 2 * x + 7) 10
-- ~ 27
-- > let f' = \x -> 2 * x + 7
-- > f' 10
-- ~ 27
-- > let lenVec x y = sqrt $ x ^ 2 + y ^ 2
-- > let lenVec x = \y -> sqrt $ x ^ 2 + y ^ 2
-- > let lenVec = \x -> \y -> sqrt $ x ^ 2 + y ^ 2
-- > lenVec 3 4
-- ~ 5.0
-- > let lenVec = \x y -> sqrt $ x ^ 2 + y ^ 2
-- > lenVec 3 4
-- ~ 5.0
-- > let p1 = ((1, 2), (3, 4))
-- > let p2 = ((3, 4), (5, 6))
-- > let 
-- > fst $ fst p1
-- ~ 1

--sumFstFst :: ((Integer, b1), b2) -> ((Integer, b1), b2) -> Integer
sumFstFst = (+) `on` helper
  where
    helper pp = fst $ fst pp

-- > sumFstFst p1 p2
-- ~ 4

--sumFstFst' :: ((Integer, b1), b2) -> ((Integer, b1), b2) -> Integer
sumFstFst' = (+) `on` (\pp -> fst $ fst pp)


-- > let sum3squares = (\x y z -> x + y + z) `on3` (^2)
-- > sum3squares 1 2 3
-- ~ 14

on3 :: (b -> b -> b -> c) -> (a -> b) -> a -> a -> a -> c
on3 op f x y z = op (f x) (f y) (f z)
