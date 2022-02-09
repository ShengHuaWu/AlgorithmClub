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
}

FindSubsequenceTests.defaultTestSuite.run()

//: [Next](@next)
