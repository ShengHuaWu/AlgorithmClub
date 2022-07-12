//: [Previous](@previous)

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
    
    func testRecursiveCompress() {
        XCTAssertEqual([1, 2, 3, 4, 5, 8, 9, 11, 14, 17].compress(), ["1-5", "8-9", "11", "14", "17"])
        XCTAssertEqual([1, 2, 3, 4, 5, 8, 9, 11, 14, 17].recursiveCompress(), ["1-5", "8-9", "11", "14", "17"])
    }
}

//ArrayTests.defaultTestSuite.run()

// String
final class StringTests: XCTestCase {
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
    
    func testTruncation() {
        let text = """
        Grab, the ride-hailing company competing with Uber in Southeast Asia, has pulled in $2 billion of new financing from existing investors Didi Chuxing, the company that defeated Uber in China, and SoftBank.
        """
        XCTAssertEqual(text.recursiveTruncate(with: 16), "Grab, the ")
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
