//: [Previous](@previous)

import XCTest

final class ProductOfArrayExceptSelfTests: XCTestCase {
    func testProductExceptSelf() {
        XCTAssertTrue([Int]().productExceptSelf().isEmpty)
        XCTAssertTrue([1].productExceptSelf().isEmpty)
        XCTAssertEqual([1, 2, 3, 4].productExceptSelf(), [24, 12, 8, 6])
        XCTAssertEqual([-1, 1, 0, -3, 3].productExceptSelf(), [0, 0, 9, 0, 0])
        XCTAssertEqual([-1, 1, 0, -3, 0].productExceptSelf(), [0, 0, 0, 0, 0])
    }
}

ProductOfArrayExceptSelfTests.defaultTestSuite.run()

//: [Next](@next)
