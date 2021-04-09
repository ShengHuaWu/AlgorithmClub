import Foundation
import XCTest

// Array
final class ArrayTests: XCTestCase {
    func testTreatsDistribution() {
        XCTAssertEqual([2, 2, 3, 3, 4, 4].treatsDistribution(), 3)
        XCTAssertEqual([1, 1, 2, 4].treatsDistribution(), 2)
        XCTAssertEqual([1, 1, 1, 1].treatsDistribution(), 1)
    }
    
    func testFindMaximumWaitingTime() {
        XCTAssertEqual([2, 8, 4, 3, 2].findMaximumWaitingTime(xRemainingGas: 7, yRemainingGas: 11, zRemainingGas: 3), 8)
    }
    
    func testFindMinimumDistanceBetweenAdjacent() {
        XCTAssertEqual([Int]().findMinimumDistanceBetweenAdjacent(), -2)
        XCTAssertEqual([100_000_001, 0].findMinimumDistanceBetweenAdjacent(), -1)
        XCTAssertEqual([0, 3, 3, 7, 5, 3, 11, 1].findMinimumDistanceBetweenAdjacent(), 0)
    }
    
    func testFindInRotated() {
        XCTAssertEqual([5, 6, 7, 1, 2, 3, 4].findInRotated(key: 6), 1)
        XCTAssertEqual([5, 6, 7, 1, 2, 3, 4].findInRotated(key: 3), 5)
        XCTAssertEqual([5, 6, 7, 1, 2, 3, 4].findInRotated(key: 8), -1)
        XCTAssertEqual([5, 6, 7, 1, 2, 3, 4].findInRotated(key: 2), 4)
    }
    
    func testFindAllSumCombinations() {
        XCTAssertEqual(
            [1, 2, 3].findAllSumCombinations(for: 7),
            [
                [1, 1, 1, 1, 1, 1, 1],
                [1, 1, 1, 1, 1, 2],
                [1, 1, 1, 1, 3],
                [1, 1, 1, 2, 2],
                [1, 1, 2, 3],
                [1, 2, 2, 2],
                [1, 3, 3],
                [2, 2, 3]
            ]
        )
    }
    
    func testFindLargestSumOfSubarray() {
        XCTAssertEqual([-4, 2, -5, 1, 2, 3, 6, -5, 1].findLargestSumOfSubarray(), 12)
        XCTAssertEqual([3, 7, 5, 4, 1, 5, 2, 1].findLargestSumOfSubarray(with: 3), 16)
    }
    
    func testMergeOverlapping() {
        [(1, 5), (3, 7), (4, 6), (6, 8)].mergeOverlapping() // [(1, 8)]
        [(1, 5), (7, 9)].mergeOverlapping() // [(1, 5), (7, 9)]
        [(10, 12), (12, 15)].mergeOverlapping() // [(10, 15)]
    }
    
    func testFindLargestLengthOfAdjacent() {
        XCTAssertEqual([1, 2, 3, 4, 7, 9, 10, 11].findLargestLengthOfAdjacent(), 4)
    }
    
    func testFindSubset() {
        XCTAssertEqual([5, 8, 3, 2, 1].findSubset(), [5, 8])
        XCTAssertEqual([-5, 8, 3, 2, 1, 7].findSubset(), [8])
    }
    
    func testFindTwoElementsSum() {
        let numbers = [-10, 0, 3, 4, 6, 2, 5, 6, 7, 9, 0, 8]
        XCTAssertEqual([-10, 0, 3, 4, 6, 2, 5, 6, 7, 9, 0, 8].indices(for: 8)?.0, 4)
        XCTAssertEqual([-10, 0, 3, 4, 6, 2, 5, 6, 7, 9, 0, 8].indices(for: 8)?.1, 5)
        
        let sorted = numbers.sorted()
        XCTAssertEqual(sorted.indicesAfterSorting(for: 17)?.0, 10)
        XCTAssertEqual(sorted.indicesAfterSorting(for: 17)?.1, 11)
    }
    
