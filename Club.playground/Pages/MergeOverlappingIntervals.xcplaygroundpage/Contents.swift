//: [Previous](@previous)

import XCTest

final class MergeOverlappingIntervalsTests: XCTestCase {
    func testMergeOverlapping() {
        XCTAssertEqual([(Int, Int)]().mergeOverlappings().count, 0)
        XCTAssertEqual([(1, 5), (3, 7), (4, 6), (6, 8)].mergeOverlappings().first?.0, 1)
        XCTAssertEqual([(1, 5), (3, 7), (4, 6), (6, 8)].mergeOverlappings().first?.1, 8)
        XCTAssertEqual([(1, 5), (7, 9)].mergeOverlappings().first?.0, 1)
        XCTAssertEqual([(1, 5), (7, 9)].mergeOverlappings().first?.1, 5)
        XCTAssertEqual([(1, 5), (7, 9)].mergeOverlappings().last?.0, 7)
        XCTAssertEqual([(1, 5), (7, 9)].mergeOverlappings().last?.1, 9)
    }
}

MergeOverlappingIntervalsTests.defaultTestSuite.run()

//: [Next](@next)
