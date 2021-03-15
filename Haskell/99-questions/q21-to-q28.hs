-- #21: Insert an element at a given position into a list.
myInsert :: a -> [a] -> Int -> [a]
myInsert x [] _ = [x]
myInsert x xs 1 = x:xs
myInsert x (y:ys) n = y:(myInsert x ys (n-1))

main = do
  print "#21"
  print $ myInsert 'x' "" 9
  print $ myInsert 'x' "aaaabccaadeeee" 1
  print $ myInsert 'x' "aaaabccaadeeee" 3
  print $ myInsert 99 [1, 1, 2, 3, 3, 4, 5, 5] 5
