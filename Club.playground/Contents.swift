import Foundation

// Array
/*
let integers = [-10, -3, 0, 1, 3, 4, 6, 9, 12, 29]
assertEqual(integers.binarySearch(for: 1), 3)
assertEqual(integers.recursiveBinarySearch(for: 10), nil)

let source = [-10, 0, 3, 4, 6, 2, 5, 6, 7, 9, 0, 8]
let indices = source.indices(for: 8)
assertEqual(indices!.0, 4)
assertEqual(indices!.1, 5)

let sortedSource = source.sorted()
let indicesAfterSorting = sortedSource.indicesAfterSorting(for: 17)
assertEqual(indicesAfterSorting!.0, 10)
assertEqual(indicesAfterSorting!.1, 11)

let edges = [1, 3, 4, 9, 10, 8, 7, 6, 5, 2, 11, 17]
assertEqual(edges.findLargestPerimetersSum(), edges.recursiveFindLargestPerimetersSum())

let numbers = [1, 2, 3, 4, 5, 8, 9, 11, 14, 17]
assertEqual(numbers.compress(), numbers.recursiveCompress())

assertEqual(source.quickSorting(), source.mergeSorting())

let a = [3, 7, 1, 4, 6]
let b = [2, 4, 5, 6, 1, 0, 9]
assertEqual(a.intersecting(with: b), [1, 4, 6])

let source2 = [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11]
source2.occurrence(of: 2)
source2.minAndMax()
var integers2 = [0, 20, -3, 0, 0, 9, 7, 2, 1, 0]
integers2.shiftingZeros()
integers2.shiftZeros()

[3, 7, 5, 8, 1, 2, 4].findThreeElements(having: 20)
[3, 7, 5, 8, 1, 2, 4].findThreeElements(having: 21)
[(1, 5), (3, 7), (4, 6), (6, 8)].mergeOverlapping()
[(1, 5), (7, 9)].mergeOverlapping()
[(10, 12), (12, 15)].mergeOverlapping()
[-4, 2, -5, 1, 2, 3, 6, -5, 1].findLargestSumOfSubarray()
[3, 7, 5, 4, 1, 5, 2, 1].findLargestSumOfSubarray(with: 3)
[1, 2, 3].findAllSumCombinations(for: 7)
[7, 6, 5, 1, 2, 3, 4].findInRotated(key: 6)
[7, 6, 5, 1, 2, 3, 4].findInRotated(key: 3)
[7, 6, 5, 1, 2, 3, 4].findInRotated(key: 8)
[5, 8, 3, 2, 1].findSubset()
[-5, 8, 3, 2, 1, 7].findSubset()*/
[1, 2, 3, 4, 7, 9, 10, 11].findLargestLengthOfAdjacent()

// Binary Search Tree
/*
var tree = BinarySearchTree<Int>.empty
tree.append(2)
tree.append(8)
tree.append(1)
tree.append(11)
 
tree.contains(9)
 
tree.append(5)
tree.append(21)
tree.append(3)
 
tree.remove(8)
dump(tree)

// Binary Tree
let tree = BinaryTree.leaf
    .adding(5)
    .adding(3)
    .adding(2)
    .adding(8)
    .adding(4)
tree.mirroring()

let anotherTree = tree
tree.isIdenticial(with: anotherTree)
tree.isIdenticial(with: tree.mirroring())*/



// Singly Linked List
/*
let list = SinglyLinkedList<Int>()
list.append(newValue: 1)
list.append(newValue: 2)
list.append(newValue: 3)

list.remove(with: 3)

let list1 = SinglyLinkedList<Int>()
list1.append(newValue: 1)
list1.append(newValue: 2)
list1.append(newValue: 3)
let list2 = SinglyLinkedList<Int>()
list2.append(newValue: 9)
list2.append(newValue: 9)

list1.add(list2)

let list3 = SinglyLinkedList<Int>()
list3.append(newValue: 1)
list3.append(newValue: 0)
list3.append(newValue: 9)
list3.append(newValue: 9)
let list4 = SinglyLinkedList<Int>()
list4.append(newValue: 7)
list4.append(newValue: 3)
list4.append(newValue: 2)

list3.add(list4)

let list1 = SinglyLinkedList<Int>()
list1.append(newValue: 4)
list1.append(newValue: 8)
list1.append(newValue: 15)
list1.append(newValue: 19)
let list2 = SinglyLinkedList<Int>()
list2.append(newValue: 7)
list2.append(newValue: 9)
list2.append(newValue: 10)
list2.append(newValue: 16)

list1.merged(list2)*/


// String
/*
let str1 = "zoookkkklfuckaabbbccdceff"
str1.recursiveCountNumberOfPrettyStrings(with: 3)
assertEqual(str1.recursiveCountNumberOfPrettyStrings(with: 3), 3)

let str2 = "howimetyourmomgameofthronemommostrangethings"
assertEqual(str2.recursiveFindOccurence(of: "mom"), 2)

let str3 = "Grab, the ride-hailing company competing with Uber in Southeast Asia, has pulled in $2 billion of new financing from existing investors Didi Chuxing, the company that defeated Uber in China, and SoftBank."
assertEqual(str3.recursiveTruncate(with: 16), "Grab, the ")

String.recursiveFizzBuss(in: 15)
"aabbbaa".findAllPalindromeSubstrings()
"Hello World".reversedWords()
"""
Playing a text adventure game about the zombie apocalypse, with text on the screen so you can read with me while you listen. Video version available. Play the game with me – follow the links below. AUDIO VERSION [DOWNLOAD AUDIO] VIDEO VERSION Links Play “Zombolocaust” by Peter Carlson
""".reversedWords()*/
"""
my.song.mp3 11b
greatSong.flac 1000b
not3.txt 5b
video.mp4 200b
game.exe 100b
mov!e.mkv 10000b
""".hardDriveStatistics()

// Graph
/*
let tempNodeA = GraphNode(title: "A")
let tempNodeB = GraphNode(title: "B")
let tempNodeC = GraphNode(title: "C")
let tempNodeD = GraphNode(title: "D")
tempNodeA.neighbors.append(tempNodeB)
tempNodeA.neighbors.append(tempNodeD)
tempNodeB.neighbors.append(tempNodeA)
tempNodeB.neighbors.append(tempNodeC)
tempNodeC.neighbors.append(tempNodeB)
tempNodeC.neighbors.append(tempNodeD)
tempNodeD.neighbors.append(tempNodeA)
tempNodeD.neighbors.append(tempNodeC)
tempNodeA.cloned()*/

// LRU Cache
/*
let cache = LRUCache<Int, String>(capacity: 4)
cache.set(key: 1, value: "one")
cache.set(key: 2, value: "two")
cache.set(key: 3, value: "three")
cache.set(key: 4, value: "four")
cache.set(key: 2, value: "new two")
cache.get(key: 4)
cache.set(key: 5, value: "five")
cache.set(key: 6, value: "six")*/
