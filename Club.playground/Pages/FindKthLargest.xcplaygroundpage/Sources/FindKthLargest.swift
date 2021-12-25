import Foundation

// Efficiently find the Kth largest element in an integer array
extension Array where Element == Int {
    public func findKthLargest(_ k: Int) -> Int? {
        guard !self.isEmpty else {
            return nil
        }
        
        let nonDuplicates = self.removeDuplicates()
        
        guard nonDuplicates.count > k else {
            return self.min()
        }
        
        return nonDuplicates.sorted(by: >)[k-1]
    }
}

extension Array where Element: Hashable {
    func removeDuplicates() -> Self {
        var uniques = Set<Element>()
        
        return filter { element in
            if uniques.contains(element) {
                return false
            } else {
                uniques.insert(element)
                return true
            }
        }
    }
}
