import Foundation

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

// MARK: - Tests

import XCTest

public final class ShiftZerosTests: XCTestCase {
    func testShiftZeros() {
        XCTAssertEqual([0, 20, -3, 0, 0, 9, 7, 2, 1, 0].shiftingZeros(), [20, -3, 9, 7, 2, 1, 0, 0, 0, 0])

        var integers = [0, 20, -3, 0, 0, 9, 7, 2, 1, 0]
        integers.shiftZeros()
        XCTAssertEqual(integers, [20, -3, 9, 7, 2, 1, 0, 0, 0, 0])
    }
}
