module StandardTypeClasses where

-- From standard library
{-
class Eq a where
  (==), (/=) :: a -> a -> Bool
  x /= y = not (x == y)
  x == y = not (x /= y)

class (Eq a) => Ord a where
  (<), (<=), (>=), (>) :: a -> a -> Bool
  max, min :: a -> a -> a
  compare :: a -> a -> Ordering
-}

-- > :i Ordering
-- ~ data Ordering = LT | EQ | GT
-- ~ instance Bounded Ordering
-- ~ instance Enum Ordering
-- ~ instance Eq Ordering
-- ~ instance Ord Ordering
-- ~ instance Read Ordering
-- ~ instance Show Ordering


class KnownToGork a where
  stomp :: a -> a
  doesEnrageGork :: a -> Bool

class KnownToMork a where
  stab :: a -> a
  doesEnrageMork :: a -> Bool

class (KnownToGork a, KnownToMork a) => KnownToGorkAndMork a where
  stompOrStab :: a -> a
  stompOrStab x | doesEnrageGork x && doesEnrageMork x = stomp $ stab x
                | doesEnrageGork x = stab x
                | doesEnrageMork x = stomp x
                | otherwise = x


-- > :t show
-- ~ show :: Show a => a -> String
-- > show 5
-- ~ "5"
-- > show 5.0
-- ~ "5.0"
-- > show [1, 2]
-- ~ "[1, 2]"
-- > :t read
-- ~ read :: Read a => String a -> a
-- > read "5" :: Int
-- ~ 5
-- > read "5" :: Double
-- ~ 5.0
-- > read "[1, 2]" :: [Double]
-- ~ [1.0, 2.0]
-- > reads "5 rings" :: [(Int, String)]
-- ~ [(5, " rings")]



--ip = show a ++ show b ++ show c ++ show d
-- > ip
-- ~ "127.224.120.12"
a = 127.2
b = 24.1
c = 20.1
d = 2


-- From standard library
{-
class Enum a where
  succ, pred :: a -> a
  toEnum :: Int -> a
  fromEnum :: a -> Int
-}

-- > succ 5
-- ~ 5
-- > pred 4
-- ~ 3
-- > pred 'z'
-- ~ 'y'
-- > succ 'z'
-- ~ '{'
-- > fromEnum 'z'
-- ~ 122
-- > toEnum 122 :: Int
-- ~ 122

{-
class Bounded a where
  minBound, maxBound :: a
-}

-- > succ False
-- ~ True
-- > minBound :: Bool
-- ~ False
-- > maxBound :: Bool
-- ~ True
-- > minBound :: Int
-- ~ -9223372036854775808 (on 64-bit system)
-- > maxBound :: Int
-- ~ 9223372036854775807
-- > minBound :: Char
-- ~ '\NUL'
-- > maxBound :: Char
-- ~ '\1114111'


class (Enum a, Bounded a, Eq a) => SafeEnum a where
  ssucc :: a -> a
  ssucc x = if x == maxBound then minBound else succ x

  spred :: a -> a
  spred x = if x == minBound then maxBound else pred x


{-
class Num a where
  (+), (-), (*) :: a -> a -> a
  negate :: a -> a
  abs :: a -> a
  sugnum :: a -> a
  fromInteger :: Integer -> a

  x - y = x + negate y
  negate x = 0 - x
-}
{-
LAW: abs x * signum x == x
-}

-- > fromInteger 3
-- ~ 3
-- > :t fromInteger 3
-- ~ fromInteger 3 :: Num a => a
-- > :i Integral
-- ~ class (Real a, Enum a) => Integral a where
-- ~   quot :: a -> a -> a
-- ~   rem :: a -> a -> a
-- ~   div :: a -> a -> a
-- ~   mod :: a -> a -> a
-- ~   quotRem :: a -> a -> (a, a)
-- ~   divMod :: a -> a -> (a, a)
-- ~   toInteger :: a -> Integer
-- ~ instance Integral Integer
-- ~ instance Integral Int
-- > :i Fractional
-- ~ class Num a => Fractional a where
-- ~   (/) :: a -> a -> a
-- ~   recip :: a -> a
-- ~   fromRational :: Rational -> a
-- ~ instance Fractional Float
-- ~ instance Fractional Double
-- > :i Floating
-- ~ class Fractional a => Floating a where
-- ~   pi :: a
-- ~   exp :: a -> a
-- ~   sqrt :: a -> a
-- ~   log :: a -> a
-- ~   (**) :: a -> a -> a
-- ~   logBase :: a -> a -> a
-- ~   sin :: a -> a
-- ~   tan :: a -> a
-- ~   cos :: a -> a
-- ~   asin :: a -> a
-- ~   atan :: a -> a
-- ~   acos :: a -> a
-- ~   sinh :: a -> a
-- ~   tanh :: a -> a
-- ~   cosh :: a -> a
-- ~   asinh :: a -> a
-- ~   atanh :: a -> a
-- ~   acosh :: a -> a
-- ~ instance Floating Float
-- ~ instance Floating Double
-- > :i RealFrac
-- ~ class (Real a, Fractional a) => RealFrac a where
-- ~   properFraction :: Integral b => a -> (b, a)
-- ~   truncate :: Integral b => a -> b
-- ~   round :: Integral b => a -> b
-- ~   ceiling :: Integral b => a -> b
-- ~   floor :: Integral b => a -> b
-- ~ instance RealFrac Float
-- ~ instance RealFrac Double
-- > :i RealFloat
-- ~ class (RealFrac a, Floating a) => RealFloat a where
-- ~   floatRadix :: a -> Integer
-- ~   floatDigits :: a -> Int
-- ~   floatRange :: a -> (Int, Int)
-- ~   decodeFloat :: a -> (Integer, Int)
-- ~   encodeFloat :: Integer -> Int -> a
-- ~   exponent :: a -> Int
-- ~   significand :: a -> a
-- ~   scaleFloat :: Int -> a -> a
-- ~   isNaN :: a -> Bool
-- ~   isInfinite :: a -> Bool
-- ~   isDenormalized :: a -> Bool
-- ~   isNegativeZero :: a -> Bool
-- ~   isIEEE :: a -> Bool
-- ~   atan2 :: a -> a -> a
-- ~ instance RealFloat Float
-- ~ instance RealFloat Double


avg :: Int -> Int -> Int -> Double
avg a b c = fromInteger (toInteger a + toInteger b + toInteger c) / 3.0
