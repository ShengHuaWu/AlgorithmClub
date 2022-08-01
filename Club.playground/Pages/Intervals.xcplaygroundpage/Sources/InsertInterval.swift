import Foundation

// You are given an array of non-overlapping intervals intervals
// and intervals is sorted in ascending order by start.
// You are also given an interval `newInterval = (start, end)`
// Insert `newInterval` into intervals such that intervals is still sorted in ascending order
// by start and intervals still does not have any overlapping intervals.

extension Array where Element == (Int, Int) {
    public func insert(_ newInterval: (Int, Int)) -> Self {
        guard !self.isEmpty else {
            return [newInterval]
        }
        
        // Insert `newInterval` into the array and keep the order by start
        var temp: Self = []
        var inserted = false // Track `newInterval` is already inserted or not
        for interval in self {
            if inserted {
                temp.append(interval)
                continue
            }
            
            // case of |-interval-| |--newInterval--|
            if newInterval.0 > interval.1 {
                temp.append(interval)
                continue
            }
            
            // case of |--newInterval--| |-interval-|
            if newInterval.1 < interval.0 {
                temp.append(contentsOf: [newInterval, interval])
                inserted = true
                continue
            }
            
            // case of overlapping
            let new = (
                Swift.min(newInterval.0, interval.0),
                Swift.max(newInterval.1, interval.1)
            )
            temp.append(new)
            inserted = true
        }
        
        // The `newInterval` could be the last one
        if !inserted {
            temp.append(newInterval)
        }
        
        // Merge the intervals
        var result = [temp.first!]
        for interval in temp[1...] {
            var lastOfResult = result.removeLast()
            if lastOfResult.1 >= interval.0 {
                lastOfResult.1 = Swift.max(lastOfResult.1, interval.1)
                result.append(lastOfResult)
            } else {
                result.append(contentsOf: [lastOfResult, interval])
            }
        }
        
        return result
    }
}

// MARK: - Tests

import XCTest

public final class InsertIntervalTests: XCTestCase {
    func testInsertInterval() {
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
        
        XCTAssertEqual([(1, 3), (6, 9)].insert((11, 18)).count, 3)
        XCTAssertEqual([(1, 3), (6, 9)].insert((11, 18)).first?.0, 1)
        XCTAssertEqual([(1, 3), (6, 9)].insert((11, 18)).first?.1, 3)
        XCTAssertEqual([(1, 3), (6, 9)].insert((11, 18))[1].0, 6)
        XCTAssertEqual([(1, 3), (6, 9)].insert((11, 18))[1].1, 9)
        XCTAssertEqual([(1, 3), (6, 9)].insert((11, 18)).last?.0, 11)
        XCTAssertEqual([(1, 3), (6, 9)].insert((11, 18)).last?.1, 18)
        
        XCTAssertEqual([(1, 2), (3, 5), (8, 10), (12, 16)].insert((6, 7)).count, 5)
        
        XCTAssertEqual([(1, 2), (3, 5), (6, 7), (8, 10), (12, 16)].insert((4, 8)).count, 3)
        XCTAssertEqual([(1, 2), (3, 5), (6, 7), (8, 10), (12, 16)].insert((4, 8)).first?.0, 1)
        XCTAssertEqual([(1, 2), (3, 5), (6, 7), (8, 10), (12, 16)].insert((4, 8)).first?.1, 2)
        XCTAssertEqual([(1, 2), (3, 5), (6, 7), (8, 10), (12, 16)].insert((4, 8))[1].0, 3)
        XCTAssertEqual([(1, 2), (3, 5), (6, 7), (8, 10), (12, 16)].insert((4, 8))[1].1, 10)
        XCTAssertEqual([(1, 2), (3, 5), (6, 7), (8, 10), (12, 16)].insert((4, 8)).last?.0, 12)
        XCTAssertEqual([(1, 2), (3, 5), (6, 7), (8, 10), (12, 16)].insert((4, 8)).last?.1, 16)
    }
}
