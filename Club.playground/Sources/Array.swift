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

// Find Sum of Two Elements in Array
// 1. Use a dictionary to store the following:
// - Key: difference between each element in the array and the sum k
// - Value: the index of each element
// - Time and space complexity are both O(n).
// 2. Sort the array at first and use two variables to track the sum of the first and the last element.
// - Time complexity depends on the sorting method. It's usually O(n log n).
extension Array where Element == Int {
    public func indices(for sum: Element) -> (Index, Index)? {
        guard !isEmpty else { return nil }
        
        var dictionary = [Element : Index]()
        for index in indices {
            if let previousIndex = dictionary[self[index]] {
                return (previousIndex, index)
            } else {
                dictionary[sum - self[index]] = index
            }
        }
        
        return nil
    }
    
    public func indicesAfterSorting(for sum: Element) -> (Index, Index)? {
        guard !isEmpty else { return nil }
        
        var min = startIndex
        var max = endIndex - 1
        while min < max {
            let temp = self[min] + self[max]
            if temp > sum {
                max -= 1
            } else if temp < sum {
                min += 1
            } else {
                return (min, max)
            }
        }
        
        return nil
    }
}

// Find Maximum Perimeter
// Given a batch of edges, find the maximum triangle perimeter of those edges.
// 1. Sort the edges at first.
// 2. Get the largest three edges and check whether these three edges can construct a triangle or not.
// 3. If they can form a triangle, their sum is the maximum perimeter.
// 4. If they cannot form a triangle, drop the largest edge and grab the fourth large edge.
extension Array where Element == Int {
    public func maxPerimeters() -> (Element, Element, Element)? {
        guard !isEmpty else { return nil }
        
        let sortedEdges = sorted()
        var index = endIndex - 1
        while index > startIndex {
            if sortedEdges[index - 2] + sortedEdges[index - 1] > sortedEdges[index] {
                return (sortedEdges[index - 2], sortedEdges[index - 1], sortedEdges[index])
            }
            
            index += 1
        }
        
        return nil
    }
    
    public func findLargestPerimetersSum() -> Int? {
        let sortedSelf = sorted(by: >)
        var index = startIndex
        
        while index + 2 < endIndex {
            let p1 = sortedSelf[index]
            let p2 = sortedSelf[index + 1]
            let p3 = sortedSelf[index + 2]
            if p1 < p2 + p3 {
                return p1 + p2 + p3
            } else {
                index += 1
            }
        }
        
        return nil
    }
    
    public func recursiveFindLargestPerimetersSum() -> Int? {
        return sorted(by: >).recursiveFindLargestPerimetersSum(start: startIndex)
    }
    
    private func recursiveFindLargestPerimetersSum(start: Index) -> Int? {
        guard start + 2 < endIndex else { return nil }
        
        let p1 = self[start]
        let p2 = self[start + 1]
        let p3 = self[start + 2]
        if p1 < p2 + p3 {
            return p1 + p2 + p3
        } else {
            return recursiveFindLargestPerimetersSum(start: start + 1)
        }
    }
}

// Print Compression
// The array should be sorted at first.
extension Array where Element == Int {
    public func printCompressionNumbers() {
        guard !isEmpty else { return }
        
        var start = first!
        var end = start
        for number in self[1 ..< endIndex] {
            if number != end + 1 {
                printElement(from: start, to: end)
                start = number
            }
            end = number
        }
        printElement(from: start, to: end)
    }
    
    private func printElement(from start: Element, to end: Element) {
        if start == end {
            print("\(start)")
        } else {
            print("\(start) - \(end)")
        }
    }
    
    public func compress() -> [String] {
        var results = [String]()
        var start = startIndex
        var index = startIndex + 1
        
        while index < endIndex {
            if self[index] != self[index - 1] + 1 {
                let output = compressNumber(start: start, end: index)
                results.append(output)
                start = index
            }
            
            index += 1
        }
        
        if start == index {
            results.append("\(self[index])")
        } else {
            let output = compressNumber(start: start, end: index)
            results.append(output)
        }
        
        return results
    }
    
    public func recursiveCompress() -> [String] {
        return recursiveCompress(start: startIndex, end: startIndex + 1, result: [])
    }
    
    private func recursiveCompress(start: Index, end: Index, result: [String]) -> [String] {
        guard end < endIndex else {
            return result + [compressNumber(start: start, end: end)]
        }
        
        if self[end] - self[end - 1] > 1 {
            return [compressNumber(start: start, end: end)] + recursiveCompress(start: end, end: end + 1, result: result)
        } else {
            return recursiveCompress(start: start, end: end + 1, result: result)
        }
    }
    
    private func compressNumber(start: Index, end: Index) -> String {
        return self[start] == self[end - 1] ? "\(self[start])" : "\(self[start])-\(self[end - 1])"
    }
}

