//: [Previous](@previous)

import XCTest

final class FindMaxAndMinTests: XCTestCase {
    func testFindMaxAndMin() {
        XCTAssertNil([Int]().findMaxAndMin())
        
        
        let result = [10, 6, 2, 7, 8, -1, 7, 14, 9, 0, -1, 2, 4, 5, 14, 9, 10].findMaxAndMin()
        XCTAssertEqual(result?.0, 14)
        XCTAssertEqual(result?.1, -1)
    }
}

FindMaxAndMinTests.defaultTestSuite.run()

//: [Next](@next)
