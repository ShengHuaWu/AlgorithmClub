import Foundation

// Write a function which takes a sorted array as input and outputs sorted squares.
// For example, given [-2, -1, 1, 3, 4, 8] will return [1, 1, 4, 9, 16, 64]
extension Array where Element == Int {
    public func getSortedSquares() -> Self {
        guard !self.isEmpty else {
            return self
        }
                
        var start = self.startIndex
        var end = self.endIndex - 1 // `endIndex` is NOT included
        var result = [Int]()
        
        while start < end {
            let startSquare = self[start] * self[start]
            let endSquare = self[end] * self[end]
            
            if startSquare > endSquare {
                result = [startSquare] + result
                start += 1
            } else if startSquare < endSquare {
                result = [endSquare] + result
                end -= 1
            } else {
                result = [startSquare, endSquare] + result
                start += 1
                end -= 1
            }
        }
        
        // Insert the last at the beginning
        let startSquare = self[start] * self[start]
        result = [startSquare] + result
        
        return result
    }
}

// MARK: - Tests

import XCTest

public final class SortedSquaresTests: XCTestCase {
    func testGetSortedSquares() {
        var input: [Int] = []
        
        XCTAssertTrue(input.getSortedSquares().isEmpty)
        
        input = [1, 2, 3, 4, 5]
        
        XCTAssertEqual(input.getSortedSquares(), [1, 4, 9, 16, 25])
        
        input = [-4, -2, 1, 2, 3, 4, 5]
        
        XCTAssertEqual(input.getSortedSquares(), [1, 4, 4, 9, 16, 16, 25])
    }
}
