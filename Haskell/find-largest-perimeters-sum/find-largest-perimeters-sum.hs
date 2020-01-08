import Data.Array
import Assert

-- The array should be sorted descently beforehand
findLargestPerimetersSum :: (Num a, Ord a) => [a] -> Maybe a
findLargestPerimetersSum array = findLargestPerimetersSum_ array 0

findLargestPerimetersSum_ :: (Num a, Ord a) => [a] -> Int -> Maybe a
findLargestPerimetersSum_ array start 
    | start + 2 > (length array - 1) = Nothing
    | p2 + p3 > p1 = Just (p1 + p2 + p3)
    | otherwise = findLargestPerimetersSum_ array (start + 1)
    where 
        p1 = array !! start
        p2 = array !! (start + 1)
        p3 = array !! (start + 2)

main = do
    assertEq (findLargestPerimetersSum [11, 9, 8, 6, 4, 3, 1]) (Just 28)
    assertEq (findLargestPerimetersSum [1, 1, 1, 1, 1, 1, 1]) (Just 3)
    assertEq (findLargestPerimetersSum [2, 1, 0, 0, 0, 0, 0]) Nothing