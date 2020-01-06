import Data.Array

binarySearch :: (Ord a) => a -> [a] -> Maybe Int
binarySearch x array = binarySearch_ x array 0 (length array - 1)

binarySearch_ :: (Ord a) => a -> [a] -> Int -> Int -> Maybe Int
binarySearch_ x array left right
    | left > right = Nothing
    | middle < x = binarySearch_ x array (middleIndex + 1) right
    | middle > x = binarySearch_ x array left (middleIndex - 1)
    | otherwise = Just middleIndex
    where 
        middleIndex = (left + right) `quot` 2
        middle = array !! middleIndex

main = do
    print(binarySearch 1 [1, 3, 4, 6, 8, 9, 11])
    print(binarySearch 2 [1, 3, 4, 6, 8, 9, 11])
    print(binarySearch 3 [1, 3, 4, 6, 8, 9, 11])
    print(binarySearch 4 [1, 3, 4, 6, 8, 9, 11])
    print(binarySearch 5 [1, 3, 4, 6, 8, 9, 11])