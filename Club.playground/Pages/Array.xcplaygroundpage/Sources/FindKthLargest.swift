import Foundation

// Efficiently find the Kth largest element in an integer array
extension Array where Element == Int {
    public func findKthLargest(_ k: Int) -> Int? {
        guard !self.isEmpty else {
            return nil
        }
        
        let nonDuplicates = self.removeDuplicates()
        
        guard nonDuplicates.count > k else {
            return self.min()
        }
        
        return nonDuplicates.sorted(by: >)[k-1]
    }
}

// MARK: - Tests

import XCTest

public final class FindKthLargest: XCTestCase {
    func testFindKthLargest() {
        var target = [Int]()
        XCTAssertNil(target.findKthLargest(1))
        
        target = [2, 1, 3, 1, 3, 2]
        XCTAssertEqual(target.findKthLargest(4), 1)
        XCTAssertEqual(target.findKthLargest(3), 1)
        XCTAssertEqual(target.findKthLargest(2), 2)
        
        target = [0, -1, 2, 9, 7, 4]
        XCTAssertEqual(target.findKthLargest(3), 4)
        XCTAssertEqual(target.findKthLargest(9), -1)
    }
}
