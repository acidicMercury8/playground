module TypeClasses where

-- > :t 7
-- ~ 7 :: Num a => a
-- > :t (+)
-- ~ (+) :: Num a => a -> a -> a
-- > :t (>)
-- ~ (>) :: Ord a => a -> a -> Bool
-- > :t (> 7)
-- ~ (> 7) :: (Num a, Ord a) => a -> Bool
-- > :t (> (1, 2))
-- ~ (> (1, 2)) :: (Num t, Num t1, Ord t, Ord t1) => (t, t1) -> Bool

-- From standard library
{-
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
-}

-- > :t (==)
-- ~ (==) :: Eq a => a -> a -> Bool
-- > :t (== 42)
-- ~ (== 42) :: (Eq a, Num a) => a -> Bool
-- > :t (== 'x')
-- ~ (== 'x') :: Char -> Bool
-- > :t elem
-- ~ elem :: Eq a => a -> [a] -> Bool

{-
class Eq a where
  (==), (/=) :: a -> a -> Bool

instance Eq Bool where
  True  == True  = True
  False == False = True
  _     == _     = False

  x /= y = not (x == y)
-}

{-
class Eq a where
  (==), (/=) :: a -> a -> Bool
  x /= y = not (x == y)
  x == y = not (x /= y)

instance Eq Bool where
  True  == True  = True
  False == False = True
  _     == _     = False
-}


class Printable a where
  toString :: a -> String

instance Printable Bool where
  toString True = "true"
  toString False = "false"

instance Printable () where
  toString _ = "unit type"


-- From standard library
{-
class Eq a where
  (==), (/=) :: a -> a -> Bool
  x /= y = not (x == y)
  x == y = not (x /= y)

instance Eq Bool where
  True  == True  = True
  False == False = True
  _     == _     = false

instance (Eq a, Eq b) => Eq (a, b) where
  p1 == p2 = fst p1 == fst p2 && snd p1 == snd p2
-}

-- > :i (==)
-- ~ class Eq a where
-- ~   (==) :: a -> a -> Bool
-- ~   ...
-- ~ infix 4 ==
-- > :i (&&)
-- ~ (&&) :: Bool -> Bool -> Bool
-- ~ infixr 3 &&
-- > 


instance (Printable a, Printable b) => Printable (a, b) where
  toString (a, b) = "(" ++ toString a ++ "," ++ toString b ++ ")"
