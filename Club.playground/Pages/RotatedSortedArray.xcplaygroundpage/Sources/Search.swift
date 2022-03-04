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
        guard let first = self.first else {
            return nil
        }
        
        if first == target {
            return 0
        }
        
        var start = self.startIndex
        var end = self.endIndex - 1
        
        while start < end {
            let startValue = self[start]
            let endValue = self[end]
            
            let mid = start + (end - start) / 2
            let midValue = self[mid]
            
            if midValue < target {
                if endValue < target {
                    end = mid
                } else if endValue > target {
                    start = mid + 1
                } else {
                    return end
                }
            } else if midValue > target {
                if startValue > target {
                    start = mid + 1
                } else if startValue < target {
                    end = mid
                } else {
                    return start
                }
            } else {
                return mid
            }
        }
        
        return nil
    }
    
    // TODO: Practice recursive approach
}
