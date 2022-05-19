//: [Previous](@previous)

import XCTest

final class SortedSquaresTests: XCTestCase {
    func testGetSortedSquares() {
        var input: [Int] = []
        
        XCTAssertTrue(input.getSortedSquares().isEmpty)
        
        input = [1, 2, 3, 4, 5]
        
        XCTAssertEqual(input.getSortedSquares(), [1, 4, 9, 16, 25])
        
        input = [-4, -2, 1, 2, 3, 4, 5]
        
        XCTAssertEqual(input.getSortedSquares(), [1, 4, 4, 9, 16, 16, 25])
    }
}

SortedSquaresTests.defaultTestSuite.run()

//: [Next](@next)
