//: [Previous](@previous)

import XCTest

final class IntervalsTests: XCTestCase {
    func testMergeOverlapping() {
        XCTAssertEqual([(Int, Int)]().mergeOverlappings().count, 0)
        XCTAssertEqual([(1, 5), (3, 7), (4, 6), (6, 8)].mergeOverlappings().first?.0, 1)
        XCTAssertEqual([(1, 5), (3, 7), (4, 6), (6, 8)].mergeOverlappings().first?.1, 8)
        XCTAssertEqual([(1, 5), (7, 9)].mergeOverlappings().first?.0, 1)
        XCTAssertEqual([(1, 5), (7, 9)].mergeOverlappings().first?.1, 5)
        XCTAssertEqual([(1, 5), (7, 9)].mergeOverlappings().last?.0, 7)
        XCTAssertEqual([(1, 5), (7, 9)].mergeOverlappings().last?.1, 9)
    }
    
    func testInsert() {
        XCTAssertEqual([(Int, Int)]().insert((1, 2)).first?.0, 1)
        XCTAssertEqual([(Int, Int)]().insert((1, 2)).first?.1, 2)
        
        XCTAssertEqual([(1, 3), (6, 9)].insert((2, 5)).count, 2)
        XCTAssertEqual([(1, 3), (6, 9)].insert((2, 5)).first?.0, 1)
        XCTAssertEqual([(1, 3), (6, 9)].insert((2, 5)).first?.1, 5)
        XCTAssertEqual([(1, 3), (6, 9)].insert((2, 5)).last?.0, 6)
        XCTAssertEqual([(1, 3), (6, 9)].insert((2, 5)).last?.1, 9)
        
        XCTAssertEqual([(1, 3), (6, 9)].insert((4, 5)).count, 3)
        XCTAssertEqual([(1, 3), (6, 9)].insert((4, 5)).first?.0, 1)
        XCTAssertEqual([(1, 3), (6, 9)].insert((4, 5)).first?.1, 3)
        XCTAssertEqual([(1, 3), (6, 9)].insert((4, 5))[1].0, 4)
        XCTAssertEqual([(1, 3), (6, 9)].insert((4, 5))[1].1, 5)
        XCTAssertEqual([(1, 3), (6, 9)].insert((4, 5)).last?.0, 6)
        XCTAssertEqual([(1, 3), (6, 9)].insert((4, 5)).last?.1, 9)
        
        XCTAssertEqual([(1, 2), (3, 5), (6, 7), (8, 10), (12, 16)].insert((4, 8)).count, 3)
        XCTAssertEqual([(1, 2), (3, 5), (6, 7), (8, 10), (12, 16)].insert((4, 8)).first?.0, 1)
        XCTAssertEqual([(1, 2), (3, 5), (6, 7), (8, 10), (12, 16)].insert((4, 8)).first?.1, 2)
        XCTAssertEqual([(1, 2), (3, 5), (6, 7), (8, 10), (12, 16)].insert((4, 8))[1].0, 3)
        XCTAssertEqual([(1, 2), (3, 5), (6, 7), (8, 10), (12, 16)].insert((4, 8))[1].1, 10)
        XCTAssertEqual([(1, 2), (3, 5), (6, 7), (8, 10), (12, 16)].insert((4, 8)).last?.0, 12)
        XCTAssertEqual([(1, 2), (3, 5), (6, 7), (8, 10), (12, 16)].insert((4, 8)).last?.1, 16)
    }
}

IntervalsTests.defaultTestSuite.run()

//: [Next](@next)
