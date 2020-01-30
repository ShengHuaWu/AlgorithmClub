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
append (Node x next) a = prepend (append next a) x -- prepend x to the new node in order to keep tracking the head

main = do
    assertEq (getLength sampleLinkedList) 5
    assertEq (getLength (prepend sampleLinkedList 7)) 6
    assertEq (getHead sampleLinkedList) (Just 9)
    assertEq (getTail sampleLinkedList) (Just 3)
    assertEq (getLength (append sampleLinkedList 7)) 6
    assertEq (getTail (append sampleLinkedList 7)) (Just 7)