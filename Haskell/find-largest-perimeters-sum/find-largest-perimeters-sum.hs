import Data.Array
import Assert

-- The array should be sorted descently beforehand
findLargestPerimetersSum :: (Num a, Ord a) => [a] -> Maybe a
findLargestPerimetersSum xs 
    | length xs < 3 = Nothing
    | p2 + p3 > p1 = Just (p1 + p2 + p3)
    | otherwise = findLargestPerimetersSum (tail xs)
    where
        p1 = head xs
        p2 = (head . tail) xs
        p3 = (head . tail . tail) xs

main = do
    assertEq (findLargestPerimetersSum [11, 9, 8, 6, 4, 3, 1]) (Just 28)
    assertEq (findLargestPerimetersSum [1, 1, 1, 1, 1, 1, 1]) (Just 3)
    assertEq (findLargestPerimetersSum [2, 1, 0, 0, 0, 0, 0]) Nothing