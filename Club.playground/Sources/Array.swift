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

// Sort the array at first. 
// Then, use two binary search to find out the left boundary and the right boundary.
extension Array where Element: Comparable {
    public func occurrence(of key: Element) -> Index {
        return rightBoundary(of: key) - leftBoundary(of: key)
    }
    
    private func rightBoundary(of key: Element) -> Index {
        var start = startIndex
        var end = endIndex
        
        while start < end {
            let mid = start + (end - start) / 2
            if self[mid] > key {
                end = mid
            } else {
                start = mid + 1
            }
        }
        
        return start
    }
    
    private func leftBoundary(of key: Element) -> Index {
        var start = startIndex
        var end = endIndex
        
        while start < end {
            let mid = start + (end - start) / 2
            if self[mid] < key {
                start = mid + 1
            } else {
                end = mid
            }
        }
        
        return start
    }
}

// Find both the maximum and minimum values contained in array 
// while minimizing the number of comparisons we can compare the items in pairs.
extension Array where Element: Comparable {
    public func minAndMax() -> (Element, Element)? {
        guard !isEmpty else { return nil }
        
        var copy = self
        var min = copy.first!
        var max = min
        
        if copy.count % 2 != 0 {
            copy.removeFirst()
        }
        
        while !copy.isEmpty {
            let pair = (copy.removeFirst(), copy.removeFirst())
            if pair.0 > pair.1 {
                max = pair.0 > max ? pair.0 : max
                min = pair.1 < min ? pair.1 : min
            } else {
                max = pair.1 > max ? pair.1 : max
                min = pair.0 < min ? pair.0 : min
            }
        }
        
        return (min, max)
    }
}
