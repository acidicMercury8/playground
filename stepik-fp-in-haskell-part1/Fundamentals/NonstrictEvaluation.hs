{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant seq" #-}
{-# HLINT ignore "Redundant lambda" #-}
{-# HLINT ignore "Redundant $!" #-}

module NonstrictEvaluation where

sumIt :: Int -> Int -> Int
sumIt x y = x + y

-- > sumIt (1 + 2) 3
-- ~ 6
{-
sumIt (2 + 3) 4
(2 + 3) 4
5 + 4
9
-}
{-
sumIt (2 + 3) 4
sumIt 5 4
5 + 4
9
-}


--id x = x
--const x y = x
--max x y = if x <= y then y else x
--infixr 0 $
--f $ x = f x

--const $ const (4 + 5) $ max 42
-- 3


add7 :: Int -> Int -> Int
add7 x y = x + 7

{-
add7 1 (2 + 3)
1 + 7
8
-}
{-
add7 1 (2 + 3)
1 + 7
8
-}

dup :: Int -> (Int, Int)
dup x = (x, x)

{-
dup (2 + 3)
(2 + 3, 2 + 3)
(5, 2 + 3)
(5, 5)
-}
{-
dup (2 + 3)
dup 5
(5, 5)
-}


--bar x y z = x + y
--foo a b = bar a a (a + b)
--value = foo (3 * 10) (5 - 2)
-- 4


const42 :: a -> Int
const42 = const 42

-- > const42 True
-- ~ 42
-- > const42 (1 + 3)
-- ~ 42
-- > const42 undefined
-- ~ 42


--foo a = a
--bar = const foo
--baz x = const True
--quux = let x = x in x
--corge = "Sorry, my value was changed"
--grault x 0 = x
--grault x y = x
--garply = grault 'q'
--waldo = foo
-- baz
-- corge


{-
NF
42
(3, 4)
\x -> x + 2
-}
{-
Not NF
"Real "++ "world"
sin (pi / 2)
(\x -> x + 2) 5
(3, 1 + 5)
-}
{-
WHNF
\x -> x + 2 * 3
(3, 1 + 5)
(,) (4 * 5)
(+) (7 ^ 2)
-}


-- (+) (2 * 3 * 4)
-- (,) undefined
-- [undefined, 4 + 5, -1]


{-
seq :: a -> b -> b
seq _|_ b = _|_
seq a b = b
-}
-- > seq 1 2
-- ~ 2
-- > seq (undefined, undefined) 2
-- ~ 2
-- > seq (\x -> undefined) 2
-- ~ 2


foo 0 x = x
foo n x = let x' = foo (n - 1) (x + 1)
          in x' `seq` x'

bar 0 f = f
bar x f = let f' = \a -> f (x + a)
              x' = x - 1
          in f' `seq` x' `seq` bar x' f'

baz 0 (x, y) = x + y
baz n (x, y) = let x' = x + 1
                   y' = y - 1
                   p  = (x', y')
                   n' = n - 1
               in p `seq` n' `seq` baz n' p

quux 0 (x, y) = x + y
quux n (x, y) = let x' = x + 1
                    y' = y - 1
                    p  = (x', y')
                    n' = n - 1
                in x' `seq` y' `seq` n' `seq` quux n' p

-- quux


{-
($!) :: (a -> b) -> a -> b
f $! x = x `seq` f x
-}

-- > const 42 undefined
-- ~ 42
-- > const 42 $ undefined
-- ~ 42
-- > const 42 $! undefined
-- ~ Exception

factorial :: Integer -> Integer
factorial n | n >= 0 = helper 1 n
            | otherwise = error "arg must be >= 0"
  where
    helper acc 0 = acc
    helper acc n = (helper $! (acc * n)) (n - 1)


mySum acc 0 = acc
mySum (result, ()) n = (mySum $! (result + n, ())) $ n - 1

goSum = mySum (0, ())
