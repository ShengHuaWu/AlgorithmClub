import Data.String
import Assert

-- Two inputs strings should be the same lowercase or uppercase 
anagram :: String -> String -> Bool
anagram [] [] = True
anagram [] ys = False
anagram xs [] = False
anagram (x:xs) ys =
    let filteredXs = [a | a <- xs, a /= x]
        filteredYs = [a | a <- ys, a /= x] -- `/=`  means not equal
    in anagram filteredXs filteredYs

main = do
    assertEq (anagram "listen" "silent") True
    assertEq (anagram "car" "arc") True
    assertEq (anagram "" "") True
    assertEq (anagram "xyz" "abc") False
    assertEq (anagram "abcd" "xyz") False
    assertEq (anagram "keep" "peek") True
    assertEq (anagram "egg" "eg") True