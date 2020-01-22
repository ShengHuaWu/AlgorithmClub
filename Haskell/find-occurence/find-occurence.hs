import Data.Array
import Data.String
import Assert

-- The input array should be sorted beforehand
findOccurence :: (Ord a, Num a) => [a] -> a -> Int
findOccurence array key = do
    let end = length array -- `end` should be set to the length, because of the right boundary
    let leftBoundary = findLeftBoundary array key 0 end
    let righBoundary = findRightBoundary array key 0 end
    righBoundary - leftBoundary

findRightBoundary :: (Ord a, Num a) => [a] -> a -> Int -> Int -> Int
findRightBoundary array key start end
    | start >= end = start
    | mValue > key = findRightBoundary array key start mid 
    | otherwise = findRightBoundary array key (mid + 1) end
    where
        mid = start + (end - start) `div` 2 -- Use `div` instead of `/`
        mValue = array !! mid

findLeftBoundary :: (Ord a, Num a) => [a] -> a -> Int -> Int -> Int
findLeftBoundary array key start end
    | start >= end = start
    | mValue < key = findLeftBoundary array key (mid + 1) end
    | otherwise = findLeftBoundary array key start mid
    where
        mid = start + (end - start) `div` 2
        mValue = array !! mid

-- Count the occurence of the second arg in the first arg
countOccurence :: String -> String -> Int
countOccurence _ "" = 0
countOccurence source target
    | length source == 0 = 0
    | subStr == target = 1 + countOccurence (drop targetLen source) target
    | otherwise = countOccurence (tail source) target
    where
        targetLen = length target
        subStr = take targetLen source

main = do
    assertEq (findOccurence [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11] 2) 4
    assertEq (findOccurence [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11] 8) 0
    assertEq (findOccurence [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11] 11) 1
    assertEq (findOccurence [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11] 99) 0
    assertEq (findOccurence [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11] 10) 1
    assertEq (findOccurence [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11] (-1)) 1
    assertEq (findOccurence [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11] 4) 1
    assertEq (countOccurence "Hello world" "") 0
    assertEq (countOccurence "" "goal") 0
    assertEq (countOccurence "howimetyourmomgameofthronemommostrangethings" "mom") 2

