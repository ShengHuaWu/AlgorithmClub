//: [Previous](@previous)

import XCTest

final class FindLowAndHighTests: XCTestCase {
    func testFindLowAndHigh() {
        XCTAssertNil([Int]().findHighAndLow(for: 1))
        XCTAssertNil([-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11].findHighAndLow(for: 99))
        XCTAssertNil([1, 2, 2, 2, 3].findHighAndLow(for: 4))
        XCTAssertEqual([-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11].findHighAndLow(for: 11)?.0, 10)
        XCTAssertEqual([-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11].findHighAndLow(for: 11)?.1, 10)
        XCTAssertEqual([-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11].findHighAndLow(for: 2)?.0, 2)
        XCTAssertEqual([-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11].findHighAndLow(for: 2)?.1, 5)
    }
}

FindLowAndHighTests.defaultTestSuite.run()

//: [Next](@next)
