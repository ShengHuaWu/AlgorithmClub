import Foundation

// Find Kth Closest Numbers
//
// Given a sorted number array and two integers ‘K’ and ‘X’, find ‘K’ closest numbers to ‘X’ in the array.
// Return the numbers in the sorted order. ‘X’ is not necessarily present in the array.

extension Array where Element == Int {
    // 1. Find the closest index with binary search
    // 2. Choose before and after of the closest
    // 3. If the diffs of the last step are the same, excluding after
    public func findKthClosest(_ k: Int, to key: Int) -> [Int] {
        guard self.count > k else {
            return self
        }
        
        // Find the closest index with binary search
        var start = self.startIndex
        var end = self.endIndex
        
        var closestIndex = start
        
        while start < end {
            closestIndex = start + (end - start) / 2
            let value = self[closestIndex]
            
            if value == key {
                break
            } else if value < key {
                start = closestIndex + 1
            } else {
                end = closestIndex
            }
        }
        
        // Choose before and after of the closest
        var beforeIndex = closestIndex
        var afterIndex = closestIndex
        
        while afterIndex - beforeIndex + 1 < k {
            if beforeIndex == self.startIndex {
                afterIndex += 1
                continue
            }
            
            if afterIndex == self.endIndex - 1 {
                beforeIndex -= 1
                continue
            }
            
            let beforeValue = self[beforeIndex]
            let beforeDiff = abs(key - beforeValue)
            
            let afterValue = self[afterIndex]
            let afterDiff = abs(key - afterValue)
            
            if beforeDiff == afterDiff {
                beforeIndex -= 1
                afterIndex += 1
            } else if beforeDiff > afterDiff {
                afterIndex += 1
            } else {
                beforeIndex -= 1
            }
        }
        
        // If the diffs of the last step are the same, excluding after
        if afterIndex - beforeIndex + 1 > k {
            afterIndex -= 1
        }
        
        return Array(self[beforeIndex...afterIndex])
    }
    
    // 1. Store the difference as the key and the numbers as value
    // 2. Create the result by inserting the smaller number at the beginning and appending the larger number at the end
    // 3. Return only k numbers by droping the larger ones
    public func findKthClosestWithDictionary(_ k: Int, to key: Int) -> [Int] {
        guard self.count > k else {
            return self
        }
        
        // Store the difference as the key and the numbers as value
        var differences: [Int: [Int]] = [:]
        
        for number in self {
            let diff = abs(key - number)
            let diffGroup = differences[diff, default: []]
            differences[diff] = diffGroup + [number]
        }
        
        var result = [Int]()
        var diff = 0
        
        while result.count < k {
            defer { diff += 1}
            
            guard let diffGroup = differences[diff] else {
                continue
            }
            
            guard !result.isEmpty else {
                result = diffGroup
                continue
            }
            
            // Create the result by
            // inserting the smaller number at the beginning
            // and appending the larger number at the end
            for number in diffGroup {
                if number < result.first! {
                    result = [number] + result
                } else if number > result.last! {
                    result.append(number)
                } else {
                    fatalError("Should not happen because the original array is sorted")
                }
            }
        }
        
        return Array(result[...(k-1)]) // Return only k numbers by droping the larger ones
    }
}
