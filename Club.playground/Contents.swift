import Foundation

func assertEqual<A: Equatable>(_ lhs: A, _ rhs: A) -> String {
    if lhs == rhs {
        return "✅"
    } else {
        return "❌"
    }
}

extension Array where Element: Comparable {
    func _binarySearch(for element: Element) -> Index? {
        var start = startIndex
        var end = endIndex
        while start < end {
            let mid = start + (end - start) / 2
            if element == self[mid] {
                return mid
            } else if element > self[mid] {
                start = mid + 1
            } else {
                end = mid
            }
        }
        
        return nil
    }
    
    func _recursiveBinarySearch(for element: Element) -> Index? {
        return recursiveBinarySearch(for: element, start: startIndex, end: endIndex)
    }
    
    private func recursiveBinarySearch(for element: Element, start: Index, end: Index) -> Index? {
        guard start < end else { return nil } // Halt condition
        
        let mid = start + (end - start) / 2
        if element == self[mid] {
            return mid
        } else if element > self[mid] {
            return recursiveBinarySearch(for: element, start: mid + 1, end: end)
        } else {
            return recursiveBinarySearch(for: element, start: start, end: mid)
        }
    }
}

extension Array where Element == Int {
    func findIndicesOfTwoElements(for sum: Int) -> (Index, Index)? {
        var temp = [Int: Index]()
        for index in indices {
            let element = self[index]
            if let theOtherIndex = temp[element] {
                return (theOtherIndex, index)
            } else {
                temp[sum - element] = index
            }
        }
        
        return nil
    }
    
    func findIndicesOfTwoElementsAfterSorting(for sum: Int) -> (Index, Index)? {
        var start = startIndex
        var end = endIndex - 1
        while start < end {
            let temp = self[start] + self[end]
            if temp == sum {
                return (start, end)
            } else if temp < sum {
                start += 1
            } else {
                end -= 1
            }
        }
        
        return nil
    }
}

