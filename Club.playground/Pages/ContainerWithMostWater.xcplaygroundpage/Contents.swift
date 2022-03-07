//: [Previous](@previous)

import XCTest

final class ContainerWithMostWaterTests: XCTestCase {
    func testGetMostWater() {
        var container = [Int]()
        XCTAssertNil(container.getMostWater())
        
        container = [1]
        XCTAssertNil(container.getMostWater())
        
        container = [1, 1]
        XCTAssertEqual(container.getMostWater(), 1)
        
        container = [1, 5, 4, 3]
        XCTAssertEqual(container.getMostWater(), 6)
        
        container = [3, 1, 2, 4, 5]
        XCTAssertEqual(container.getMostWater(), 12)
        
        container = [1, 8, 6, 2, 5, 4, 8, 3, 7]
        XCTAssertEqual(container.getMostWater(), 49)
    }
}

ContainerWithMostWaterTests.defaultTestSuite.run()

//: [Next](@next)
