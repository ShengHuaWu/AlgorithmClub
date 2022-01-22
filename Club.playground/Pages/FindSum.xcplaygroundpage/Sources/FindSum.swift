import Foundation

// Find Sum of Two Elements in Array

extension Array where Element == Int {
    // Use a dictionary to store the following:
    // - Key: difference between each element in the array and the sum k
    // - Value: the index of each element
    // - Time and space complexity are both O(n).
    public func indices(of sum: Int) -> (Int, Int)? {
        var differences: [Int: Int] = [:]
        
        for index in self.indices {
            let number = self[index]
            if let anotherIndex = differences[number] {
                return (anotherIndex, index)
            } else {
                differences[sum - number] = index
            }
        }
        
        return nil
    }
    
    // If we only need to check whether there are two elements and their sum is equal to the requirment,
    // then sort the array at first and use two variables to track the sum of the first and the last element:
    // - Time complexity depends on the sorting method. It's usually O(n log n).
    public func hasTwoElements(of sum: Int) -> Bool {
        let sorted = self.sorted()
        
        var firstIndex = sorted.startIndex
        var lastIndex = sorted.endIndex - 1
        
        while firstIndex < lastIndex {
            let temp = sorted[firstIndex] + sorted[lastIndex]
            if temp == sum {
                return true
            } else if temp > sum  {
                lastIndex -= 1
            } else {
                firstIndex += 1
            }
        }
        
        return false
    }
}
