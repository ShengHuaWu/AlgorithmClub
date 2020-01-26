import Data.Maybe
import Assert

data Tree a = Leaf | Node a (Tree a) (Tree a) deriving (Show)

sampleTree :: Tree Int
sampleTree = 
    Node 10
        (Node 5 
            (Node 2 
                Leaf 
                (Node 3 Leaf Leaf)
            )
            (Node 7 
                (Node 6 Leaf Leaf)
                Leaf
            )
        )
        (Node 18 
            (Node 12 
                (Node 13 Leaf Leaf)
                Leaf
            )
            (Node 21 
                (Node 19 Leaf Leaf) 
                (Node 25 
                    (Node 23 Leaf Leaf) 
                    Leaf)
            )
        )

height :: Tree a -> Int
height tree = case tree of
    Leaf -> 0
    Node _ left right -> 1 + max (height left) (height right)

minElement :: Tree Int -> Maybe Int
minElement tree = case tree of
    Leaf -> Nothing
    -- maybe :: b -> (a -> b) -> Maybe a -> b
    -- the `maybe` function takes a default value, a function, and a Maybe value. 
    -- If the Maybe value is Nothing, the function returns the default value. 
    -- Otherwise, it applies the function to the value inside the Just and returns the result.
    Node a left _ -> Just (maybe a (min a) (minElement left))

maxElement :: Tree Int -> Maybe Int
maxElement tree = case tree of
    Leaf -> Nothing
    Node a _ right -> Just (maybe a (max a) (maxElement right))

main = do
    assertEq (height sampleTree) 5
    assertEq (minElement sampleTree) (Just 2)
    assertEq (maxElement sampleTree) (Just 25)