    func testFindThreeElementsSum() {
        XCTAssertEqual([3, 7, 5, 8, 1, 2, 4].findThreeElements(having: 20)?.0, 7)
        XCTAssertEqual([3, 7, 5, 8, 1, 2, 4].findThreeElements(having: 20)?.1, 5)
        XCTAssertEqual([3, 7, 5, 8, 1, 2, 4].findThreeElements(having: 20)?.2, 8)
        
        XCTAssertNil([3, 7, 5, 8, 1, 2, 4].findThreeElements(having: 21))
    }
    
    func testShiftZeros() {
        XCTAssertEqual([0, 20, -3, 0, 0, 9, 7, 2, 1, 0].shiftingZeros(), [20, -3, 9, 7, 2, 1, 0, 0, 0, 0])

        var integers = [0, 20, -3, 0, 0, 9, 7, 2, 1, 0]
        integers.shiftZeros()
        XCTAssertEqual(integers, [20, -3, 9, 7, 2, 1, 0, 0, 0, 0])
    }
    
    func testMinAndMax() {
        XCTAssertEqual([-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11].minAndMax()?.0, -1)
        XCTAssertEqual([-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11].minAndMax()?.1, 11)
    }
    
    func testOccurrence() {
        XCTAssertEqual([-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11].occurrence(of: 2), 4)
    }
    
    func testBinarySearch() {
        XCTAssertEqual([-10, -3, 0, 1, 3, 4, 6, 9, 12, 29].binarySearch(for: 1), 3)
        XCTAssertEqual([-10, -3, 0, 1, 3, 4, 6, 9, 12, 29].recursiveBinarySearch(for: 10), nil)
    }
    
    func testFindLargestPerimetersSum() {
        XCTAssertEqual([1, 3, 4, 9, 10, 8, 7, 6, 5, 2, 11, 17].findLargestPerimetersSum(), 38)
        XCTAssertEqual([1, 3, 4, 9, 10, 8, 7, 6, 5, 2, 11, 17].recursiveFindLargestPerimetersSum(), 38)
    }
    
    func testRecursiveCompress() {
        XCTAssertEqual([1, 2, 3, 4, 5, 8, 9, 11, 14, 17].compress(), ["1-5", "8-9", "11", "14", "17"])
        XCTAssertEqual([1, 2, 3, 4, 5, 8, 9, 11, 14, 17].recursiveCompress(), ["1-5", "8-9", "11", "14", "17"])
    }
    
    func testSorting() {
        let numbers = [-10, -3, 0, 1, 3, 4, 6, 9, 12, 29]
        XCTAssertEqual(numbers.quickSorting(), [-10, -3, 0, 1, 3, 4, 6, 9, 12, 29])
        XCTAssertEqual(numbers.mergeSorting(), [-10, -3, 0, 1, 3, 4, 6, 9, 12, 29])
    }
    
    func testIntersection() {
        XCTAssertEqual([3, 7, 1, 4, 6].intersecting(with: [2, 4, 5, 6, 1, 0, 9]), [1, 4, 6])
    }
    
    func testFindKthLargest() {
        XCTAssertNil([Int]().findKthLargest(3))
        XCTAssertEqual([0, -1, 2, 9, 7, 4].findKthLargest(3), 4)
        XCTAssertEqual([0, -1, 2, 9, 7, 4].findKthLargest(9), -1)
    }
    
