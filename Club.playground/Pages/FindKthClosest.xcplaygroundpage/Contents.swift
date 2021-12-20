//: [Previous](@previous)

import Foundation
import XCTest

final class FindKthClosestTests: XCTestCase {
    func testFindKthClosest() {
        XCTAssertEqual([Int]().findKthClosest(10, to: 7), [])
        XCTAssertEqual([-1, 2, 3].findKthClosest(4, to: 0), [-1, 2, 3])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosest(3, to: 0), [-1, 0, 1])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosest(2, to: 0), [-1, 0])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosest(5, to: -1), [-1, 0, 1, 2, 3])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosest(5, to: 3), [0, 1, 2, 3, 4])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosest(5, to: 4), [0, 1, 2, 3, 4])
    }
    
    func testFindKthClosestWithDictionary() {
        XCTAssertEqual([Int]().findKthClosestWithDictionary(10, to: 7), [])
        XCTAssertEqual([-1, 2, 3].findKthClosestWithDictionary(4, to: 0), [-1, 2, 3])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosestWithDictionary(3, to: 0), [-1, 0, 1])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosestWithDictionary(2, to: 0), [-1, 0])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosestWithDictionary(5, to: -1), [-1, 0, 1, 2, 3])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosestWithDictionary(5, to: 3), [0, 1, 2, 3, 4])
        XCTAssertEqual([-1, 0, 1, 2, 3, 4].findKthClosestWithDictionary(5, to: 4), [0, 1, 2, 3, 4])
    }
}

FindKthClosestTests.defaultTestSuite.run()

//: [Next](@next)
