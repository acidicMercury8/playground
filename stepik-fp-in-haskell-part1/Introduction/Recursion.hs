{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Recursion where

--factorial :: (Eq p, Num p) => p -> p
factorial n = if n == 0 then 1 else n * factorial (n - 1)

{-
  > factorial 2
  ~ if 2 == 0 then 1 else 2 * factorial 1
  ~ 2 * factorial 1
  ~ 2 * (if 1 == 0 then 1 else 1 * factorial 0)
  ~ 2 * 1 * factorial 0
  ~ 2 * factorial 0
  ~ 2 * (if 0 == 0 then 1 else 0 * factorial (-1))
  ~ 2 * 1
  ~ 2
-}

--factorial' :: (Eq p, Num p) => p -> p
factorial' 0 = 1
factorial' n = n * factorial' (n - 1)


doubleFact :: Integer -> Integer
doubleFact n = if n <= 0 then 1 else n * doubleFact (n - 2)


-- > error "ABC"
-- ~ *** Exception: ABC
-- > undefined
-- ~ *** Exception: Prelude.undefined

--factorial'' :: (Num p, Ord p) => p -> p
factorial'' 0 = 1
factorial'' n = if n < 0 then error "arg must be >= 0" else n * factorial'' (n - 1)

-- > factorial'' (-3)
-- ~ *** Exception: arg must be >= 0

--factorial''' :: (Num p, Ord p) => p -> p
factorial''' 0 = 1
factorial''' n | n < 0 = error "arg must be >= 0"
             n | n > 0 = n * factorial''' (n - 1)

factorial4 :: Integer -> Integer
factorial4 n | n == 0    = 1
             | n > 0     = n * factorial4 (n - 1)
             | otherwise = error "arg must be >= 0"


--fibonacci :: (Eq a, Num a, Num p) => a -> p
--fibonacci 0 = 0
--fibonacci 1 = 1
--fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)

fibonacci :: Integer -> Integer
fibonacci n | n == 0 = 0
            | n == 1 = 1
            | n > 0 = fibonacci (n - 1) + fibonacci (n - 2)
            | n < 0 = fibonacci (n + 2) - fibonacci (n + 1)
            | otherwise = undefined


{-
long factorial(int n) {
    long acc = 1;
    while (n > 1) {
        acc *= n--;
    }
    return acc;
}
-}

--helper :: (Eq t, Num t) => t -> t -> t
helper acc 0 = acc
helper acc n = helper (acc * n) (n - 1)

--factorial5 :: (Ord t, Num t) => t -> t
factorial5 n | n >= 0 = helper 1 n
             | otherwise = error "arg must be >= 0"


-- > :set +s
-- > fibonacci 30
-- ~ 832040
-- ~ (8.36 secs, 298293400 bytes)

f :: Integer -> Integer -> Integer -> Integer
f a b n | n == 0 = a
        | n > 0 = f b (a + b) (n - 1)
        | n < 0 = f (b - a) a (n + 1)
        | otherwise = undefined

effectiveFibonacci :: Integer -> Integer
effectiveFibonacci = f 0 1
