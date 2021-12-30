//: [Previous](@previous)

import XCTest

final class HasEqualSumSubsetTests: XCTestCase {
    func testHasEqualSumsubSet() {
        XCTAssertFalse([Int]().hasEqualSumSubset())
        XCTAssertFalse([1, 2, 3, 5].hasEqualSumSubset())
        XCTAssertTrue([1, 6, 6, 11].hasEqualSumSubset())
    }
}

//HasEqualSumSubsetTests.defaultTestSuite.run()

//: [Next](@next)
