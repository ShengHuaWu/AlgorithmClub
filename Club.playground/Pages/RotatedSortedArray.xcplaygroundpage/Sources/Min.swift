import Foundation

// There is an integer array `nums` sorted in ascending order (with distinct values).
// Prior to being passed to your function,
// `nums` is possibly rotated at an unknown pivot index k (1 <= k < nums.length)
// such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed).
// For example, [0,1,2,4,5,6,7] might be rotated at pivot index 3 and become [4,5,6,7,0,1,2].
// Given the array nums after the possible rotation, return the minimun element in `nums`.

extension Array where Element: Comparable {
    // TODO: This is not working yet
    public func min() -> Element? {
        guard let first = self.first else {
            return nil
        }
        
        if self.count == 1 {
            return first
        }
        
        var start = self.startIndex
        var end = self.endIndex - 1
        
        while start < end {
            let startValue = self[start]
            let endValue = self[end]
            
            let mid = start + (end - start) / 2
            let midValue = self[mid]
            
            if midValue <= startValue {
                end = mid
            } else if midValue > startValue {
                if startValue < endValue {
                    end = mid
                } else {
                    start = mid + 1
                }
            }
        }
        
        return self[start]
    }
}