    func testFindKthClosest() {
        XCTAssertEqual([Int]().findKthClosest(8, to: 3), [])
        XCTAssertEqual([-1, 2, 3].findKthClosest(4, to: 0), [-1, 2, 3])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosest(3, to: 0), [-1, 0, 1])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosest(2, to: 0), [-1, 0])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosest(5, to: -1), [-1, 0, 1, 2, 3])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosest(5, to: 3), [0, 1, 2, 3, 4])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosest(5, to: 4), [0, 1, 2, 3, 4])
        
        XCTAssertEqual([Int]().findKthClosestAnotherWay(8, to: 3), [])
        XCTAssertEqual([-1, 2, 3].findKthClosestAnotherWay(4, to: 0), [-1, 2, 3])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosestAnotherWay(3, to: 0), [-1, 0, 1])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosestAnotherWay(2, to: 0), [-1, 0])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosestAnotherWay(5, to: -1), [-1, 0, 1, 2, 3])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosestAnotherWay(5, to: 3), [0, 1, 2, 3, 4])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosestAnotherWay(5, to: 4), [0, 1, 2, 3, 4])
    }
}

//ArrayTests.defaultTestSuite.run()


// Binary Tree
final class BinaryTreeTests: XCTestCase {
    func testIsIdenticial() {
        let tree = BinaryTree.leaf
            .adding(5)
            .adding(3)
            .adding(2)
            .adding(8)
            .adding(4)

        let anotherTree = tree
        XCTAssertTrue(tree.isIdenticial(with: anotherTree))
        XCTAssertFalse(tree.isIdenticial(with: tree.mirroring()))
    }
    
    func testFindAllPaths() {
        var temp = 0
        let predicate: () -> Bool = {
            temp += 1            
            return temp.isMultiple(of: 2)
        }
        
        let tree = BinaryTree.leaf
            .adding(5, predicate)
            .adding(3, predicate)
            .adding(2, predicate)
            .adding(8, predicate)
            .adding(7, predicate)
            .adding(4, predicate)
            .adding(9, predicate)
        
        XCTAssertEqual(tree.findAllPaths(for: 16), [[5, 3, 8]])
    }
}

//BinaryTreeTests.defaultTestSuite.run()

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
*/

// Singly Linked List
final class SinglyLinkedListTests: XCTestCase {
    func testMerge() {
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

        XCTAssertEqual(list1.merged(list2).description, "4 -> 7 -> 8 -> 9 -> 10 -> 15 -> 16 -> 19")
    }
    
    func testAddition() {
        let list1 = SinglyLinkedList<Int>()
        list1.append(newValue: 1)
        list1.append(newValue: 2)
        list1.append(newValue: 3)
        let list2 = SinglyLinkedList<Int>()
        list2.append(newValue: 9)
        list2.append(newValue: 9)

        XCTAssertEqual(list1.add(list2).description, "0 -> 2 -> 4")

        let list3 = SinglyLinkedList<Int>()
        list3.append(newValue: 1)
        list3.append(newValue: 0)
        list3.append(newValue: 9)
        list3.append(newValue: 9)
        let list4 = SinglyLinkedList<Int>()
        list4.append(newValue: 7)
        list4.append(newValue: 3)
        list4.append(newValue: 2)

        XCTAssertEqual(list3.add(list4).description, "8 -> 3 -> 1 -> 0 -> 1")
    }
    
    func testRemove() {
        let list1 = SinglyLinkedList<Int>()
        list1.append(newValue: 4)
        list1.append(newValue: 8)
        list1.append(newValue: 15)
        list1.append(newValue: 19)
        
        list1.remove(for: 4)
        XCTAssertEqual(list1.description, "8 -> 15 -> 19")
        
        list1.remove(for: 15)
        XCTAssertEqual(list1.description, "8 -> 19")
        
        list1.remove(for: 19)
        XCTAssertEqual(list1.description, "8")
        
        let list2 = SinglyLinkedList<Int>()
        list2.append(newValue: 5)
        list2.append(newValue: 9)
        list2.append(newValue: 9)
        
        list2.remove(for: 9)
        XCTAssertEqual(list2.description, "5 -> 9")
    }
    
    func testRemoveNodes() {
        let list = SinglyLinkedList<Int>()
        list.append(newValue: 5)
        list.append(newValue: 9)
        list.append(newValue: 9)
        
        list.removeNodes(for: 9)
        XCTAssertEqual(list.description, "5")
    }
    
