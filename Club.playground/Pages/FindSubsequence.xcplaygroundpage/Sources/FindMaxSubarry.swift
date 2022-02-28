import Foundation

// Given an integer array nums, find the contiguous subarray (containing at least one number)
// which has the largest sum and return its sum. A subarray is a contiguous part of an array.

extension Array where Element == Int {
    public func getMaxSubarraySum() -> Int {
        guard let first = self.first else {
            return 0
        }
        
        var element: Int
        var sum = first
        var max = sum
        
        for index in 1 ..< self.count {
            element = self[index]
            sum += element
            max = Swift.max(max, sum)
            
            // Update `sum` after comparison
            if sum <= 0 {
                sum = 0
            }
        }
        
        return max
    }
}
