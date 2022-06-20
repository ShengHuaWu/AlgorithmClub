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
}

DynamicProgrammingTests.defaultTestSuite.run()

//: [Next](@next)
