import Foundation

// Top K Frequent Elements
//
// Given an integer array and an integer k,
// return the k most frequent elements. You may return the answer in any order.

extension Array where Element == Int {
    // 1. Store a dictionary [number: count] to represent the count of each number
    // 2. Construct a frequents array where its index is the count
    //    and its element is the list of number (this is the key of the solution)
    //    For example, input: [1, 2], freqents: [[], [1, 2], []]
    // 3. Loop the frequents array in reversed order to get the result
    //
    // Time complexity: O(N) where N is the length of the input array
    // Space complexity: O(N)
    func topKFrequentElements(_ k: Int) -> Self {
        guard !self.isEmpty else {
            return []
        }
        
        var counts = [Int: Int]()
        for number in self {
            let count = counts[number, default: 0]
            counts[number] = count + 1
        }
        
        // The total count is `self.count + 1` because index zero means zero count
        var frequents = Array<[Int]>(repeating: [Int](), count: self.count + 1)
        for (number, count) in counts {
            let frequent = frequents[count]
            frequents[count] = frequent + [number]
        }
        
        // Technically the time complexity is O(N),
        // because if all the number are distinct then only index 1 are considered
        // (it returns when the count of result is equal to k)
        var result = [Int]()
        for index in (0 ..< frequents.count).reversed() {
            let numbers = frequents[index]
            for number in numbers {
                result.append(number)
                
                if result.count == k {
                    return result
                }
            }
        }
        
        // Should NOT happen because k is always smaller than N
        assertionFailure("K \(k) is larger than the length of input array \(self.count)")
        return result
    }
}

// MARK: - Tests

import XCTest

public final class TopKFrequentElementsTests: XCTestCase {
    func testTopKFrequentElements() {
        var input = [1]
        
        XCTAssertEqual(input.topKFrequentElements(1), [1])
        
        input = [1, 1, 1, 2, 2, 3]
        
        XCTAssertEqual(input.topKFrequentElements(2), [1, 2])
        
        
        input = [8, 1, 7, 1, 1, 1, 2, 2, 9, 10, 3, 11, 24, 2, 3, 5]
        
        XCTAssertEqual(input.topKFrequentElements(3), [1, 2, 3])
    }
}
