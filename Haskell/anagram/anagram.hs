import Data.String
import Assert

anagram :: String -> String -> Bool
anagram [] [] = True
anagram [] ys = False
anagram xs [] = False
anagram (x:xs) ys =
    let filtered = [a | a <- ys, a /= x] -- `/=`  means not equal
    in anagram xs filtered

main = do
    assertEq (anagram "listen" "silent") True
    assertEq (anagram "car" "arc") True
    assertEq (anagram "" "") True
    assertEq (anagram "xyz" "abc") False
    assertEq (anagram "abcd" "xyz") False