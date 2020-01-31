import Assert

data LinkedList a = Empty | Node a (LinkedList a) deriving (Show)

sampleLinkedList :: LinkedList Int
sampleLinkedList = 
    Node 9 
        (Node 1 
            (Node 10 
                (Node 2 
                    (Node 3 Empty))))

getLength :: LinkedList a -> Int
getLength Empty = 0
getLength (Node _ next) = 1 + getLength next 

prepend :: LinkedList a -> a -> LinkedList a
prepend Empty a = Node a Empty
prepend list a = Node a list

getHead :: LinkedList a -> Maybe a
getHead Empty = Nothing
getHead (Node a _) = Just a

getTail :: LinkedList a -> Maybe a
getTail Empty = Nothing
getTail (Node a Empty) = Just a
getTail (Node _ next) = getTail next

append :: LinkedList a -> a -> LinkedList a
append Empty a = Node a Empty
append (Node x Empty) a = Node x (Node a Empty)
-- prepend x to the new node in order to keep tracking the head
-- This case MUST be the last one
append (Node x next) a = prepend (append next a) x 

remove :: (Eq a) => LinkedList a -> a -> LinkedList a
remove Empty _ = Empty
remove (Node x Empty) a | x == a = Empty
remove (Node x Empty) a | x /= a = Node x Empty
remove (Node x next) a | x == a = next
-- prepend x to the new node in order to keep tracking the head
-- This case MUST be the last one
remove (Node x next) a | x /= a = prepend (remove next a) x

main = do
    assertEq (getLength sampleLinkedList) 5
    assertEq (getLength (prepend sampleLinkedList 7)) 6
    assertEq (getHead sampleLinkedList) (Just 9)
    assertEq (getTail sampleLinkedList) (Just 3)
    assertEq (getLength (append sampleLinkedList 7)) 6
    assertEq (getTail (append sampleLinkedList 7)) (Just 7)
    assertEq (getLength (remove sampleLinkedList 9)) 4
    assertEq (getTail (remove sampleLinkedList 3)) (Just 2)