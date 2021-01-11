-- Find the last but one element in a list

reverseList :: [a] -> [a]
reverseList [] = []
reverseList (x:xs) = reverseList xs ++ [x]

myFirst :: [a] -> Maybe a
myFirst [] = Nothing
myFirst (x:xs) = Just x

mySecond :: [a] -> Maybe a
mySecond [] = Nothing
mySecond (x:xs) = myFirst xs

myButLast :: [a] -> Maybe a
myButLast =  mySecond . reverseList

main = do
  print $ myButLast [1, 2, 3, 4]
  print $ myButLast ['a'..'z']
