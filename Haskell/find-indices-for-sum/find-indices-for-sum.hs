import Data.Array

-- The array should be sorted beforehand
findIndicesForSum :: (Ord a, Num a) =>  a -> [a] -> Maybe (Int, Int)
findIndicesForSum sum array = findIndicesForSum_ sum array 0 (length array - 1)

findIndicesForSum_ :: (Ord a, Num a) => a -> [a] -> Int -> Int -> Maybe (Int, Int)
findIndicesForSum_ sum array start end
    | start >= end = Nothing
    | temp < sum = findIndicesForSum_ sum array (start + 1) end
    | temp > sum = findIndicesForSum_ sum array start (end - 1)
    | otherwise = Just (start, end)
    where
        temp = (array !! start) + (array !! end)

main = do 
    print(findIndicesForSum 5 [1, 3, 4, 6, 8, 9, 11])
    print(findIndicesForSum 6 [1, 3, 4, 6, 8, 9, 11])
    print(findIndicesForSum 12 [1, 3, 4, 6, 8, 9, 11])
    print(findIndicesForSum 17 [1, 3, 4, 6, 8, 9, 11])
    print(findIndicesForSum 99 [1, 3, 4, 6, 8, 9, 11])