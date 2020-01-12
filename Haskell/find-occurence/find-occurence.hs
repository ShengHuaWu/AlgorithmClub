import Data.Array
import Assert

-- The input array should be sorted beforehand
findOccurence :: (Ord a, Num a) => [a] -> a -> Int
findOccurence array key = do
    let end = length array - 1
    let leftBoundary = findLeftBoundary array key 0 end
    let righBoundary = findRightBoundary array key 0 end
    righBoundary - leftBoundary

findRightBoundary :: (Ord a, Num a) => [a] -> a -> Int -> Int -> Int
findRightBoundary array key start end
    | start >= end = rightBoundaryHelper array key start
    | mValue > key = findRightBoundary array key start mid 
    | otherwise = findRightBoundary array key (mid + 1) end
    where
        mid = start + (end - start) `div` 2 -- Use `div` instead of `/`
        mValue = array !! mid

-- If the last element is equal to the key, then plus one to the right boundary
rightBoundaryHelper :: (Ord a, Num a) => [a] -> a -> Int -> Int 
rightBoundaryHelper array key end 
    | eValue == key = end + 1
    | otherwise = end
    where 
        eValue = array !! end

findLeftBoundary :: (Ord a, Num a) => [a] -> a -> Int -> Int -> Int
findLeftBoundary array key start end
    | start >= end = start
    | mValue < key = findLeftBoundary array key (mid + 1) end
    | otherwise = findLeftBoundary array key start mid
    where
        mid = start + (end - start) `div` 2
        mValue = array !! mid


main = do
    assertEq (findOccurence [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11] 2) 4
    assertEq (findOccurence [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11] 8) 0
    assertEq (findOccurence [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11] 11) 1
    assertEq (findOccurence [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11] 99) 0
    assertEq (findOccurence [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11] 10) 1
    assertEq (findOccurence [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11] (-1)) 1
    assertEq (findOccurence [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11] 4) 1

