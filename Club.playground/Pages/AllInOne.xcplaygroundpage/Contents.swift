//: [Previous](@previous)

import XCTest

// Array
final class ArrayTests: XCTestCase {
    func testFindMaximumWaitingTime() {
        XCTAssertEqual([2, 8, 4, 3, 2].findMaximumWaitingTime(xRemainingGas: 7, yRemainingGas: 11, zRemainingGas: 3), 8)
    }
    
    func testFindMinimumDistanceBetweenAdjacent() {
        XCTAssertEqual([Int]().findMinimumDistanceBetweenAdjacent(), -2)
        XCTAssertEqual([100_000_001, 0].findMinimumDistanceBetweenAdjacent(), -1)
        XCTAssertEqual([0, 3, 3, 7, 5, 3, 11, 1].findMinimumDistanceBetweenAdjacent(), 0)
    }
    
    func testRecursiveCompress() {
        XCTAssertEqual([1, 2, 3, 4, 5, 8, 9, 11, 14, 17].compress(), ["1-5", "8-9", "11", "14", "17"])
        XCTAssertEqual([1, 2, 3, 4, 5, 8, 9, 11, 14, 17].recursiveCompress(), ["1-5", "8-9", "11", "14", "17"])
    }
}

//ArrayTests.defaultTestSuite.run()

// String
final class StringTests: XCTestCase {
    func testTruncation() {
        let text = """
        Grab, the ride-hailing company competing with Uber in Southeast Asia, has pulled in $2 billion of new financing from existing investors Didi Chuxing, the company that defeated Uber in China, and SoftBank.
        """
        XCTAssertEqual(text.recursiveTruncate(with: 16), "Grab, the ")
    }
    
    func testReorganize() {
        XCTAssertEqual("".reorganize(), "")
        XCTAssertEqual("aaabb".reorganize(), "ababa")
        XCTAssertEqual("aaabbb".reorganize(), "ababab")
        
        "aacbbb".reorganize() // This should work
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

//: [Next](@next)
