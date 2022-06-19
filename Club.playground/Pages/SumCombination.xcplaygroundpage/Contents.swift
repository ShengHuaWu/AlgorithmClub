//: [Previous](@previous)

import XCTest

final class SumCombinationTests: XCTestCase {
    func testGetSumCombinationCount() {
        var input = [Int]()
        var target = 4
        
        XCTAssertEqual(input.getSumCombinationCount(for: target), 0)
        
        input = [1, 2, 3]
        XCTAssertEqual(input.getSumCombinationCount(for: target), 7)
        
        target = 0
        XCTAssertEqual(input.getSumCombinationCount(for: target), 0)
        
        input = [9]
        target = 3
        XCTAssertEqual(input.getSumCombinationCount(for: target), 0)
    }
    
    func testFindAllSumCombinations() {
        XCTAssertEqual(
            [1, 2, 3].findAllSumCombinations(for: 7),
            [
                [1, 1, 1, 1, 1, 1, 1],
                [1, 1, 1, 1, 1, 2],
                [1, 1, 1, 1, 3],
                [1, 1, 1, 2, 2],
                [1, 1, 2, 3],
                [1, 2, 2, 2],
                [1, 3, 3],
                [2, 2, 3]
            ]
        )
    }
}

SumCombinationTests.defaultTestSuite.run()

//: [Next](@next)
