import Data.Array
import Assert

shiftZeros :: (Ord a, Num a) => [a] -> [a]
shiftZeros [] = []
shiftZeros array = shiftZeros_ array 0

-- If the element is equal to zero, move forward
-- Otherwise prepend the element to the result
-- Stop when the source array is empty and append zeros
shiftZeros_ :: (Ord a, Num a) => [a] -> Int -> [a]
shiftZeros_ array count
    | length array == 0 = replicate count 0 -- Create an array having `count` zeros
    | e == 0 = shiftZeros_ (tail array) (count + 1)
    | otherwise = [e] ++ (shiftZeros_ (tail array) count)
    where
        e = head array

main = do
    assertEq (shiftZeros []) []
    assertEq (shiftZeros [2]) [2]
    assertEq (shiftZeros [0, 2, 3, 4, 0, 7, 0, 9]) [2, 3, 4, 7, 9, 0, 0, 0]
    assertEq (shiftZeros [99, 2, 0, 4, 0, 17, 0, 9]) [99, 2, 4, 17, 9, 0, 0, 0]