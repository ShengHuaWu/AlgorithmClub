import Foundation

// Find the high and low index
//
// Given a sorted array of integers, return the low and high index of the given key.
extension Array where Element == Int {
    public func findHighAndLow(for target: Int) -> (Int, Int)? {
        guard !self.isEmpty else {
            return nil
        }
        
        let low = findLowerBoundary(for: target)
        let high = findUpperBoundary(for: target) - 1
        
        guard low < self.count, high < self.count else {
            return nil // The `target` does not exist in the given array
        }
        
        return (low, high)
    }
    
    private func findUpperBoundary(for target: Int) -> Int {
        var start = self.startIndex
        var end = self.endIndex // `endIndex` is equal to `count`
        
        while start < end {
            let mid = start + (end - start) / 2
            let value = self[mid]
            
            if value > target {
                end = mid
            } else {
                start = mid + 1
            }
        }
        
        return start
    }
    
    private func findLowerBoundary(for target: Int) -> Int {
        var start = self.startIndex
        var end = self.endIndex // `endIndex` is equal to `count`
        
        while start < end {
            let mid = start + (end - start) / 2
            let value = self[mid]
            
            if value < target {
                start = mid + 1
            } else {
                end = mid
            }
        }
        
        return start
    }
}

// MARK: - Tests

import XCTest

public final class FindLowAndHighTests: XCTestCase {
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
