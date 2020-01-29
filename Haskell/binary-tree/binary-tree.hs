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
                Leaf
                (Node 13 Leaf Leaf)
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

minElement :: (Ord a) => Tree a -> Maybe a
minElement tree = case tree of
    Leaf -> Nothing
    -- maybe :: b -> (a -> b) -> Maybe a -> b
    -- the `maybe` functraverseInOrdern takes a default value, a functraverseInOrdern, and a Maybe value. 
    -- If the Maybe value is Nothing, the functraverseInOrdern returns the default value. 
    -- Otherwise, it applies the functraverseInOrdern to the value inside the Just and returns the result.
    Node a left _ -> Just (maybe a (min a) (minElement left))

maxElement :: (Ord a) => Tree a -> Maybe a
maxElement tree = case tree of
    Leaf -> Nothing
    Node a _ right -> Just (maybe a (max a) (maxElement right))

append :: (Ord a) => Tree a -> a -> Tree a
append Leaf a = Node a Leaf Leaf
append (Node x left right) a
    | x <= a = Node x left (append right a) 
    | otherwise = Node x (append left a) right

contain :: (Ord a) => Tree a -> a -> Bool
contain Leaf _ = False
contain (Node x left right) a
    | x < a = contain right a
    | x > a = contain left a
    | otherwise = True

traverseInOrder :: (Ord a) => Tree a -> (a -> b) -> [b]
traverseInOrder Leaf _ = []
traverseInOrder (Node x left right) f = (traverseInOrder left f) ++ [(f x)] ++ (traverseInOrder right f) 

invert :: (Ord a) => Tree a -> Tree a
invert tree = case tree of
    Leaf -> Leaf
    Node x left right -> Node x (invert right) (invert left)

remove :: (Ord a) => Tree a -> a -> Tree a
remove Leaf _ = Leaf
remove (Node x left right) a | x > a = Node x (remove left a) right -- Move to left if value is larger than key
remove (Node x left right) a | x < a = Node x left (remove right a) -- Move to right if value is smaller than key
remove (Node x Leaf Leaf) a | x == a = Leaf -- Just remove the node itself because it has no child
remove (Node x left Leaf) a | x == a = left -- Return left if the node only has left child
remove (Node x Leaf right) a | x == a = right -- Return right if the node only has right child
remove (Node x left right) a 
    | x == a = Node min left (remove right min) -- Return one new node with the minimum value from the right, and remove the minimum value as well
    where
        min = (fromJust . minElement) right

main = do
    assertEq (height sampleTree) 5
    assertEq (minElement sampleTree) (Just 2)
    assertEq (maxElement sampleTree) (Just 25)
    print (append sampleTree 4)
    print (append sampleTree 8)
    assertEq (contain sampleTree 13) True
    assertEq (contain sampleTree 99) False
    assertEq (traverseInOrder sampleTree (\x -> x)) [2,3,5,6,7,10,12,13,18,19,21,23,25]
    assertEq (traverseInOrder (invert sampleTree) (\x -> x)) [25,23,21,19,18,13,12,10,7,6,5,3,2]
    assertEq (traverseInOrder (remove sampleTree 18) (\x -> x)) [2,3,5,6,7,10,12,13,19,21,23,25]
