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
