import Foundation

// Equal Subset Sum Partition
//
// Given a list of positive numbers,
// find if we can partition it into two subsets
// such that the sum of elements in both subsets is equal.

extension Array where Element == Int {
    public func hasEqualSumSubset() -> Bool {
        guard self.count > 1 else {
            return false
        }
        
        let sum = self.reduce(0, +)
        guard sum.isMultiple(of: 2) else {
            return false
        }
        
        return hasEqualSumSubset(at: 0, reminder: sum / 2)
    }
    
    private func hasEqualSumSubset(at index: Int, reminder: Int) -> Bool {
        guard index < self.endIndex, reminder > 0 else {
            return false
        }
        
        if reminder == 0 {
            return true
        }
        
        
        return hasEqualSumSubset(at: index + 1, reminder: reminder - self[index]) // Include this element
        || hasEqualSumSubset(at: index + 1, reminder: reminder) // Exclude this element
    }
}
