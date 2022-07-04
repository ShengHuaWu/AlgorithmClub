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
    
    func testGetMaxSubarraySum() {
        XCTAssertEqual([Int]().getMaxSubarraySum(), 0)
        XCTAssertEqual([1].getMaxSubarraySum(), 1)
        XCTAssertEqual([-2, 1, -3, 4, -1, 2, 1, -5, 4].getMaxSubarraySum(), 6)
        XCTAssertEqual([5, 4, -1, 7, 8].getMaxSubarraySum(), 23)
        XCTAssertEqual([-5, -4, -1, -7, -8].getMaxSubarraySum(), -1)
        
        XCTAssertEqual([3, 7, 5, 4, 1, 5, 2, 1].getMaxSubarraySum(with: 3), 16)
    }
    
    func testGetMaxSubarrayProduct() {
        XCTAssertEqual([Int]().getMaxSubarrayProduct(), 0)
        XCTAssertEqual([1].getMaxSubarrayProduct(), 1)
        XCTAssertEqual([2, 3, -2, 4].getMaxSubarrayProduct(), 6)
        XCTAssertEqual([-2, 0, -1].getMaxSubarrayProduct(), 0)
        XCTAssertEqual([-5, -4, -1, -7, -8].getMaxSubarrayProduct(), 224)
    }
}

FindSubsequenceTests.defaultTestSuite.run()

//: [Next](@next)
