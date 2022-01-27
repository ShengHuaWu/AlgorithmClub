//: [Previous](@previous)

import XCTest

final class FindSubsetTests: XCTestCase {
    func testFindSubset() {
        XCTAssertTrue([Int]().findSubset().isEmpty)
        XCTAssertEqual([5, 8, 3, 2, 1].findSubset(), [5, 8])
        XCTAssertEqual([5, 8, 3, 5, 2, 1].findSubset(), [5, 5, 8])
        XCTAssertEqual([5, 8, 3, 5, 2, 1, 8].findSubset(), [5, 5, 8, 8])
        XCTAssertEqual([-5, 8, 3, 2, 1, 7].findSubset(), [7, 8])
        XCTAssertEqual([-5, 8, 3, 2, 8, 1, 7].findSubset(), [8, 8])
    }
}

FindSubsetTests.defaultTestSuite.run()

//: [Next](@next)
