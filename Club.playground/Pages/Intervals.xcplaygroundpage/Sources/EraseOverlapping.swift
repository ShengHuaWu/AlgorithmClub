import Foundation

// Given an array of intervals `[(start, end)]`,
// return the minimum number of intervals
// you need to remove to make the rest of the intervals non-overlapping.

extension Array where Element == (Int, Int) {
    public func eraseOverlapping() -> Int {
        guard !self.isEmpty else {
            return 0
        }
        
        let sorted = self.sorted { $0.0 < $1.0 } // Sorted by start
        var count = 0
        var temp = [sorted.first!]
        for interval in sorted[1...] {
            let last = temp.removeLast()
            
            guard last.1 > interval.0 else {
                temp.append(contentsOf: [last, interval])
                continue
            }
            
            count += 1 // If `last` & `interval` are overlapping, increase `count`
            
            // Drop the one with larger end, because we want minimum number of removal
            if last.1 > interval.1 {
                temp.append(interval)
            } else {
                temp.append(last)
            }
        }
        
        return count
    }
}

// MARK: - Tests

import XCTest

public final class EraseOverlappingTests: XCTestCase {
    func testEraseOverlapping() {
        XCTAssertEqual([(Int, Int)]().eraseOverlapping(), 0)
        
        XCTAssertEqual([(1, 2), (2, 3), (3, 4), (1, 3)].eraseOverlapping(), 1)
        XCTAssertEqual([(1, 2), (1, 2), (1, 2)].eraseOverlapping(), 2)
        XCTAssertEqual([(1, 2), (2, 3)].eraseOverlapping(), 0)
        XCTAssertEqual([(1, 4), (3, 6), (2, 3)].eraseOverlapping(), 1)
        XCTAssertEqual([(1, 4), (3, 6), (2, 5)].eraseOverlapping(), 2)
        XCTAssertEqual([(1, 4), (5, 6), (2, 6)].eraseOverlapping(), 1)
    }
}
