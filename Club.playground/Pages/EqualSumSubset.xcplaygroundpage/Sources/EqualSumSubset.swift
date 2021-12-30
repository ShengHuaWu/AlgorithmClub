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
        // It must be `reminder >= 0`. Otherewise the logic is wrong
        guard index < self.endIndex, reminder >= 0 else {
            return false
        }
        
        if reminder == 0 {
            return true
        }
        
        return hasEqualSumSubset(at: index + 1, reminder: reminder - self[index]) // Include this element
        || hasEqualSumSubset(at: index + 1, reminder: reminder) // Exclude this element
    }
    
    public func splitIntoEqualSumSubset() -> Self? {
        guard self.count > 1 else {
            return nil
        }
        
        let sum = self.reduce(0, +)
        guard sum.isMultiple(of: 2) else {
            return nil
        }
        
        let result = splitIntoEqualSumSubset(at: 0, reminder: sum / 2, result: [])
        if result.isEmpty {
            return nil
        } else {
            return result
        }
    }
    
    private func splitIntoEqualSumSubset(at index: Int, reminder: Int, result: Self) -> Self {
        // It must be `reminder >= 0`. Otherewise the logic is wrong
        guard index < self.endIndex, reminder >= 0 else {
            return []
        }
        
        if reminder == 0 {
            return result
        }
        
        // Include this element
        let element = self[index]
        let included = splitIntoEqualSumSubset(at: index + 1, reminder: reminder - element, result: result + [element])
        if !included.isEmpty {
            return included
        }
        
        // Exclude this element
        let excluded = splitIntoEqualSumSubset(at: index + 1, reminder: reminder, result: result)
        if !excluded.isEmpty {
            return excluded
        }
        
        return []
    }
}
