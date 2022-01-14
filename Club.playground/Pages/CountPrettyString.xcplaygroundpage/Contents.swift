//: [Previous](@previous)

import XCTest

final class CountPrettyStringTests: XCTestCase {
    func testCountPrettyString() {
        var text = ""
        XCTAssertEqual(text.countPrettyString(with: 3), 0)

        text = "zooo"
        XCTAssertEqual(text.countPrettyString(with: 3), 1)

        text = "zoookkkklfuckaabbbccdceff"
        XCTAssertEqual(text.countPrettyString(with: 3), 4)
    }
}

//CountPrettyStringTests.defaultTestSuite.run()

//: [Next](@next)
