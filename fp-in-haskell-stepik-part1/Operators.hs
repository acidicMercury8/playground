module Operators where

--infixr 8  ^, `logBase`
--infixl 7 *, /, `div`, `mod`
--infixl 6 +, -
--infix  4 ==, /=, >, >=, <, <=
--infixr 0 $

--2 ^ 3 ^ 2
--2 ^ 9
--512

--(*) 2 ((+) 1 4) ^ 2
--(2 * ((+) 1 4)) ^ 2
--(2 * (1 + 4)) ^ 2
--(2 * 5) ^ 2
--10 ^ 2
--100

{-
! # $ % & * + . / < = > ? @ \ ^ | - ~
-}

{-
:
-}

infixl 6 *+*

--(*+*) :: Num a => a -> a -> a
(*+*) a b = a ^ 2 + b ^ 2

--1 + 3 *+* 2 * 2
--4 *+* 2 * 2
--4 *+* 4
--32

--(|-|) :: (Ord a, Num a) => a -> a -> a
x |-| y = if x - y >= 0 then x - y else y - x

--(2 /) 4
--0.5

--(/ 2) 4
--2.0

--(`mod` 14) ((+ 5) 10)
--(`mod` 14) (5 + 10)
--(`mod` 14) 15
--mod 15 14
--1

--f $ x = f x
{- f (g x (h y)) == f $ g x (h y) == f $ g x $ h y -}

--logBase 4 (min 20 (9 + 7))
--logBase 4 $ min 20 $ 9 + 7