    func testRemoveKth() {
        let list = SinglyLinkedList<Int>()
        list.append(newValue: 4)
        list.append(newValue: 8)
        list.append(newValue: 15)
        list.append(newValue: 8)
        list.append(newValue: 19)
        list.append(newValue: 8)
        list.append(newValue: 10)
        list.append(newValue: 8)
        
        list.remove(at: 3, for: 8)
        XCTAssertEqual(list.description, "4 -> 8 -> 15 -> 8 -> 19 -> 10 -> 8")
    }
    
    func testDeepCopy() {
        let list = SinglyLinkedList<Int>()
        list.append(newValue: 4)
        list.append(newValue: 8)
        list.append(newValue: 15)
        list.append(newValue: 19)
        
        let copied = list.deepCopy()
        XCTAssertEqual(copied.description, list.description)
        
        copied.remove(for: 15)
        XCTAssertNotEqual(copied.description, list.description)
    }
}

//SinglyLinkedListTests.defaultTestSuite.run()

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
list1.append(newValue: 4)
list1.getRandomNode()*/

// Double Linked List
final class DoubleLinkedListTests: XCTestCase {
    func testCopyRandomList() {
        let original = DoubleLinkedListNode<Int>(1)
        let next2 = DoubleLinkedListNode<Int>(2)
        let next3 = DoubleLinkedListNode<Int>(3)
        original.next = next2
        next2.next = next3
        original.random = next3
        next2.random = original
        next3.random = next2
        
        let copy = original.copyRandomList()

        XCTAssertEqual(original.description, copy?.description)
        XCTAssertEqual(original.next?.description, copy?.next?.description)
        XCTAssertEqual(original.random?.description, copy?.random?.description)
    }
    
    func testCopyRandomListAnotherWay() {
        let original = DoubleLinkedListNode<Int>(1)
        let next2 = DoubleLinkedListNode<Int>(2)
        let next3 = DoubleLinkedListNode<Int>(3)
        original.next = next2
        next2.next = next3
        original.random = next3
        next2.random = original
        next3.random = next2
        
        let copy = original.copyRandomListAnotherWay()

        XCTAssertEqual(original.description, copy?.description)
        XCTAssertEqual(original.next?.description, copy?.next?.description)
        XCTAssertEqual(original.random?.description, copy?.random?.description)
    }
}

//DoubleLinkedListTests.defaultTestSuite.run()


// String
final class StringTests: XCTestCase {
    func testParseAcceptLanguage() {
        XCTAssertEqual(parseAcceptLanguage("en-US, fr-CA, fr-FR", ["fr-FR", "en-US"]), ["en-US", "fr-FR"])
        XCTAssertEqual(parseAcceptLanguage("fr-CA, fr-FR", ["en-US", "fr-FR"]), ["fr-FR"])
        XCTAssertEqual(parseAcceptLanguage("en-US", ["en-US", "fr-CA"]), ["en-US"])
        XCTAssertEqual(parseAcceptLanguage("", ["en-US", "fr-CA"]), [])
        XCTAssertEqual(parseAcceptLanguage("fr-FR", []), [])
        XCTAssertEqual(parseAcceptLanguage("fr-FR", ["en-US", "fr-CA"]), [])
        XCTAssertEqual(parseAcceptLanguage("en", ["en-US", "fr-CA", "fr-FR"]), ["en-US"])
        XCTAssertEqual(parseAcceptLanguage("fr", ["en-US", "fr-CA", "fr-FR"]), ["fr-CA", "fr-FR"])
        XCTAssertEqual(parseAcceptLanguage("fr-FR, fr", ["en-US", "fr-CA", "fr-FR"]), ["fr-FR", "fr-CA"])
    }
    
    func testGetTargetsVicinities() {
        XCTAssertEqual("341".getTargetsVicinities(for: "341"), "3T0V")
        XCTAssertEqual("341".getTargetsVicinities(for: "123"), "0T2V")
        XCTAssertEqual("341".getTargetsVicinities(for: "134"), "0T3V")
    }
    
