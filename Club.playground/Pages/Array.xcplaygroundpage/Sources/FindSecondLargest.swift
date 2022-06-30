import Foundation

extension Array where Element: Comparable {
    public func findSecondLargest() -> Element? {
        guard self.count > 1 else {
            return nil
        }
        
        var copy = self
        let largest = copy.findLargest()
        copy.removeAll(where: { $0 == largest })
        
        return copy.findLargest()
    }
}

extension Array where Element: Comparable, Element: Hashable {
    // Compare two numbers at once and store the larger as the key and the smaller as the value, e.g. [larger: [smaller1, smaller2, ...]]
    // The second largest number must be located at the value of the largest number
    // This is the important observation, because we can reduce the number of comparison.
    // It's important to remove duplicates first.
    // Otherwise, the algorithm won't tell which one is the second largest in the final return.
    public func findSecondLargestWithLessComparison() -> Element? {
        guard self.count > 1 else {
            return nil
        }
        
        var copy = self.removeDuplicates()
        var largest = copy.first!
        var group: [Element: Set<Element>] = [:]
        
        while copy.count > 1 {
            let first = copy.removeFirst()
            let second = copy.removeFirst()
            
            let larger = Swift.max(first, second)
            let smaller = Swift.min(first, second)
            
            let set = group[larger, default: []]
            group[larger] = set.union([smaller])
            
            copy.append(larger) // Append the larger back for the next round of comparison
            
            largest = Swift.max(largest, larger)
        }
        
        return group[largest]?.findLargest()
    }
}

extension Collection where Element: Comparable {
    func findLargest() -> Element? {
        guard !self.isEmpty else {
            return nil
        }
        
        return reduce(self.first!) { result, element in
            Swift.max(result, element)
        }
    }
}

extension Array where Element: Hashable {
    func removeDuplicates() -> [Element] {
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

// MARK: - Tests

import XCTest

public final class FindSecondLargestTests: XCTestCase {
    func testFindSecondLargestWithEmpty() {
        let numbers = [Int]()
        
        XCTAssertNil(numbers.findSecondLargest())
        XCTAssertNil(numbers.findSecondLargestWithLessComparison())
    }
    
    func testFindSecondLargestWithIntegers() {
        var numbers = [2, 4, 5, 9, 7, 3, 8, 10, 1, 4, 7]
        
        XCTAssertEqual(numbers.findSecondLargest(), 9)
        XCTAssertEqual(numbers.findSecondLargestWithLessComparison(), 9)
        
        numbers = [-1, 0, -35, 78, 9, 8, 0, 1, 2, 4, -88, 78, 88, 9]
        
        XCTAssertEqual(numbers.findSecondLargest(), 78)
        XCTAssertEqual(numbers.findSecondLargestWithLessComparison(), 78)
        
        numbers = [-1, 0, -35, 78, 9, 8, 7]
        
        XCTAssertEqual(numbers.findSecondLargest(), 9)
        XCTAssertEqual(numbers.findSecondLargestWithLessComparison(), 9)
    }
}
