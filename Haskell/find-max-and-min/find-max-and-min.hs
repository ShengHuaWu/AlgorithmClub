import Data.Array
import Assert

-- The first of the return tuple is maximum and the second is minimum
findMaxAndMin :: (Ord a, Num a) => [a] -> Maybe (a, a)
findMaxAndMin [] = Nothing
findMaxAndMin [x] = Just (x, x)
findMaxAndMin array 
    | (even . length) array = Just (findMaxAndMin_ array temp)
    | otherwise = Just (findMaxAndMin_ (tail array) temp)
    where
        temp = (head array, head array)

-- The input array has to contain even elements
findMaxAndMin_  :: (Ord a) => [a] -> (a, a) -> (a, a)
findMaxAndMin_ array result 
    | length array == 0 = result
    | e1 > e2 = findMaxAndMin_ withoutFirstTwo (max r1 e1, min r2 e2)
    | otherwise = findMaxAndMin_ withoutFirstTwo (max r1 e2, min r2 e1)
    where
        e1 = array !! 0
        e2 = array !! 1
        withoutFirstTwo = (tail . tail) array
        r1 = fst result
        r2 = snd result

main = do
    assertEq (findMaxAndMin [])  Nothing
    assertEq (findMaxAndMin [99]) (Just (99, 99))
    assertEq (findMaxAndMin [9, 19, 7, 0, 25, -9, 2, 1]) (Just (25, -9))
    assertEq (findMaxAndMin [9, 19, 7, 0, 25, -9, 2, 3, 1]) (Just (25, -9))