    func testIsSubsequence() {
        XCTAssertTrue("bell".isSubsequence(of: "barbell"))
        XCTAssertTrue("hen".isSubsequence(of: "chicken"))
        XCTAssertFalse("kgb".isSubsequence(of: "kfcapple"))
        XCTAssertFalse("kgb".isSubsequence(of: "gbkfcapple"))
    }
    
    func testValidateBalancedBrackets() {
        XCTAssertTrue("".validateBalancedBrackets())
        XCTAssertTrue("{{{{{[[()()]]}}}}}[]{}".validateBalancedBrackets())
        XCTAssertFalse("{{]](())".validateBalancedBrackets())
    }
    
    func testHardDriveStatistics() {
        let report = """
        my.song.mp3 11b
        greatSong.flac 1000b
        not3.txt 5b
        video.mp4 200b
        game.exe 100b
        mov!e.mkv 10000b
        """
        
        let expect = """
        music 1011b
        images 0b
        movies 10200b
        others 105b
        """
        
        XCTAssertEqual(report.hardDriveStatistics(),  expect)
        XCTAssertEqual(report.hardDriveStatisticsWithParser(), expect)
    }
    
    func testFindAllPalindromeSubstrings() {
        XCTAssertEqual("aabbbaa".findAllPalindromeSubstrings(), ["aabbbaa", "aa", "abbba", "bbb", "bb"])
    }
    
    func testReversedWords() {
        let text = """
        Playing a text adventure game about the zombie apocalypse, with text on the screen so you can read with me while you listen. Video version available. Play the game with me – follow the links below. AUDIO VERSION [DOWNLOAD AUDIO] VIDEO VERSION Links Play “Zombolocaust” by Peter Carlson
        """
        
        let expect = """
        Carlson Peter by “Zombolocaust” Play Links VERSION VIDEO AUDIO] [DOWNLOAD VERSION AUDIO below. links the follow – me with game the Play available. version Video listen. you while me with read can you so screen the on text with apocalypse, zombie the about game adventure text a Playing
        """
        XCTAssertEqual(text.reversedWords(), expect)
    }
    
    func testFizzBuss() {
        XCTAssertEqual(String.recursiveFizzBuss(in: 15), "1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 Fizz Buzz ")
    }
    
    func testTruncation() {
        let text = """
        Grab, the ride-hailing company competing with Uber in Southeast Asia, has pulled in $2 billion of new financing from existing investors Didi Chuxing, the company that defeated Uber in China, and SoftBank.
        """
        XCTAssertEqual(text.recursiveTruncate(with: 16), "Grab, the ")
    }
    
    func testFindOccurence() {
        let text = "howimetyourmomgameofthronemommostrangethings"
        XCTAssertEqual(text.recursiveFindOccurence(of: "mom"), 2)
    }
    
    func testCountNumberOfPrettyStrings() {
        let text = "zoookkkklfuckaabbbccdceff"
        XCTAssertEqual(text.recursiveCountNumberOfPrettyStrings(with: 3), 3)
    }
    
    func testFindLongestSubstringWithNoMoreThan() {
        XCTAssertEqual("".findLongestSubstringWithNoMoreThan(kDistinctCharacters: 2), "")
        XCTAssertEqual("aabbaacc".findLongestSubstringWithNoMoreThan(kDistinctCharacters: 2), "aabbaa")
        XCTAssertEqual("aaabbcc".findLongestSubstringWithNoMoreThan(kDistinctCharacters: 2), "aaabb")
        XCTAssertEqual("aabbccc".findLongestSubstringWithNoMoreThan(kDistinctCharacters: 2), "bbccc")
    }
    
