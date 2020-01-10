import Data.Array
import Assert

-- The input [Int] should be sorted already and the elements cannot be duplicated
compress :: [Int] -> [String]
compress [] = []
compress [x] = [show x]
compress array = compress_ array 0 1

compress_ :: [Int] -> Int -> Int -> [String]
compress_ array start next
    | next >= length array = [showCompress array start next]
    | diff > 1 = [showCompress array start next] ++ (compress_ array next (next + 1))
    | otherwise = compress_ array start (next + 1)
    where 
        beforeNext = next - 1
        diff = (array !! next) - (array !! beforeNext)

showCompress :: [Int] -> Int -> Int -> String 
showCompress array start next 
    | start == beforeNext = show (array !! start)
    | otherwise = (show (array !! start)) <> "-" <> (show (array !! beforeNext))
    where
        beforeNext = next - 1

main = do
    assertEq (compress []) []
    assertEq (compress [99]) ["99"]
    assertEq (compress [7, 8]) ["7-8"]
    assertEq (compress [7, 99]) ["7", "99"]
    assertEq (compress [1, 2, 3, 6]) (["1-3", "6"])
    assertEq (compress [2, 6, 7, 8, 9, 12, 13, 14, 18]) (["2", "6-9", "12-14", "18"])
