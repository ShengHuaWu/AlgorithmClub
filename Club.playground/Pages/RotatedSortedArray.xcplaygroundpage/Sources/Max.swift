import Foundation

// There is an integer array `nums` sorted in ascending order (with distinct values).
// Prior to being passed to your function,
// `nums` is possibly rotated at an unknown pivot index k (1 <= k < nums.length)
// such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed).
// For example, [0,1,2,4,5,6,7] might be rotated at pivot index 3 and become [4,5,6,7,0,1,2].
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
import Foundation

