import Data.Array
import Assert

quickSort :: (Ord a, Num a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs) = 
    -- Use `let ... in` to create multiple local vairables (Be aware of indentation)
    let left = quickSort [a | a <- xs, a <= x]
        right = quickSort [a | a <- xs, a > x]
    in left ++ [x] ++ right
    

main = do
    assertEq (quickSort []) []
    assertEq (quickSort [99]) [99]
    assertEq (quickSort [1, 18, 9, 0, 6, 5, 4, 11, 19]) [0, 1, 4, 5, 6, 9, 11, 18, 19]
    assertEq (quickSort [1, -18, 9, 0, 6, 5, 4, -11, 19]) [-18, -11, 0, 1, 4, 5, 6, 9, 19]