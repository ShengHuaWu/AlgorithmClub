-- Find the K'th element of a list. The first element in the list is number 1.

elementAt :: [a] -> Integer -> Maybe a
elementAt [] _ = Nothing
elementAt (x:xs) 1 = Just x
elementAt (x:xs) n = elementAt xs (n-1)

main = do
  print $ elementAt [1,2,3] 2
  print $ elementAt "haskell" 5
