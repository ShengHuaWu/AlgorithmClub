import Data.String
import Assert

fizzBuzz :: Int -> String
fizzBuzz number
    | number == 0 = ""
    | number == 1 = "1"
    | number `mod` 3 == 0 && number `mod` 5 == 0 = (fizzBuzz before) <> " FizzBuzz"
    | number `mod` 3 == 0 = (fizzBuzz before) <> " Fizz"
    | number `mod` 5 == 0 = (fizzBuzz before) <> " Buzz"
    | otherwise = (fizzBuzz before) <> " " <> (show number)
    where
        before = number - 1

main = do
    assertEq (fizzBuzz 0) ""
    assertEq (fizzBuzz 1) "1"
    assertEq (fizzBuzz 6) "1 2 Fizz 4 Buzz Fizz"
    assertEq (fizzBuzz 15) "1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz"