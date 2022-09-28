module LocalBindings where

roots :: Double
      -> Double
      -> Double
      -> (Double, Double)
roots a b c =
  (
    (-b - sqrt (b ^ 2 - 4 * a * c)) / (2 * a)
  ,
    (-b + sqrt (b ^ 2 - 4 * a * c)) / (2 * a)
  )

--roots' :: Floating b => b -> b -> b -> (b, b)
roots' a b c =
  let d = sqrt (b ^ 2 - 4 * a * c) in
  ((-b - d) / (2 * a), (-b + d) / (2 * a))

-- > let x = True in (True, x)
-- ~ (True, True)

--roots'' :: Floating b => b -> b -> b -> (b, b)
roots'' a b c =
  let {d = sqrt (b ^ 2 - 4 * a * c); x1 = (-b - d) / (2 * a); x2 = (-b + d) / (2 * a)}
  in (x1, x2)

--roots''' :: Floating b => b -> b -> b -> (b, b)
roots''' a b c =
  let
    x1 = (-b - d) / aTwice
    x2 = (-b + d) / aTwice
    d = sqrt $ b ^ 2 - 4 * a * c
    aTwice = 2 * a
  in (x1, x2)


-- > (let x = 'w' in [x, 'o', x]) ++ "!"
-- ~ "wow!"


--factorial6 :: (Ord t, Num t) => t -> t
factorial6 n
  | n >= 0 =
    let
      helper acc 0 = acc
      helper acc n = helper (acc * n) (n - 1)
    in helper 1 n
  | otherwise = error "arg must be >= 0"

--rootsDiff :: Double -> Double -> Double -> Double
rootsDiff a b c =
  let (x1, x2) = roots a b c
  in x2 - x1


-- > seqA 301
-- ~ 1276538859311178639666612897162414

seqA :: Integer -> Integer
seqA n
  | n >= 0 =
    let
      f a b c 0 = a
      f a b c k = f b c (c + b - 2 * a) (k - 1)
      in f 1 2 3 n
  | otherwise = error "condition n >= 0 is violated"


--roots'''' :: Floating b => b -> b -> b -> (b, b)
roots'''' a b c = (x1, x2) where
  x1 = (-b - d) / aTwice
  x2 = (-b + d) / aTwice
  d = sqrt $ b ^ 2 - 4 * a * c
  aTwice = 2 * a

-- > let x = 2 in x ^ 2
-- ~ 4
-- > (let x = 2 in x ^ 2) ^ 2
-- ~ 16

factorial7 :: Integer -> Integer
factorial7 n | n >= 0 = helper 1 n
             | otherwise = error "arg must be >= 0"
  where
    helper acc 0 = acc
    helper acc n = helper (acc * n) (n - 1)


-- > sum'n'count (-39)
-- ~ (12,2)

sum'n'count :: Integer -> (Integer, Integer)
sum'n'count 0 = (0, 1)
sum'n'count x = (sum, count)
  where
    (sum, count) = f (abs x) 0 0
    f 0 s c = (s, c)
    f x s c = f (x `div` 10) (s + x `mod` 10) (c + 1)

-- > integration sin pi 0
-- ~ -2.0

integration :: (Double -> Double) -> Double -> Double -> Double
integration f a b = sum 0 0
  where
    step :: Double
    step = (b - a) / 1000
    x :: Integer -> Double
    x i = a + fromInteger i * step
    sum :: Integer -> Double -> Double
    sum 1000 acc = acc
    sum i acc = sum (i + 1) (acc
      + (f (x i) + f (x (i + 1)))
      * (x (i + 1) - x i) / 2.0)
