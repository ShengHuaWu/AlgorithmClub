-- Eliminate consecutive duplicates of list elements.

myCompress :: (Eq a) => [a] -> [a]
myCompress [] = []
myCompress [x] = [x]
myCompress (x:y:xs)
  | x == y    = myCompress (y:xs)
  | otherwise = [x] ++ myCompress (y:xs)

main = do
  print $ myCompress ""
  print $ myCompress "aaaabccaadeeee"
