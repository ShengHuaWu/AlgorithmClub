import Foundation

// Find Sum of Two Elements in Array

extension Array where Element == Int {
    // Use a dictionary to store the following:
    // - Key: difference between each element in the array and the sum k
    // - Value: the index of each element
    // - Time and space complexity are both O(n).
    public func indices(of sum: Int) -> (Int, Int)? {
        var differences: [Int: Int] = [:]
        
        for index in self.indices {
            let number = self[index]
            if let anotherIndex = differences[number] {
                return (anotherIndex, index)
            } else {
                differences[sum - number] = index
            }
        }
        
        return nil
    }
    
    // If we only need to check whether there are two elements and their sum is equal to the requirment,
    // then sort the array at first and use two variables to track the sum of the first and the last element:
    // - Time complexity depends on the sorting method. It's usually O(n log n).
    public func hasTwoElements(of sum: Int) -> Bool {
        let sorted = self.sorted()
        
        var firstIndex = sorted.startIndex
        var lastIndex = sorted.endIndex - 1
        
        while firstIndex < lastIndex {
            let temp = sorted[firstIndex] + sorted[lastIndex]
            if temp == sum {
                return true
            } else if temp > sum  {
                lastIndex -= 1
            } else {
                firstIndex += 1
            }
        }
        
        return false
    }
}

// Three Sum
//
// Given an integer array nums,
// return all the triplets [nums[i], nums[j], nums[k]]
// such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.
// Notice that the solution set must not contain duplicate triplets.

extension Array where Element == Int {
    // 1. Sort input array.
    // 2. Loop sorted array to get the first number
    // 3. Use two pointers to get the second and third numbers from sorted array
    //
    // Time complexity: O(N log N) + O(N * N) = O(N * N),
    // where N is the length of input array
    // Space complexity: O(N), because of sorting in Swift
    public func threeSum() -> [[Int]] {
        guard !self.isEmpty else {
            return []
        }
        
        var result = [[Int]]()
        let sorted = self.sorted() // This will help to avoid duplicate answers
        
        for index in sorted.indices {
            let number = sorted[index]
            
            // Skip the number if it's equal to the previous one
            // to avoid adding duplicated answers
            if index > 0, number == sorted[index - 1] {
                continue
            }
            
            var left = index + 1
            var right = sorted.count - 1
            
            while left < right {
                let sum = number + sorted[left] + sorted[right]
                if sum > 0 {
                    right -= 1
                } else if sum < 0 {
                    left += 1
                } else {
                    result.append([number, sorted[left], sorted[right]])
                    left += 1 // Only moving left is enough
                    
                    // Move the left pointer again
                    // if the element is equal to the previous one
                    // to avoid adding duplicated answers
                    while sorted[left] == sorted[left - 1], left < right {
                        left += 1
                    }
                }
            }
        }
        
        return result
    }
}

// Find Maximum Perimeter
//
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
}

// MARK: - Tests

import XCTest

public final class FindSumTests: XCTestCase {
    func testIndicesOfSum() {
        var target = [Int]()
        
        XCTAssertNil(target.indices(of: 9))
        
        target = [1, 2, 3]
        
        XCTAssertNil(target.indices(of: 9))
        
        target = [9, 3, 7, 2, 5, 4, 13, 0, 9, 8, 2]
        
        XCTAssertEqual(target.indices(of: 9)?.0, 2)
        XCTAssertEqual(target.indices(of: 9)?.1, 3)
    }
    
    func testHasTwoElementsOfSum() {
        var target = [Int]()
        
        XCTAssertFalse(target.hasTwoElements(of: 9))
        
        target = [1, 2, 3]
        
        XCTAssertFalse(target.hasTwoElements(of: 9))
        
        target = [9, 3, 7, 2, 5, 4, 13, 0, 9, 8, 2]
        
        XCTAssertTrue(target.hasTwoElements(of: 9))
    }
    
    func testThreeSum() {
        var target = [Int]()
        
        XCTAssertTrue(target.threeSum().isEmpty)
        
        target = [0, 1, 1]
        
        XCTAssertTrue(target.threeSum().isEmpty)
        
        target = [-3, 0, 1, -3, 4, 2]
        
        XCTAssertEqual(target.threeSum(), [[-3, 1, 2]])
        
        target = [-1, 0, 1, 2, -1, -4]
        
        XCTAssertEqual(target.threeSum(), [[-1, -1, 2], [-1, 0, 1]])
    }
    
    func testFindLargestPerimetersSum() {
        XCTAssertEqual([1, 3, 4, 9, 10, 8, 7, 6, 5, 2, 11, 17].findLargestPerimetersSum(), 38)
    }
}
