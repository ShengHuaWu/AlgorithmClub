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

//: [Next](@next)
