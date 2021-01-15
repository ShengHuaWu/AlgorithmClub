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
integers2.shiftZeros()*/


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
dump(tree)*/


// Singly Linked List
/*
let list = SinglyLinkedList<Int>()
list.append(newValue: 1)
list.append(newValue: 2)
list.append(newValue: 3)

list.remove(with: 3)*/


// String
/*
let str1 = "zoookkkklfuckaabbbccdceff"
str1.recursiveCountNumberOfPrettyStrings(with: 3)
assertEqual(str1.recursiveCountNumberOfPrettyStrings(with: 3), 3)

let str2 = "howimetyourmomgameofthronemommostrangethings"
assertEqual(str2.recursiveFindOccurence(of: "mom"), 2)

let str3 = "Grab, the ride-hailing company competing with Uber in Southeast Asia, has pulled in $2 billion of new financing from existing investors Didi Chuxing, the company that defeated Uber in China, and SoftBank."
assertEqual(str3.recursiveTruncate(with: 16), "Grab, the ")

String.recursiveFizzBuss(in: 15)*/