// Quick Sort
// The time complexity is O(n log n).
// 1. Split the array into three parts based on a pivot variable.
// 2. All the elements less than the pivot go into a new array called less. 
//  All the elements equal to the pivot go into the equal array. 
//  All elements greater than the pivot go into the greater array.
// 3. Once we have these three arrays, quick sort recursively sorts the less array 
//  and the greater array, then glues those sorted subarrays back together 
//  with the equal array to get the final result.
extension Array where Element: Comparable {
    public func quickSorting() -> [Element] {
        guard count > 1 else { return self }
        
        let pivot = self[count / 2]
        let less = filter { $0 < pivot }
        let equal = filter { $0 == pivot }
        let greater = filter { $0 > pivot }
        
        return less.quickSorting() + equal + greater.quickSorting()
    }
}

// Merge Sort
// Divide and conquer. This is NOT an in-place sort. The time complexity is O(n log n).
// 1. Split the array into two unsorted piles.
// 2. Keep splitting the resulting piles until you cannot split anymore. 
//  In the end, you will have n piles with one number in each pile.
// 3. Begin to merge the piles together by pairing them sequentially. 
//  During each merge, put the contents in sorted order.
extension Array where Element: Comparable {
    public func mergeSorting() -> [Element] {
        guard count > 1 else { return self }
        
        let mid = count / 2
        let left = Array(self[0 ..< mid]).mergeSorting()
        let right = Array(self[mid ..< count]).mergeSorting()
        
        return left.merging(with: right)
    }
    
    private func merging(with pile: [Element]) -> [Element] {
        var selfIndex = startIndex
        var pileIndex = pile.startIndex
        var results = [Element]()
        
        while selfIndex < count && pileIndex < pile.count {
            let selfElement = self[selfIndex]
            let pileElement = pile[pileIndex]
            if selfElement < pileElement {
                results.append(selfElement)
                selfIndex += 1
            } else if selfElement > pileElement {
                results.append(pileElement)
                pileIndex += 1
            } else {
                results.append(selfElement)
                selfIndex += 1
                results.append(pileElement)
                pileIndex += 1
            }
        }
        
        while selfIndex < count {
            results.append(self[selfIndex])
            selfIndex += 1
        }
        
        while pileIndex < pile.count {
            results.append(pile[pileIndex])
            pileIndex += 1
        }
        
        return results
    }
}

// Array Intersection
// Sort two arrays at first and then use the logic of merge sort to generate the intersection.
extension Array where Element: Comparable {
    public func intersecting(with pile: [Element]) -> [Element] {
        guard !isEmpty, !pile.isEmpty else { return [] }
        
        let sortedSelf = sorted()
        let sortedPile = pile.sorted()
        
        var result = [Element]()
        var index = sortedSelf.startIndex
        var pileIndex = sortedPile.startIndex
        
        while index < sortedSelf.endIndex && pileIndex < sortedPile.endIndex {
            let element = sortedSelf[index]
            let pileElement = sortedPile[pileIndex]
            
            if element == pileElement {
                result.append(element)
                index += 1
                pileIndex += 1
            } else if element < pileElement {
                index += 1
            } else {
                pileIndex += 1
            }
        }
        
        return result
    }
}

// Counting Sort
// 1. The first step is to count the total number of occurrences for each item in the array.
// 2. Tries to determine the number of elements that are placed before each element.
//  The way it works is to sum up the previous counts and store them at each index.
// 3. Each element in the original array is placed at the position defined by the output of step 2.
extension Array where Element == Int {
    public func countingSorting() -> [Element] {
        guard !isEmpty else { return [] }
        
        let maxElement = self.max() ?? 0
        
        var countArray = [Index](repeating: 0, count: Int(maxElement + 1))
        for element in self {
            countArray[element] += 1
        }
        
        for index in 1 ..< countArray.count {
            let sum = countArray[index - 1] + countArray[index]
            countArray[index] = sum
        }
        
        var sortedArray = [Element](repeating: 0, count: count)
        for element in self {
            countArray[element] -= 1
            sortedArray[countArray[element]] = element
        }
        
        return sortedArray
    }
}

// Find subset from an array of integers
//
// Split the original array into two subsets A and B:
// The intersection of A and B is empty.
// The union of A and B is the original array.
// The number of element in A should be as less as possible.
// The sum of A is greater than the sum of B.
// A should be increasing order.
// Write a function to find the subset A.
extension Array where Element == Int {
    public func findSubset() -> [Int] {
        /* first thought:
         Sort the original array and start from the largest element.
         However, the time complexity is too high.
        */
        fatalError()
    }
}

// Find largest size after removal
//
// There is a n x m mesh storage and each cell is 1 x 1 size.
// We are going to remove h number of the horizontal lines and v number of the vertical lines.
// For instance, n = 3, m = 3, h = [1] and v = [2], then the result is 2.
// Write a function to find the largest size after removal.
public func findLargestSizeAfterRemoval(n: Int, m: Int, h: [Int], v: [Int]) -> Int {
    /* first thought:
     Find the largest lengh of the adjacent elements of h and v,
     and the multiplication should be the result ???
    */
    fatalError()
}