    func testFindLongestSubstringWithoutRepeatingCharacters() {
        XCTAssertEqual("".findLongestSubstringWithoutRepeatingCharacters(), "")
        XCTAssertEqual("abced".findLongestSubstringWithoutRepeatingCharacters(), "abced")
        XCTAssertEqual("aaabced".findLongestSubstringWithoutRepeatingCharacters(), "abced")
        XCTAssertEqual("abbced".findLongestSubstringWithoutRepeatingCharacters(), "bced")
        XCTAssertEqual("abcedd".findLongestSubstringWithoutRepeatingCharacters(), "abced")
    }
    
    func testToInt() {
        XCTAssertNil("".toInt())
        XCTAssertNil(".".toInt())
        XCTAssertEqual("12345".toInt(), 12345)
        XCTAssertEqual("012345".toInt(), 12345)
    }
    
    func testReorganize() {
        XCTAssertEqual("".reorganize(), "")
        XCTAssertEqual("aaabb".reorganize(), "ababa")
        XCTAssertEqual("aaabbb".reorganize(), "ababab")
        
        "aacbbb".reorganize() // This should work
    }
}

StringTests.defaultTestSuite.run()


// Graph
final class GraphTests: XCTestCase {
    func testClone() {
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
        
        tempNodeA.cloned().description // ???: How to verify?
    }
}

//GraphTests.defaultTestSuite.run()

// LRU Cache
final class LRUCacheTests: XCTestCase {
    func testGetSet() {
        let cache = LRUCache<Int, String>(capacity: 4)
        cache.set(key: 1, value: "one")
        cache.set(key: 2, value: "two")
        cache.set(key: 3, value: "three")
        cache.set(key: 4, value: "four")
        cache.set(key: 2, value: "new two")
        cache.get(key: 4)
        cache.set(key: 5, value: "five")
        cache.set(key: 6, value: "six")
        // ???: How to verify?
    }
}

//LRUCacheTests.defaultTestSuite.run()

// Rate Limit
final class RateLimitTests: XCTestCase {
    func testInvokeEndpointReturnResponseWithTwoDifferentCustomerIds() {
        let customerId1 = "One"
        let customerId2 = "Two"
        let api = API()
        
        api.invokeEndpoint(customerId1)
        api.invokeEndpoint(customerId2)
        api.invokeEndpoint(customerId1)
        api.invokeEndpoint(customerId1)
        
        XCTAssertEqual(api.invokeEndpoint(customerId1), "Response for One")
        XCTAssertEqual(api.invokeEndpoint(customerId2), "Response for Two")
    }
    
    func testInvokeEndpointReturnsNilAfterCallingItSixTimesStraight() {
        let customerId = "One"
        let api = API()
        
        api.invokeEndpoint(customerId)
        api.invokeEndpoint(customerId)
        api.invokeEndpoint(customerId)
        api.invokeEndpoint(customerId)
        
        XCTAssertEqual(api.invokeEndpoint(customerId), "Response for One")
        XCTAssertNil(api.invokeEndpoint(customerId))
    }
    
    func testInvokeEndpointReturnsResponseAfterCallingItSixTimesStraightButExceedingTwoSeconds() {
        let e = expectation(description: #function)
        let customerId = "One"
        let api = API()
        
        api.invokeEndpoint(customerId)
        api.invokeEndpoint(customerId)
        api.invokeEndpoint(customerId)
        api.invokeEndpoint(customerId)
        
        XCTAssertEqual(api.invokeEndpoint(customerId), "Response for One")
        
        DispatchQueue(label: #function).asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(api.invokeEndpoint(customerId), "Response for One")
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
}

//RateLimitTests.defaultTestSuite.run()

// Set
final class SetTests: XCTestCase {
    func testFindSubsetsWithEqualSum() {
        XCTAssertNil(Set().findSubsetsWithEqualSum())
        XCTAssertNil(Set([1, 2, 3, 4]).findSubsetsWithEqualSum())
        XCTAssertEqual(Set([1, 2, 3, 6]).findSubsetsWithEqualSum()?.0, [1, 2, 3])
        XCTAssertEqual(Set([1, 2, 3, 6]).findSubsetsWithEqualSum()?.1, [6])
    }
}

//SetTests.defaultTestSuite.run()
