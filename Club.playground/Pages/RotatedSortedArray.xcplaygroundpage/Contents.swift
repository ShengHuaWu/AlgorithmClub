//: [Previous](@previous)

import XCTest

final class RotatedSortedArrayTests: XCTestCase {
    func testSearch() {
        var source = [Int]()
        XCTAssertNil(source.search(9))
        
        source = [1]
        XCTAssertNil(source.search(0))
        XCTAssertEqual(source.search(1), 0)
        
        source = [4, 5, 6, 7, 0, 1, 2]
        XCTAssertNil(source.search(3))
        XCTAssertEqual(source.search(0), 4)
        
        source = [5, 6, 7, 1, 2, 3, 4]
        XCTAssertNil(source.search(8))
        XCTAssertEqual(source.search(6), 1)
        XCTAssertEqual(source.search(3), 5)
        XCTAssertEqual(source.search(2), 4)
    }
    
    func testMin() {
        var source = [Int]()
        XCTAssertNil(source.min())
        
        source = [1]
        XCTAssertEqual(source.min(), 1)
        
        source = [4, 5, 6, 7, 0, 1, 2]
        XCTAssertEqual(source.min(), 0)
        
        source = [5, 6, 7, 1, 2, 3, 4]
        XCTAssertEqual(source.min(), 1)
    }
}

RotatedSortedArrayTests.defaultTestSuite.run()

//: [Next](@next)
