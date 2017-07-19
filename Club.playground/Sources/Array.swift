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

// Given an integer array, separate the non-zero elements and the zeros. 
// There are two solutions:
// 1. Use another array to store the non-zero elements and then add the zeros back.
// 2. Use a variable to record the count of the non-zero elements. 
//  If encounter an non-zero element, replace the element at index "count" with the elements.
//  Finally, all non-zero elements are shifted to the front, so "count" is the index of the first zero.
extension Array where Element == Int {
    public func shiftingZeros() -> [Element] {
        var result = [Element]()
        for element in self {
            if element != 0 {
                result.append(element)
            }
        }
        
        while result.count < count {
            result.append(0)
        }
        
        return result
    }
    
    public mutating func shiftZeros() {
        var nonZeroCount = 0
        
        for index in indices {
            if self[index] != 0 {
                self[nonZeroCount] = self[index]
                nonZeroCount += 1
            }
        }
        
        while nonZeroCount < count {
            self[nonZeroCount] = 0
            nonZeroCount += 1
        }
    }
}
