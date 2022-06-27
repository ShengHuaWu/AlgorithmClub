//: [Previous](@previous)

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
    
    func testFindLargestLengthOfAdjacent() {
        XCTAssertEqual([1, 2, 3, 4, 7, 9, 10, 11].findLargestLengthOfAdjacent(), 4)
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
}

//ArrayTests.defaultTestSuite.run()

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
    func testGetTargetsVicinities() {
        XCTAssertEqual("341".getTargetsVicinities(for: "341"), "3T0V")
        XCTAssertEqual("341".getTargetsVicinities(for: "123"), "0T2V")
        XCTAssertEqual("341".getTargetsVicinities(for: "134"), "0T3V")
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
    
    func testFindLongestSubstringWithNoMoreThan() {
        XCTAssertEqual("".findLongestSubstringWithNoMoreThan(kDistinctCharacters: 2), "")
        XCTAssertEqual("aabbaacc".findLongestSubstringWithNoMoreThan(kDistinctCharacters: 2), "aabbaa")
        XCTAssertEqual("aaabbcc".findLongestSubstringWithNoMoreThan(kDistinctCharacters: 2), "aaabb")
        XCTAssertEqual("aabbccc".findLongestSubstringWithNoMoreThan(kDistinctCharacters: 2), "bbccc")
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
    
    func testFindAllBraceCombinations() {
        XCTAssertEqual(findAllBraceCombinations(for: 0), [])
        XCTAssertEqual(findAllBraceCombinations(for: 3), ["{}{}{}", "{}{{}}", "{{}}{}", "{{}{}}", "{{{}}}"])
    }
    
    func testFindMostOftenCharacter() {
        XCTAssertNil("".findMostOftenCharacter())
        XCTAssertEqual("shenghua".findMostOftenCharacter(), "h")
        XCTAssertEqual("what if something goes wrong?".findMostOftenCharacter(), " ")
        
        XCTAssertNil("".findMostOftenCharacterAnotherWay())
        XCTAssertEqual("shenghua".findMostOftenCharacterAnotherWay(), "h")
        XCTAssertEqual("what if something goes wrong?".findMostOftenCharacterAnotherWay(), " ")
    }
}

//StringTests.defaultTestSuite.run()

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

// Set
final class SetTests: XCTestCase {
    func testFindSubsetsWithEqualSum() {
        XCTAssertNil(Set().findSubsetsWithEqualSum())
        XCTAssertNil(Set([1, 2, 3, 4]).findSubsetsWithEqualSum())
        XCTAssertEqual(Set([1, 2, 3, 6]).findSubsetsWithEqualSum()?.0, [1, 2, 3])
        XCTAssertEqual(Set([1, 2, 3, 6]).findSubsetsWithEqualSum()?.1, [6])
    }
    
    func testFindKthLargestElement() {
        XCTAssertNil(Set().findKthLargestElement(9))
        XCTAssertEqual(Set([1, 2, 3, 4]).findKthLargestElement(9), 1)
        XCTAssertEqual(Set([1, 2, 3, 4]).findKthLargestElement(2), 3)
        XCTAssertEqual(Set([1, 2, 3, 4]).findKthLargestElement(3), 2)
        
        
        XCTAssertNil(Set().findKthLargestElementAnotherWay(9))
        XCTAssertEqual(Set([1, 2, 3, 4]).findKthLargestElementAnotherWay(9), 1)
        XCTAssertEqual(Set([1, 2, 3, 4]).findKthLargestElementAnotherWay(2), 3)
        XCTAssertEqual(Set([1, 2, 3, 4]).findKthLargestElementAnotherWay(3), 2)
    }
}

//SetTests.defaultTestSuite.run()

//: [Next](@next)
