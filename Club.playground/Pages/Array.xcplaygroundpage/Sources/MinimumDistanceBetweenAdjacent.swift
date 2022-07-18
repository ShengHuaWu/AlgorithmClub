import Foundation
import XCTest

// Minimum distance of adjacent
//
// Integer `V` lies strickly between integer `U` and `W` if `U < V < W` or `W < V < U`.
// A non-empty array `A` consisting of `N` integers is given.
// A pair of indices (`P`, `Q`), where `0 <= P < Q < N` is said to have adjacent values if no value in the array lies strickly between values `A[P]` and `A[Q]`.
// For example, in array `A` such as
// ```
// [0, 3, 3, 7, 5, 3, 11, 1]
// ```
// Indices 4 and 5 have adjacent values because there is no value in `A` that lies strickly between `A[4] = 5` and `A[5] = 3`;
// the only such value could be the number 4, and it's not presented in the array.
// Given two indices `P` and `Q`, their distance is defined as `abs(A[P] - A[Q])`.
// Write a function that, given a non-empty array `A` consisting of `N` integers,
// returns the minimum distance between indices of this array that have adjacent values.
// The function should return `-1` if the minimum distance if greater than 100,000,000.
// The function should return `-2` if no adjacent indices exist.
// For instance, given the array `A` as shown above the function should return 0.
extension Array where Element == Int {
    public func findMinimumDistanceBetweenAdjacent() -> Int {
        guard count >= 2 else {
            return -2
        }
        
        let sortedCopy = sorted()
        var minDistance = Int.max
        sortedCopy.indices[1...].forEach { index in
            let distance = sortedCopy[index] - sortedCopy[index - 1]
            minDistance = Swift.min(minDistance, distance)
        }
        
        return minDistance > 100_000_000 ? -1 : minDistance
    }
}

// MARK: - Tests

public final class MinimumDistanceBetweenAdjacentTests: XCTestCase {
    func testFindMinimumDistanceBetweenAdjacent() {
        XCTAssertEqual([Int]().findMinimumDistanceBetweenAdjacent(), -2)
        XCTAssertEqual([100_000_001, 0].findMinimumDistanceBetweenAdjacent(), -1)
        XCTAssertEqual([0, 3, 3, 7, 5, 3, 11, 1].findMinimumDistanceBetweenAdjacent(), 0)
    }
}
