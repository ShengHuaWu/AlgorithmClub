//: [Previous](@previous)

import XCTest

final class DynamicProgrammingTests: XCTestCase {
    func testRob() {
        var input = [1, 2, 3, 1]
        XCTAssertEqual(input.rob(), 4)
        
        input = []
        XCTAssertEqual(input.rob(), 0)
        
        input = [2, 7, 9, 3, 1]
        XCTAssertEqual(input.rob(), 12)
    }
    
    func testGetSumCombinationCount() {
        var input = [Int]()
        var target = 4
        
        XCTAssertEqual(input.getSumCombinationCount(for: target), 0)
        
        input = [1, 2, 3]
        XCTAssertEqual(input.getSumCombinationCount(for: target), 7)
        
        target = 0
        XCTAssertEqual(input.getSumCombinationCount(for: target), 0)
        
        input = [9]
        target = 3
        XCTAssertEqual(input.getSumCombinationCount(for: target), 0)
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
    
    func testWordBreak() {
        var target = ""
        var words = ["leet", "code"]
        
        XCTAssertFalse(target.workBreak(in: words))
        
        target = "leetcode"
        
        XCTAssertTrue(target.workBreak(in: words))
        
        target = "leetleet"
        
        XCTAssertTrue(target.workBreak(in: words))
        
        target = "neetcode"
        
        XCTAssertFalse(target.workBreak(in: words))
        
        target = "applepenapple"
        words = ["apple", "pen"]
        
        XCTAssertTrue(target.workBreak(in: words))
    }
    
    func testFindLongestCommonSubsequence() {
        XCTAssertEqual([Int]().findLongestCommonSubsequence(with: [2, 3, 5, 7, 9, 10, 18, 101]), 0)
        XCTAssertEqual([10, 9, 2, 5, 3, 7, 101, 18].findLongestCommonSubsequence(with: []), 0)
        XCTAssertEqual([10, 9, 2, 5, 3, 7, 101, 18].findLongestCommonSubsequence(with: [2, 3, 5, 7, 9, 10, 18, 101]), 4)
    }
    
    func testFindLongestIncreasingSubsequence() {
        XCTAssertEqual([Int]().findLongestIncreasingSubsequence(), 0)
        XCTAssertEqual([10, 9, 2, 5, 3, 7, 101, 18].findLongestIncreasingSubsequence(), 4)
        XCTAssertEqual([10, 22, 9, 33, 21, 50, 41, 60].findLongestIncreasingSubsequence(), 5)
    }
}

DynamicProgrammingTests.defaultTestSuite.run()

//: [Next](@next)
