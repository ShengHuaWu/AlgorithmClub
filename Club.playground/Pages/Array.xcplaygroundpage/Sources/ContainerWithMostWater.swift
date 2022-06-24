import Foundation

// You are given an integer array height of length n.
// There are n vertical lines drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).
// Find two lines that together with the x-axis form a container,
// such that the container contains the most water.
// Return the maximum amount of water a container can store.

extension Array where Element == Int {
    // https://www.geeksforgeeks.org/container-with-most-water/
    public func getMostWater() -> Int? {
        guard self.count > 1 else {
            return nil
        }
        
        var start = self.startIndex
        var end = self.endIndex - 1
        var result = Swift.min(self[start], self[end]) * (end - start)
        
        while start < end {
            let startElement = self[start]
            let endElement = self[end]
            
            let volume = Swift.min(startElement, endElement) * (end - start)
            result = Swift.max(volume, result)
            if startElement > endElement {
                end -= 1
            } else {
                start += 1
            }
        }
        
        return result
    }
}

// MARK: - Tests

import XCTest

public final class ContainerWithMostWaterTests: XCTestCase {
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
