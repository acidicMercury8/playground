{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use uncurry" #-}

module ParametricPolymorphism2 where

import Data.Function

-- > f :: b -> c
-- > g :: a -> b
-- > x :: a
-- > f (g x) :: c
-- > \x -> f (g x) :: a -> c

-- > let compose f g = \x -> f (g x)
-- > :t compose
-- ~ compose :: (t1 -> t) -> (t2 -> t1) -> t2 -> t
-- > :i (.)
-- ~ (.) :: (b -> c) -> (a -> b) -> a -> c
-- ~ infixr 9 .

--sumFstFst'' :: ((Integer, b1), b2) -> ((Integer, b1), b2) -> Integer
sumFstFst'' = (+) `on` (fst . fst)

{-
doIt x = f (g (h x)) = f ((g . h) x) = (f . (g . h)) x
doIt = f . (g . x)
-}


--doItYourself :: Double -> Double
doItYourself = f . g . h

--h :: Double -> Double
h = max 42

--g :: Double -> Double
g = (^3)

--f :: Double -> Double
f = logBase 2


-- > :t [True, False]
-- ~ [True, False] :: [Bool]
-- > :t "aqaqa"
-- ~ "aqaqa" :: [Char]
-- > :t []
-- ~ [] :: [a]
-- > :t (++)
-- ~ (++) :: [a] -> [a] -> [a]
-- > :t (:)
-- ~ (:) :: a -> [a] -> [a]
-- > (True, 3)
-- ~ (True, 3)
-- > (,) True 3
-- ~ (True, 3)
-- > (,,) True 3 'c'
-- ~ (True, 3, 'c')
-- > :t (,)
-- ~ (,) :: a -> b -> (a, b)
-- > :t (,,)
-- ~ (,,) :: a -> b -> c -> (a, b, c)
-- > :t (,) True 'c'
-- ~ (,) True 'c' :: (Bool, Char)
-- > let dup x = (x, x)
-- > :t dup
-- ~ dup :: t -> (t, t)
-- > :t fst
-- ~ fst :: (a, b) -> a
-- > :t snd
-- snd :: (a, b) -> b

-- > fst (1, 2)
-- ~ 1
-- > :t on
-- ~ on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
-- > :t curry fst `on` (^2)
-- ~ curry fst `on` (^2) :: Num c => c -> c -> c

avg :: (Double, Double) -> Double
avg p = (fst p + snd p) / 2

-- > :t curry avg `on` (^2)
-- ~ curry avg `on` (^2) :: Double -> Double -> Double
-- > let cur f x y = f (x, y)
-- > :t cur
-- ~ cur :: ((t1, t2) -> t) -> t1 -> t2 -> t
-- > :t curry
-- ~ curry :: ((a, b) -> c) -> a -> b -> c
-- > :t uncurry
-- ~ uncurry :: (a -> b -> c) -> (a, b) -> c


-- curry uncurry flip (,) const

swap :: (a, b) -> (b, a)
swap = f (g h)
  where
    f = uncurry
    g = flip
    h = (,)

-- uncurry,flip,(,)
