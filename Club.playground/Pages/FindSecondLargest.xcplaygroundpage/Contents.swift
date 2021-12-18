//: [Previous](@previous)

import Foundation
import XCTest

final class FindSecondLargestTests: XCTestCase {
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

//FindSecondLargestTests.defaultTestSuite.run()

//: [Next](@next)
