//: [Previous](@previous)

import XCTest

final class FindSubsequenceTests: XCTestCase {
    func testFindLongestConsecutiveSubsequence() {
        XCTAssertTrue([Int]().findLongestConsecutiveSubsequence().isEmpty)
        XCTAssertEqual([1].findLongestConsecutiveSubsequence(), [1])
        XCTAssertEqual([-1, 7, 3, 5, 1, 2, 3, 4, -2, 9, 19, 0].findLongestConsecutiveSubsequence(), [1, 2, 3, 4])
        XCTAssertEqual([1, 2, 3, 4, -2, 9, 19, 0, -1, 7, 3, 5].findLongestConsecutiveSubsequence(), [1, 2, 3, 4])
        XCTAssertEqual([-2, 9, 19, 0, -1, 7, 3, 5, 1, 2, 3, 4].findLongestConsecutiveSubsequence(), [1, 2, 3, 4])
    }
    
    func testIsSubsequence() {
        XCTAssertTrue("bell".isSubsequence(of: "barbell"))
        XCTAssertTrue("bell".isSubsequence(of: "bearbell"))
        XCTAssertTrue("hen".isSubsequence(of: "chicken"))
        XCTAssertTrue("hen".isSubsequence(of: "chincken"))
        XCTAssertTrue("kgb".isSubsequence(of: "kkapggplebb"))
        XCTAssertFalse("kgb".isSubsequence(of: "kfcapple"))
        XCTAssertFalse("kgb".isSubsequence(of: "gbkfcapple"))
        XCTAssertFalse("".isSubsequence(of: "gbkfcapple"))
        XCTAssertFalse("abc".isSubsequence(of: ""))
        
        XCTAssertTrue("bell".isSubsequenceAnotherApproach(of: "barbell"))
        XCTAssertTrue("bell".isSubsequenceAnotherApproach(of: "bearbell"))
        XCTAssertTrue("hen".isSubsequenceAnotherApproach(of: "chicken"))
        XCTAssertTrue("hen".isSubsequenceAnotherApproach(of: "chincken"))
        XCTAssertTrue("kgb".isSubsequenceAnotherApproach(of: "kkapggplebb"))
        XCTAssertFalse("kgb".isSubsequenceAnotherApproach(of: "kfcapple"))
        XCTAssertFalse("kgb".isSubsequenceAnotherApproach(of: "gbkfcapple"))
        XCTAssertFalse("".isSubsequenceAnotherApproach(of: "gbkfcapple"))
        XCTAssertFalse("abc".isSubsequenceAnotherApproach(of: ""))
    }
    
    func testGetMaxSubarraySum() {
        XCTAssertEqual([Int]().getMaxSubarraySum(), 0)
        XCTAssertEqual([1].getMaxSubarraySum(), 1)
        XCTAssertEqual([-2, 1, -3, 4, -1, 2, 1, -5, 4].getMaxSubarraySum(), 6)
        XCTAssertEqual([5, 4, -1, 7, 8].getMaxSubarraySum(), 23)
        XCTAssertEqual([-5, -4, -1, -7, -8].getMaxSubarraySum(), -1)
    }
    
    func testGetMaxSubarrayProduct() {
        XCTAssertEqual([Int]().getMaxSubarrayProduct(), 0)
        XCTAssertEqual([1].getMaxSubarrayProduct(), 1)
        XCTAssertEqual([2, 3, -2, 4].getMaxSubarrayProduct(), 6)
        XCTAssertEqual([-2, 0, -1].getMaxSubarrayProduct(), 0)
        XCTAssertEqual([-5, -4, -1, -7, -8].getMaxSubarrayProduct(), 224)
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

FindSubsequenceTests.defaultTestSuite.run()

//: [Next](@next)
