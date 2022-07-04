import Foundation

// Find Longest Consecutive Subsequence
//
// Given an array of numbers, find the longest consecutive subsequence.

extension Array where Element == Int {
    public func findLongestConsecutiveSubsequence() -> [Int] {
        guard self.count > 1 else {
            return self
        }
        
        // Define the range of the return indices
        var start = self.startIndex
        var end = start
        
        // Define the range of the window in each loop
        var low = start
        var high = low
        
        var previous = self[high]
        
        while high < self.endIndex {
            if previous == self[high] - 1, end - start < high - low {
                start = low
                end = high
            } else {
                low = high
            }
            
            previous = self[high]
            high += 1
        }
        
        return Array(self[start...end])
    }
    
    // What if it is asking to find the second longest consecutive subsequence
    //
    // 1. Find the longest one with the logic above
    // 2. Remove the longest one
    // 3. Find the longest again
}

// MARK: - Tests

import XCTest

public final class FindLongestConsecutiveSubsequenceTests: XCTestCase {
    func testFindLongestConsecutiveSubsequence() {
        XCTAssertTrue([Int]().findLongestConsecutiveSubsequence().isEmpty)
        XCTAssertEqual([1].findLongestConsecutiveSubsequence(), [1])
        XCTAssertEqual([-1, 7, 3, 5, 1, 2, 3, 4, -2, 9, 19, 0].findLongestConsecutiveSubsequence(), [1, 2, 3, 4])
        XCTAssertEqual([1, 2, 3, 4, -2, 9, 19, 0, -1, 7, 3, 5].findLongestConsecutiveSubsequence(), [1, 2, 3, 4])
        XCTAssertEqual([-2, 9, 19, 0, -1, 7, 3, 5, 1, 2, 3, 4].findLongestConsecutiveSubsequence(), [1, 2, 3, 4])
    }
}
