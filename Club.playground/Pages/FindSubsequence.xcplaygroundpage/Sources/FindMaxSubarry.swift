import Foundation

// Given an integer array, find the contiguous subarray (containing at least one number)
// which has the largest sum and return its sum. A subarray is a contiguous part of an array.

extension Array where Element == Int {
    public func getMaxSubarraySum() -> Int {
        guard let first = self.first else {
            return 0
        }
        
        var sum = first
        var max = sum
        
        for index in 1 ..< self.count {
            let element = self[index]
            sum += element
            max = Swift.max(max, sum)
            
            // Update `sum` after comparison
            if sum <= 0 {
                sum = 0
            }
        }
        
        return max
    }
    
    // Given an array of positive numbers and a positive number ‘k’,
    // find the maximum sum of any contiguous subarray of size ‘k’
    public func getMaxSubarraySum(with size: Int) -> Int {
        guard self.count >= size else {
            return self.reduce(0, +)
        }
        
        return Swift.max(
            self[..<size].reduce(0, +),
            Array(dropFirst()).getMaxSubarraySum(with: size)
        )
    }
}

// Given an integer array, find a contiguous non-empty subarray within the array
// that has the largest product, and return the product. A subarray is a contiguous subsequence of the array.
// The test cases are generated so that the answer will fit in a 32-bit integer.

extension Array where Element == Int {
    // We have to consider both directions: from start to end & from end to start
    // It's because multiple two negative integers will get a positive product
    public func getMaxSubarrayProduct() -> Int {
        guard !self.isEmpty else {
            return 0
        }
        
        var product = 1
        var max = Int.min
        
        for index in 0 ..< self.count {
            product *= self[index]
            max = Swift.max(max, product)
            
            if product == 0 {
                product = 1
            }
        }
        
        product = 1
        
        let reversed = (0 ..< self.count).reversed()
        for index in reversed {
            product *= self[index]
            max = Swift.max(max, product)

            if product == 0 {
                product = 1
            }
        }
        
        return max
    }
}
