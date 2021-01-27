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

-- #12: Given a run-length code list generated as specified in #11. Construct its uncompressed version.
mySingleDecodeModified :: Either (Int, a) a -> [a]
mySingleDecodeModified (Right x) = [x]
mySingleDecodeModified (Left (n, x)) = replicate n x

myDecodeModified :: [Either (Int, a) a] -> [a]
myDecodeModified xs = xs >>= mySingleDecodeModified

-- #13: Implement the so-called run-length encoding data compression method directly, but not use the result from the previous problems.

-- #14: Duplicate the elements of a list.
myDuplicate :: [a] -> [a]
myDuplicate [] = []
myDuplicate (x:xs) = x : x : (myDuplicate xs)

main = do
  print "#11"
  print $ myEncodeModified ""
  print $ myEncodeModified "aaaabccaadeeee"
  print $ myEncodeModified [1, 1, 2, 3, 3, 4, 5, 5]
  print "#12"
  print $ (myDecodeModified [] :: String)
  print $ myDecodeModified [Left (4,'a'),Right 'b',Left (2,'c'),Left (2,'a'),Right 'd',Left (4,'e')]
  print $ myDecodeModified [Left (2,1),Right 2,Left (2,3),Right 4,Left (2,5)]
  print "#13"
  print "#14"
  print $ myDuplicate ""
  print $ myDuplicate "abcccd"
  print $ myDuplicate [1, 2, 3, 5, 6]
