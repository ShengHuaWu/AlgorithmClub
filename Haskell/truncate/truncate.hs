import Data.String
import Assert

truncate_ :: String -> Int -> String
truncate_ _ 0 = ""
truncate_ source len
    | length source <= len = source
    | otherwise = truncate__ (take len source)
        
truncate__ :: String -> String
truncate__ "" = ""
truncate__ source
    | elem [(last source)] [".", ",", ":", ";", "?", "!", " "] = source
    | otherwise = (truncate__ . init) source

main = do
    assertEq (truncate_ "" 99) ""
    assertEq (truncate_ "This is a book" 0) ""
    assertEq (truncate_ "Grab, the ride-hailing company competing with Uber in Southeast Asia, has pulled..." 16) "Grab, the "
