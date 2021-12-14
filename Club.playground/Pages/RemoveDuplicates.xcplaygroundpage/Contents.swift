//: [Previous](@previous)

import Foundation
import XCTest

final class RemoveDuplicatesTests: XCTestCase {
    func testRemoveDuplicatesWithEmptyArrays() {
        XCTAssertEqual([Int]().removeDuplicates(), [])
        XCTAssertEqual([String]().removeDuplicates(), [])
    }
    
    func testRemoveDuplicatesWithIntegers() {
        var taregt = [1, 2, 3, 3, 2, 1]
        var expect = [1, 2, 3]
        
        XCTAssertEqual(taregt.removeDuplicates(), expect)
        
        taregt = [3, 2, 1, 1, 2, 3]
        expect = [3, 2, 1]
        
        XCTAssertEqual(taregt.removeDuplicates(), expect)
        
        taregt = [1, 1, 2, 2, 3, 3]
        expect = [1, 2, 3]
        
        XCTAssertEqual(taregt.removeDuplicates(), expect)
    }
    
    func testRemoveDuplicatesWithStrings() {
        var taregt = ["1", "2", "3", "3", "2", "1"]
        var expect = ["1", "2", "3"]
        
        XCTAssertEqual(taregt.removeDuplicates(), expect)
        
        taregt = ["3", "2", "1", "1", "2", "3"]
        expect = ["3", "2", "1"]
        
        XCTAssertEqual(taregt.removeDuplicates(), expect)
        
        taregt = ["1", "1", "2", "2", "3", "3"]
        expect = ["1", "2", "3"]
        
        XCTAssertEqual(taregt.removeDuplicates(), expect)
    }
}

//RemoveDuplicatesTests.defaultTestSuite.run()

//: [Next](@next)
