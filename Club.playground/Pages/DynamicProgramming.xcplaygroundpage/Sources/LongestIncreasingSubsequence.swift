import Foundation

extension Array where Element: Comparable {
    // Dynamic programming
    // https://www.geeksforgeeks.org/longest-increasing-subsequence-dp-3/
    //
    // Time complexity: O(N * N), where N is the length of the input array
    // Space complexity: O(N)
    public func findLongestIncreasingSubsequence() -> Int {
        guard !self.isEmpty else {
            return 0
        }
        
        // The key point of this array is reducing duplicated calculations
        var temp = Array<Int>(repeating: 1, count: self.count)
        
        for index in 1 ..< self.count {
            for previous in 0 ..< index {
                guard self[previous] < self[index] else {
                    continue
                }
                
                temp[index] = Swift.max(temp[index], temp[previous] + 1)
            }
        }
        
        return temp.max()!
    }
}
