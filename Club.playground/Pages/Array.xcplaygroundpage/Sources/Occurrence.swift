import Foundation

// Sort the array at first.
// Then, use two binary search to find out the left boundary and the right boundary.
extension Array where Element: Comparable {
    public func occurrence(of key: Element) -> Index {
        return rightBoundary(of: key) - leftBoundary(of: key)
    }
    
    private func rightBoundary(of key: Element) -> Index {
        var start = startIndex
        var end = endIndex
        
        while start < end {
            let mid = start + (end - start) / 2
            if self[mid] > key {
                end = mid
            } else {
                start = mid + 1
            }
        }
        
        return start
    }
    
    private func leftBoundary(of key: Element) -> Index {
        var start = startIndex
        var end = endIndex
        
        while start < end {
            let mid = start + (end - start) / 2
            if self[mid] < key {
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

public final class OccurrenceTests: XCTestCase {
    func testOccurrence() {
        XCTAssertEqual([-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11].occurrence(of: 2), 4)
        XCTAssertEqual([-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11].occurrence(of: 0), 1)
        XCTAssertEqual([-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11].occurrence(of: 1), 0)
    }
}
