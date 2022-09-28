module Functions where

sumSquares x y = x ^ 2 + y ^ 2


lenVec3 x y z = sqrt (x ^ 2 + y ^ 2 + z ^ 2)


f x = if x > 0 then 1 else (-1)

g x = (if x > 0 then 1 else (-1)) + 3


sign x = if x > 0 then 1 else (if x < 0 then (-1) else 0)

sign' x
  | x > 0 = 1
  | x < 0 = -1
  | otherwise = 0


max5 x = max 5 x

max5' = max 5


discount limit procent sum = if sum >= limit then sum * (100 - procent) / 100 else sum

standardDiscount = discount 1000 5
