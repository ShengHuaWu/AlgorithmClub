import Data.Array
import Assert

mergeSort :: (Ord a, Num a) => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort array
    | length array <= 1 = array
    | otherwise =
    let mid = length array `div` 2
        left = mergeSort (take mid array)
        right = mergeSort (drop mid array)
    in merge left right

merge :: (Ord a, Num a) => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
    | x > y = [y] ++ (merge (x:xs) ys)
    | otherwise = [x] ++ (merge xs (y:ys))

main = do
    assertEq (mergeSort []) []
    assertEq (mergeSort [99]) [99]
    assertEq (mergeSort [-9, 1, 0, 3, 6, 77, 27, 4]) [-9, 0, 1, 3, 4, 6, 27, 77]
    assertEq (mergeSort [-9, 1, 1, 3, 4, 27, 27, 4]) [-9, 1, 1, 3, 4, 4, 27, 27]