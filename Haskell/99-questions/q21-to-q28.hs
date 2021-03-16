import System.Random

-- #21: Insert an element at a given position into a list.
myInsert :: a -> [a] -> Int -> [a]
myInsert x [] _ = [x]
myInsert x xs 1 = x:xs
myInsert x (y:ys) n = y:(myInsert x ys (n-1))

-- #22: Create a list containing all integers within a given range.
myRange :: Int -> Int -> [Int]
myRange s e = [s..e]

-- #23: Extract a given number of randomly selected elements from a list.
randomSelect :: [a] -> Int -> IO [a]
randomSelect [] _ = return []
randomSelect xs n = do
  gen <- getStdGen
  return $ take n [xs !! x | x <- randomRs (0, (length xs) - 1) gen] -- why???

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
  print "#23"
  randomSelect "" 3 >>= putStrLn
  randomSelect "abcdefgh" 3 >>= putStrLn
