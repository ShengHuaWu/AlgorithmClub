import Foundation
import XCTest

extension Array where Element == Int {
    // Dynamic programming
    //
    // Different sequences (permutations) are counted as different combinations.
    // For example, [1, 1, 2] and [1, 2, 1] are different combinations.
    //
    // Time complexity: O(N * M) where N is the size of `self` and M is the `target`
    // Space complexity: O(N * M)
    public func getSumCombinationCount(for target: Int) -> Int {
        if self.isEmpty || target == 0 {
            return 0
        }
        
        var temp = [0: 1] // Initial value
        
        for total in 1 ... target {            
            for number in self {
                // Take the advantage of cache to avoid duplicated calculations
                // `total - number` key might not exist in `temp`
                temp[total, default: 0] += temp[(total - number), default: 0]
            }
        }
        
        return temp[target, default: 0]
    }
    
    // Find All Sum Combinations
    //
    // Given an array of positive integers and a positive integer `target` print all possible combinations of positive integers that sum up to the `target` number.
    // The array is sorted and there is no duplications
    public func findAllSumCombinations(for target: Int) -> [[Int]] {
        var temp = [Int]()
        var results = [[Int]]()
        
        recursiveFindAllSumCombinations(for: target, currentSum: 0, start: 0, temp: &temp, results: &results)
        
        return results
    }
    
    private func recursiveFindAllSumCombinations(for target: Int, currentSum: Int, start: Int, temp: inout [Int], results: inout [[Int]]) {
        guard target != currentSum else {
            results.append(temp)
            return
        }
        
        for index in start ..< self.count {
            let number = self[index]
            let newCurrentSum = currentSum + number
            if newCurrentSum <= target {
                temp.append(number)
                recursiveFindAllSumCombinations(for: target, currentSum: newCurrentSum, start: index, temp: &temp, results: &results)
                temp.removeLast() // Removing the last element from list (backtracking)
            }
        }
    }
}

// MARK: - Tests

public final class SumCombinationTests: XCTestCase {
    func testGetSumCombinationCount() {
        var input = [Int]()
        var target = 4
        
        XCTAssertEqual(input.getSumCombinationCount(for: target), 0)
        
        input = [1, 2, 3]
        XCTAssertEqual(input.getSumCombinationCount(for: target), 7)
        
        target = 0
        XCTAssertEqual(input.getSumCombinationCount(for: target), 0)
        
        input = [9]
        target = 3
        XCTAssertEqual(input.getSumCombinationCount(for: target), 0)
    }
    
    func testFindAllSumCombinations() {
        XCTAssertEqual(
            [1, 2, 3].findAllSumCombinations(for: 7),
            [
                [1, 1, 1, 1, 1, 1, 1],
                [1, 1, 1, 1, 1, 2],
                [1, 1, 1, 1, 3],
                [1, 1, 1, 2, 2],
                [1, 1, 2, 3],
                [1, 2, 2, 2],
                [1, 3, 3],
                [2, 2, 3]
            ]
        )
    }
}
