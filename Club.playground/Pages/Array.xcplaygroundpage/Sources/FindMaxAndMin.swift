import Foundation

// Find both the maximum and minimum values contained in array
// while minimizing the number of comparisons we can compare the items in pairs.

extension Array where Element: Comparable {
    public func findMaxAndMin() -> (Element, Element)? {
        guard !self.isEmpty else {
            return nil
        }
        
        var copy = self
        if !copy.count.isMultiple(of: 2) {
            copy.append(copy.first!)
        }
        
        var max: Element = copy.first!
        var min: Element = max
        
        while !copy.isEmpty {
            let first = copy.removeFirst()
            let second = copy.removeFirst()
            
            if first > second {
                max = Swift.max(first, max)
                min = Swift.min(second, min)
            } else {
                max = Swift.max(second, max)
                min = Swift.min(first, min)
            }
        }
        
        return (max, min)
    }
}

// MARK: - Tests

import XCTest

public final class FindMaxAndMinTests: XCTestCase {
    func testFindMaxAndMin() {
        XCTAssertNil([Int]().findMaxAndMin())
        
        
        let result = [10, 6, 2, 7, 8, -1, 7, 14, 9, 0, -1, 2, 4, 5, 14, 9, 10].findMaxAndMin()
        XCTAssertEqual(result?.0, 14)
        XCTAssertEqual(result?.1, -1)
    }
}
