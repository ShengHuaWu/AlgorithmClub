//: [Previous](@previous)

import XCTest

final class FindSumTests: XCTestCase {
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
}

FindSumTests.defaultTestSuite.run()

//: [Next](@next)
