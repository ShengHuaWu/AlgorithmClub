-- #21: Insert an element at a given position into a list.
myInsert :: a -> [a] -> Int -> [a]
myInsert x [] _ = [x]
myInsert x xs 1 = x:xs
myInsert x (y:ys) n = y:(myInsert x ys (n-1))

-- #22: Create a list containing all integers within a given range.
myRange :: Int -> Int -> [Int]
myRange s e = [s..e]

main = do
  print "#21"
  print $ myInsert 'x' "" 9
  print $ myInsert 'x' "aaaabccaadeeee" 1
  print $ myInsert 'x' "aaaabccaadeeee" 3
  print $ myInsert 99 [1, 1, 2, 3, 3, 4, 5, 5] 5
  print "#22"
  print $ myRange 4 9
  print $ myRange 10 20
  print $ myRange 10 0
