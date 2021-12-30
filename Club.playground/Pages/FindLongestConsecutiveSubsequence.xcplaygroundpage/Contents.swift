//: [Previous](@previous)

import XCTest

final class FindLongestConsecutiveSubsequenceTests: XCTestCase {
    func testFindLongestConsecutiveSubsequence() {
        XCTAssertTrue([Int]().findLongestConsecutiveSubsequence().isEmpty)
        XCTAssertEqual([1].findLongestConsecutiveSubsequence(), [1])
        XCTAssertEqual([-1, 7, 3, 5, 1, 2, 3, 4, -2, 9, 19, 0].findLongestConsecutiveSubsequence(), [1, 2, 3, 4])
        XCTAssertEqual([1, 2, 3, 4, -2, 9, 19, 0, -1, 7, 3, 5].findLongestConsecutiveSubsequence(), [1, 2, 3, 4])
        XCTAssertEqual([-2, 9, 19, 0, -1, 7, 3, 5, 1, 2, 3, 4].findLongestConsecutiveSubsequence(), [1, 2, 3, 4])
    }
}

//FindLongestConsecutiveSubsequenceTests.defaultTestSuite.run()

//: [Next](@next)
