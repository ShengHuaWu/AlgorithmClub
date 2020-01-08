module Assert ( assertEq ) where

assertEq :: (Eq a) => a -> a -> IO ()
assertEq lhs rhs
    | lhs == rhs = print("Good :)")
    | otherwise = print("Bad :(")