module ListFunctions where

-- > []
-- ~ []
-- > 3 : []
-- ~ [3]
-- > let lst = 5 : 3 : []
-- > lst
-- ~ [5, 3]
-- > 7 : lst
-- ~ [7, 5, 3]
-- > [5, 3] == lst
-- ~ True
-- > let cons42 = (42 :)
-- > :t cons42
-- ~ cons42 :: [Integer] -> [Integer]
-- > cons42 [1, 2]
-- ~ [42, 1, 2, 3]


-- > addTwoElements 2 12 [85, 0, 6]
-- ~ [2, 12, 85, 0, 6]

addTwoElements :: a -> a -> [a] -> [a]
addTwoElements x y l = x : y : l

-- > nTimes 42 3
-- ~ [42, 42, 42]
-- > nTimes 'z' 5
-- ~ "zzzzz"

nTimes:: a -> Int -> [a]
nTimes el 0 = []
nTimes el n = el : nTimes el (n - 1)
