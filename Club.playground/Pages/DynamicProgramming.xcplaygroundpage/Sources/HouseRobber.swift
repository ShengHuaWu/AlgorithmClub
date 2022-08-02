import Foundation

extension Array where Element == Int {
    // Dynamic programming
    //
    // You are a professional robber planning to rob houses along a street.
    // Each house has a certain amount of money stashed,
    // the only constraint stopping you from robbing each of them is that
    // adjacent houses have security systems connected
    // and it will automatically contact the police
    // if two adjacent houses were broken into on the same night.
    //
    // Given an integer array `nums` representing the amount of money of each house,
    // return the maximum amount of money you can rob tonight without alerting the police.
    public func rob() -> Int {
        guard !self.isEmpty else {
            return 0
        }
        
        // For each number in the array, we only need to consider
        // the amount including the previous number
        // and the amount excluding the previous number:
        // [amountExcludingPrevious, amountIncludingPrevious, n, n+1, ...]
        var amountExcludingPrevious = 0
        var amountIncludingPrevious = 0
        
        for number in self {
            let temp = Swift.max(
                number + amountExcludingPrevious,
                amountIncludingPrevious
            )
            amountExcludingPrevious = amountIncludingPrevious
            amountIncludingPrevious = temp
        }
        
        return amountIncludingPrevious
    }
}

// MARK: - Tests

import XCTest

public final class HouseRobTests: XCTestCase {
    func testRob() {
        var input = [1, 2, 3, 1]
        XCTAssertEqual(input.rob(), 4)
        
        input = []
        XCTAssertEqual(input.rob(), 0)
        
        input = [2, 7, 9, 3, 1]
        XCTAssertEqual(input.rob(), 12)
    }
}
