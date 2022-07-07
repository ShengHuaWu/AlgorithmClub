import Foundation

// Efficiently find the Kth largest element in an integer array
extension Array where Element == Int {
    // Time complexity: O(N log N) because of sorting
    // Space complexity: O(N) because of removing duplicates
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
    
    // Time complexity: O(K * N)
    // Space complexity: O(N)
    public func findKthLargestWithoutSorting(_ k: Int) -> Int? {
        guard !self.isEmpty else {
            return nil
        }
        
        var set = Set<Element>.init(self)
        
        guard set.count > k else {
            return set.min()
        }
        
        var temp = k
        var result = Int.min
        while temp > 0, let max = set.max() {
            set.remove(max)
            result = max
            temp -= 1
        }
        
        return result
    }
}

// MARK: - Tests

import XCTest

public final class FindKthLargest: XCTestCase {
    func testFindKthLargest() {
        var target = [Int]()
        XCTAssertNil(target.findKthLargest(1))
        XCTAssertNil(target.findKthLargestWithoutSorting(1))
        
        target = [2, 1, 3, 1, 3, 2]
        XCTAssertEqual(target.findKthLargest(4), 1)
        XCTAssertEqual(target.findKthLargestWithoutSorting(4), 1)
        XCTAssertEqual(target.findKthLargest(3), 1)
        XCTAssertEqual(target.findKthLargestWithoutSorting(3), 1)
        XCTAssertEqual(target.findKthLargest(2), 2)
        XCTAssertEqual(target.findKthLargestWithoutSorting(2), 2)
        
        target = [0, -1, 2, 9, 7, 4]
        XCTAssertEqual(target.findKthLargest(3), 4)
        XCTAssertEqual(target.findKthLargestWithoutSorting(3), 4)
        XCTAssertEqual(target.findKthLargest(9), -1)
        XCTAssertEqual(target.findKthLargestWithoutSorting(9), -1)
    }
}
