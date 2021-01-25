-- #11: Modify the result of problem #10 in such a way that if an element has no duplicates it is simply copied into the result list.
-- Only elements with duplicates are transferred as (N E) lists.

-- Copy from #9
myPack :: Eq a => [a] -> [[a]]
myPack [] = []
myPack (x:xs) = (x : takeWhile (==x) xs) : myPack (dropWhile (==x) xs)

-- Copy from #10
myEncode :: Eq a => [a] -> [(Int, a)]
myEncode xs = (\ys -> (length ys, head ys)) <$> myPack xs

myModified :: (Int, a) -> Either (Int, a) a
myModified (0, x) = Right x
myModified (1, x) = Right x
myModified (n, x) = Left (n, x)

myEncodeModified :: Eq a => [a] -> [Either (Int, a) a]
myEncodeModified xs = myModified <$> myEncode xs

main = do
  print "#11"
  print $ myEncodeModified ""
  print $ myEncodeModified "aaaabccaadeeee"
  print $ myEncodeModified [1, 1, 2, 3, 3, 4, 5, 5]
