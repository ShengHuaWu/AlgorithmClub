-- #1: Find the last element in a list
myLast :: [a] -> Maybe a
myLast [] = Nothing
myLast [x] = Just x
myLast (x:xs) = myLast xs

-- #2: Find the last but one element in a list
myFirst :: [a] -> Maybe a
myFirst [] = Nothing
myFirst (x:xs) = Just x

mySecond :: [a] -> Maybe a
mySecond [] = Nothing
mySecond (x:xs) = myFirst xs

myButLast :: [a] -> Maybe a
myButLast =  mySecond . myReverse -- `myReverse` is in #5

-- #3: Find the K'th element of a list. The first element in the list is number 1.
elementAt :: [a] -> Integer -> Maybe a
elementAt [] _ = Nothing
elementAt (x:xs) 1 = Just x
elementAt (x:xs) n = elementAt xs (n-1)

-- #4: Find the number of elements of a list.
myLength :: [a] -> Integer
myLength [] = 0
myLength (x:xs) = 1 + myLength xs

-- #5: Reverse a list
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

-- #6: Find out whether a list is a palindrome. A palindrome can be read forward or backward; e.g. (x a m a x)
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome xs = xs == (reverse xs)

-- #7: Flatten a nested list structure.
data NestedList a = Elem a | List [NestedList a]

myFlatten :: NestedList a -> [a]
myFlatten (Elem x) = [x]
myFlatten (List []) = []
myFlatten (List (x:xs)) = myFlatten x ++ (myFlatten $ List xs)

-- #8: Eliminate consecutive duplicates of list elements.
myCompress :: (Eq a) => [a] -> [a]
myCompress [] = []
myCompress [x] = [x]
myCompress (x:y:xs)
  | x == y    = myCompress (y:xs)
  | otherwise = [x] ++ myCompress (y:xs)

-- #9: Pack consecutive duplicates of list elements into sublists. If a list contains repeated elements they should be placed in separate sublists.
myPack :: Eq a => [a] -> [[a]]
myPack [] = []
myPack (x:xs) = (x : takeWhile (==x) xs) : myPack (dropWhile (==x) xs)

-- #10: Run-length encoding of a list.
-- Use the result of problem P09 to implement the so-called run-length encoding data compression method.
-- Consecutive duplicates of elements are encoded as lists (N E) where N is the number of duplicates of the element E.
myEncode :: Eq a => [a] -> [(Int, a)]
myEncode xs = fmap (\ys -> (length ys, head ys)) (myPack xs)

main = do
  print "#1"
  print $ myLast [1, 2, 3, 4]
  print $ myLast ['x', 'y', 'z']
  print "#2"
  print $ myButLast [1, 2, 3, 4]
  print $ myButLast ['a'..'z']
  print "#3"
  print $ elementAt [1,2,3] 2
  print $ elementAt "haskell" 5
  print "#4"
  print $ myLength [123, 456, 789]
  print $ myLength "hello, world"
  print "#5"
  print $ myReverse "A man, a plan, a canal, panama!"
  print $ myReverse [1,2,3,4]
  print "#6"
  print $ isPalindrome [1,2,3]
  print $ isPalindrome "madamimadam"
  print $ isPalindrome [1,2,4,8,16,8,4,2,1]
  print "#7"
  print $ myFlatten (List [Elem 1, List [Elem 2, List [Elem 3, Elem 4], Elem 5]])
  print $ myFlatten (Elem 5)
  print "#8"
  print $ myCompress ""
  print $ myCompress "aaaabccaadeeee"
  print "#9"
  print $ myPack ""
  print $ myPack ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']
  print $ myPack [1, 1, 2, 3, 3, 4, 5, 5]
  print "#10"
  print $ myEncode ""
  print $ myEncode "aaaabccaadeeee"
  print $ myEncode [1, 1, 2, 3, 3, 4, 5, 5]
