import Foundation

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
        guard !self.isEmpty else {
            return []
        }
        
        var sorted = self.sorted()
        var sum = sorted.reduce(0, +)
        var resultOfA = [Int]()
        var sumOfA = 0
        
        while sumOfA <= sum {
            let last = sorted.removeLast()
            resultOfA = [last] + resultOfA
            sumOfA += last
            sum -= last
        }
        
        // The intersection of A and B must be empty
        while sorted.last == resultOfA.first {
            let last = sorted.removeLast()
            resultOfA = [last] + resultOfA
        }
        
        return resultOfA
    }
}

// MARK: - Tests
import XCTest

public final class FindSubsetTests: XCTestCase {
    func testFindSubset() {
        XCTAssertTrue([Int]().findSubset().isEmpty)
        XCTAssertEqual([5, 8, 3, 2, 1].findSubset(), [5, 8])
        XCTAssertEqual([5, 8, 3, 5, 2, 1].findSubset(), [5, 5, 8])
        XCTAssertEqual([5, 8, 3, 5, 2, 1, 8].findSubset(), [5, 5, 8, 8])
        XCTAssertEqual([-5, 8, 3, 2, 1, 7].findSubset(), [7, 8])
        XCTAssertEqual([-5, 8, 3, 2, 8, 1, 7].findSubset(), [8, 8])
    }
}