extension Array where Element == Int {
    func findLargestPerimetersSum() -> Int? {
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
    
    func recursiveFindLargestPerimetersSum() -> Int? {
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

extension Array where Element == Int {
    func compress() -> [String] {
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
    
    func recursiveCompress() -> [String] {
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

extension Array where Element: Comparable {
    func _quickSorted() -> [Element] {
        guard count > 1 else { return self }
        
        let pivot = self[count / 2]
        
        let greater = filter { $0 > pivot }
        let equal = filter { $0 == pivot }
        let less = filter { $0 < pivot }
        
        return less._quickSorted() + equal + greater._quickSorted()
    }
    
    func _mergeSorted() -> [Element] {
        guard count > 1 else { return self }
        
        let mid = count / 2
        let left = Array(self[startIndex ..< mid])._mergeSorted()
        let right = Array(self[mid ..< endIndex])._mergeSorted()
        
        return left._merge(with: right)
    }
    
    private func _merge(with pile: [Element]) -> [Element] {
        var start = startIndex
        var pileStart = pile.startIndex
        var results = [Element]()
        
        while start < endIndex && pileStart < pile.endIndex {
            let element = self[start]
            let pileElement = pile[pileStart]
            if element < pileElement {
                results.append(element)
                start += 1
            } else if pileElement < element {
                results.append(pileElement)
                pileStart += 1
            } else {
                results.append(element)
                start += 1
                results.append(pileElement)
                pileStart += 1
            }
        }
        
        while start < endIndex {
            let element = self[start]
            results.append(element)
            start += 1
        }
        
        while pileStart < pile.endIndex {
            let pileElement = pile[pileStart]
            results.append(pileElement)
            pileStart += 1
        }
        
        return results
    }
}

extension Array where Element: Comparable {
    func intersected(with other: [Element]) -> [Element] {
        let sortedSelf = sorted()
        let sortedOther = other.sorted()
        var selfIndex = startIndex
        var otherIndex = other.startIndex
        var results = [Element]()
        
        while selfIndex < sortedSelf.endIndex && otherIndex < sortedOther.endIndex {
            let element = sortedSelf[selfIndex]
            let otherElement = sortedOther[otherIndex]
            if element == otherElement {
                results.append(element)
                selfIndex += 1
                otherIndex += 1
            } else if element > otherElement {
                otherIndex += 1
            } else {
                selfIndex += 1
            }
        }
        
        return results
    }
}

// Array

let integers = [-10, -3, 0, 1, 3, 4, 6, 9, 12, 29]
assertEqual(integers._binarySearch(for: 1), 3)
assertEqual(integers._recursiveBinarySearch(for: 10), nil)

let source = [-10, 0, 3, 4, 6, 2, 5, 6, 7, 9, 0, 8]
let indices = source.findIndicesOfTwoElements(for: 8)
assertEqual(indices!.0, 4)
assertEqual(indices!.1, 5)

let sortedSource = source.sorted()
let indicesAfterSorting = sortedSource.findIndicesOfTwoElementsAfterSorting(for: 17)
assertEqual(indicesAfterSorting!.0, 10)
assertEqual(indicesAfterSorting!.1, 11)

let edges = [1, 3, 4, 9, 10, 8, 7, 6, 5, 2, 11, 17]
assertEqual(edges.findLargestPerimetersSum(), edges.recursiveFindLargestPerimetersSum())

let numbers = [1, 2, 3, 4, 5, 8, 9, 11, 14, 17]
assertEqual(numbers.compress(), numbers.recursiveCompress())

assertEqual(source._quickSorted(), source._mergeSorted())

let a = [3, 7, 1, 4, 6]
let b = [2, 4, 5, 6, 1, 0, 9]
assertEqual(a.intersected(with: b), [1, 4, 6])

/*
let source = [-1, 0, 2, 2, 2, 2, 4, 5, 9, 10, 11]
source.occurrence(of: 2)
source.minAndMax()
var integers = [0, 20, -3, 0, 0, 9, 7, 2, 1, 0]
integers.shiftingZeros()
integers.shiftZeros()
*/


// Binary Search Tree
/*
var tree = BinarySearchTree<Int>.empty
tree.append(2)
tree.append(8)
tree.append(1)
tree.append(11)
 
tree.contains(9)
 
tree.append(5)
tree.append(21)
tree.append(3)
 
tree.remove(8)
dump(tree)*/


// Singly Linked List
/*
let list = SinglyLinkedList<Int>()
list.append(newValue: 1)
list.append(newValue: 2)
list.append(newValue: 3)

list.remove(with: 3)*/


// String

extension String {
    private func isPrettyString(in range: ClosedRange<Index>) -> Bool {
        var index = self.index(after: range.lowerBound)
        while index < range.upperBound {
            if self[index] != self[self.index(before: index)] {
                return false
            }

            index = self.index(after: index)
        }

        return true
    }
    
    private func recursiveIsPrettyString(in range: ClosedRange<Index>) -> Bool {
        let end = index(after: range.lowerBound)
        if end == range.upperBound {
            return true
        }
        
        if self[range.lowerBound] != self[end] {
            return false
        } else {
            return recursiveIsPrettyString(in: end ... range.upperBound)
        }
    }
    
    func recursiveCountNumberOfPrettyStrings(with repeating: Int) -> Int {
        guard !isEmpty, repeating > 0 else { return 0 }
        
        return recursiveCountNumberOfPrettyStrings(with: repeating, start: startIndex, result: 0)
    }
    
    private func recursiveCountNumberOfPrettyStrings(with repeating: Int, start: Index, result: Int) -> Int {
        guard let end = index(start, offsetBy: repeating, limitedBy: endIndex) else {
            return result
        }
        
        if recursiveIsPrettyString(in: start ... end) {
            return recursiveCountNumberOfPrettyStrings(with: repeating, start: end, result: result + 1)
        } else {
            return recursiveCountNumberOfPrettyStrings(with: repeating, start: index(after: start), result: result)
        }
    }
}

extension String {
    func recursiveFindOccurence(of key: String) -> Int {
        guard !isEmpty, !key.isEmpty else { return 0 }
        
        return recursiveFindOccurence(of: key, start: startIndex, result: 0)
    }
    
    private func recursiveFindOccurence(of key: String, start: Index, result: Int) -> Int {
        guard let end = index(start, offsetBy: key.count, limitedBy: endIndex) else {
            return result
        }
        
        let temp = String(self[start ..< end])
        if temp == key {
            return recursiveFindOccurence(of: key, start: end, result: result + 1)
        } else {
            return recursiveFindOccurence(of: key, start: index(after: start), result: result)
        }
    }
}

extension String {
    func recursiveTruncate(with length: Int) -> String {
        guard !isEmpty, length > 0, count > length else { return self }
        
        return recursiveTruncate(with: length, end: index(startIndex, offsetBy: length))
    }
    
    private func recursiveTruncate(with length: Int, end: Index) -> String {
        guard end > startIndex else { return "" }
        
        switch self[end] {
        case ".", ",", ":", ";", "?", "!", " ":
            return String(self[startIndex ... end])
        default:
            return recursiveTruncate(with: length, end: index(before: end))
        }
    }
}

extension String {
    static func recursiveFizzBuss(in turns: Int) -> String {
        guard turns > 0 else { return "" }
        
        return recursiveFizzBuzz(in: turns, result: "")
    }
    
    private static func recursiveFizzBuzz(in turns: Int, result: String) -> String {
        guard turns > 0 else { return result }
        
        if turns % 3 == 0, turns % 5 == 0 {
            return recursiveFizzBuzz(in: turns - 1, result: "Fizz Buzz " + result)
        } else if turns % 3 == 0 {
            return recursiveFizzBuzz(in: turns - 1, result: "Fizz " + result)
        } else if turns % 5 == 0 {
            return recursiveFizzBuzz(in: turns - 1, result: "Buzz " + result)
        } else {
            return recursiveFizzBuzz(in: turns - 1, result: "\(turns) " + result)
        }
    }
}

let str1 = "zoookkkklfuckaabbbccdceff"
str1.recursiveCountNumberOfPrettyStrings(with: 3)
assertEqual(str1.recursiveCountNumberOfPrettyStrings(with: 3), 3)

let str2 = "howimetyourmomgameofthronemommostrangethings"
assertEqual(str2.recursiveFindOccurence(of: "mom"), 2)

let str3 = "Grab, the ride-hailing company competing with Uber in Southeast Asia, has pulled in $2 billion of new financing from existing investors Didi Chuxing, the company that defeated Uber in China, and SoftBank."
assertEqual(str3.recursiveTruncate(with: 16), "Grab, the ")

String.recursiveFizzBuss(in: 15)

/*
let source = "Hello, World!"
source.index(of: "lo")*/
