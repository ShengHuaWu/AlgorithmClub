import Foundation

// The array must be sorted before binary searching. The time complexity is O(log n).
extension Array where Element: Comparable {
    public func binarySearch(for key: Element) -> Index? {
        var start = startIndex
        var end = endIndex
        
        while start < end {
            let mid = start + (end - start) / 2
            if self[mid] == key {
                return mid
            } else if self[mid] > key {
                end = mid
            } else {
                start = mid + 1
            }
        }
        
        return nil
    }
    
    public func recursiveBinarySearch(for key: Element) -> Index? {
        return recursiveBinarySearch(for: key, with: startIndex ..< endIndex)
    }
    
    private func recursiveBinarySearch(for key: Element, with range: Range<Index>) -> Index? {
        guard range.lowerBound < range.upperBound else { return nil }
        
        let mid = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        if self[mid] == key {
            return mid
        } else if self[mid] > key {
            return recursiveBinarySearch(for: key, with: range.lowerBound ..< mid)
        } else {
            return recursiveBinarySearch(for: key, with: mid + 1 ..< range.upperBound)
        }
    }
}
