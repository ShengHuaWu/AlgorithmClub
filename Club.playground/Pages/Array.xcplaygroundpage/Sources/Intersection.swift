import Foundation

// Array Intersection
// Sort two arrays at first and then use the logic of merge sort to generate the intersection.
extension Array where Element: Comparable {
    public func intersecting(with pile: [Element]) -> [Element] {
        guard !isEmpty, !pile.isEmpty else { return [] }
        
        let sortedSelf = sorted()
        let sortedPile = pile.sorted()
        
        var result = [Element]()
        var index = sortedSelf.startIndex
        var pileIndex = sortedPile.startIndex
        
        while index < sortedSelf.endIndex && pileIndex < sortedPile.endIndex {
            let element = sortedSelf[index]
            let pileElement = sortedPile[pileIndex]
            
            if element == pileElement {
                result.append(element)
                index += 1
                pileIndex += 1
            } else if element < pileElement {
                index += 1
            } else {
                pileIndex += 1
            }
        }
        
        return result
    }
}

// MARK: - Tests

import XCTest

public final class IntersectionTests: XCTestCase {
    func testIntersecting() {
        var a = [3, 4, 7, 9]
        var b = [1, 2, 3, 4]
        
        XCTAssertEqual(a.intersecting(with: b), [3, 4])
        
        a = []
        b = []
        
        XCTAssertTrue(a.intersecting(with: b).isEmpty)
    }
}
