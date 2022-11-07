import Foundation

// There is an integer array `nums` sorted in ascending order (with distinct values).
// Prior to being passed to your function,
// `nums` is possibly rotated at an unknown pivot index k (1 <= k < nums.length)
// such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed).
// For example, [0,1,2,4,5,6,7] might be rotated at pivot index 3 and become [4,5,6,7,0,1,2].
// Given the array nums after the possible rotation and an integer target,
// return the index of target if it is in `nums`, or `nil` if it is not in `nums`.
extension Array where Element: Comparable {
    public func search(_ target: Element) -> Int? {
        var start = 0
        var end = self.count - 1
        while start <= end { // Consider array with only one element
            let mid = (end - start) / 2 + start
            let midValue = self[mid]
            let startValue = self[start]
            let endValue = self[end]
            
            if target == midValue {
                return mid
            }
            
            if startValue <= midValue {
                // Left part
                if target > midValue || target < startValue {
                    start = mid + 1
                } else {
                    end = mid - 1
                }
            } else {
                // Right part
                if target < midValue || target > endValue {
                    end = mid - 1
                } else {
                    start = mid + 1
                }
            }
            
        }
        
        return nil
    }
}

// Given the array nums after the possible rotation, return the minimun element in `nums`.
extension Array where Element: Comparable {
    public func min() -> Element? {
        guard let first = self.first else {
            return nil
        }
        
        if self.count == 1 {
            return first
        }
        
        var result = first
        var start = self.startIndex
        var end = self.endIndex - 1
        
        while start < end {
            let startValue = self[start]
            let endValue = self[end]
            
            let mid = start + (end - start) / 2
            let midValue = self[mid]
            
            if midValue <= startValue {
                start = mid + 1
                result = Swift.min(midValue, result)
            } else if midValue > startValue {
                if startValue < endValue {
                    end = mid
                } else {
                    start = mid + 1
                }
            }
        }
        
        return Swift.min(result, self[start])
    }
}

// Given the array nums after the possible rotation, return the maximun element in `nums`.
extension Array where Element: Comparable {
    public func max() -> Element? {
        guard let first = self.first else {
            return nil
        }
        
        if self.count == 1 {
            return first
        }
        
        var result = first
        var start = self.startIndex
        var end = self.endIndex - 1
        
        while start < end {
            let startValue = self[start]
            
            let mid = start + (end - start) / 2
            let midValue = self[mid]
            
            if midValue <= startValue {
                end = mid
            } else if midValue > startValue {
                start = mid + 1
                result = Swift.max(midValue, result)
            }
        }
        
        return Swift.max(result, self[start])
    }
}

// MARK: - Tests

import XCTest

public final class RotatedSortedArrayTests: XCTestCase {
    func testSearch() {
        var source = [Int]()
        XCTAssertNil(source.search(9))
        
        source = [1]
        XCTAssertNil(source.search(0))
        XCTAssertEqual(source.search(1), 0)
        
        source = [3, 1]
        XCTAssertNil(source.search(0))
        XCTAssertEqual(source.search(1), 1)
        XCTAssertEqual(source.search(3), 0)
        
        source = [4, 5, 6, 7, 0, 1, 2]
        XCTAssertNil(source.search(3))
        XCTAssertEqual(source.search(0), 4)
        
        source = [5, 6, 7, 1, 2, 3, 4]
        XCTAssertNil(source.search(8))
        XCTAssertEqual(source.search(6), 1)
        XCTAssertEqual(source.search(3), 5)
        XCTAssertEqual(source.search(2), 4)
        
        source = [4, 5, 6, 7, 8, 1, 2, 3]
        XCTAssertNil(source.search(9))
        XCTAssertEqual(source.search(8), 4)
        XCTAssertEqual(source.search(1), 5)
        XCTAssertEqual(source.search(5), 1)
    }
    
    func testMin() {
        var source = [Int]()
        XCTAssertNil(source.min())
        
        source = [1]
        XCTAssertEqual(source.min(), 1)
        
        source = [4, 5, 6, 7, 0, 1, 2]
        XCTAssertEqual(source.min(), 0)
        
        source = [5, 6, 7, 1, 2, 3, 4]
        XCTAssertEqual(source.min(), 1)
    }
    
    func testMax() {
        var source = [Int]()
        XCTAssertNil(source.max())
        
        source = [1]
        XCTAssertEqual(source.max(), 1)
        
        source = [4, 5, 6, 7, 0, 1, 2]
        XCTAssertEqual(source.max(), 7)
        
        source = [5, 6, 7, 1, 2, 3, 4]
        XCTAssertEqual(source.max(), 7)
    }
}

