import Data.Array
import Assert

-- The two input arrays should be sorted beforehand
intersect :: (Ord a, Num a) => [a] -> [a] -> [a]
intersect xs [] = xs
intersect [] ys = ys
intersect (x:xs) (y:ys)
    | x < y = [x] ++ (intersect xs (y:ys))
    | x > y = [y] ++ (intersect (x:xs) ys)
    | otherwise = [x] ++ (intersect xs ys)

main = do
    assertEq (intersect [] []) []
    assertEq (intersect [99] []) [99]
    assertEq (intersect [] [99]) [99]
    assertEq (intersect [1, 4, 5, 6, 9] [2, 3, 4, 7, 9]) [1, 2, 3, 4, 5, 6, 7, 9]