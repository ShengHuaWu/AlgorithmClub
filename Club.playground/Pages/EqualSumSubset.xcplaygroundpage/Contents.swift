//: [Previous](@previous)

import XCTest

final class EqualSumSubsetTests: XCTestCase {
    func testHasEqualSumSubSet() {
        XCTAssertFalse([Int]().hasEqualSumSubset())
        XCTAssertFalse([1, 2, 3, 5].hasEqualSumSubset())
        XCTAssertTrue([1, 6, 6, 11].hasEqualSumSubset())
    }
    
    func testSplitIntoEqualSumSubSet() {
        XCTAssertNil([Int]().splitIntoEqualSumSubset())
        XCTAssertNil([1, 2, 3, 5].splitIntoEqualSumSubset())
        XCTAssertEqual([1, 6, 6, 11].splitIntoEqualSumSubset(), [6, 6])
    }
}

EqualSumSubsetTests.defaultTestSuite.run()

//: [Next](@next)
