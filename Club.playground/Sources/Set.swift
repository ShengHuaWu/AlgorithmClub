import Foundation

// Equal Subset Sum Partition
//
// Given a set of positive numbers,
// find if we can partition it into two subsets such that the sum of elements in both subsets is equal.
extension Set where Element == Int {
    // This approach doesn't work for Array
    public func findSubsetsWithEqualSum() -> (Set<Int>, Set<Int>)? {
        guard !isEmpty else {
            return nil
        }
        
        let sorted = Array(self).sorted()
        
        let start = sorted.startIndex
        let end = sorted.endIndex - 1
        var mid = start + (end - start) / 2
        var sumOfFirstPart = sorted[start ... mid].reduce(0, +)
        var sumOfSecondPart = sorted[mid+1 ... end].reduce(0, +)
        
        while sumOfFirstPart < sumOfSecondPart, mid < end {
            mid += 1
            sumOfFirstPart += sorted[mid]
            sumOfSecondPart -= sorted[mid]
        }
        
        guard sumOfFirstPart == sumOfSecondPart else {
            return nil
        }
        
        return (Set(sorted[start ... mid]), Set(sorted[mid+1 ... end]))
    }
}
