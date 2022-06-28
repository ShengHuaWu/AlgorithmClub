import Foundation

// Reverse

extension SingleLinkedList {
    public func reversed() -> Self {
        guard var current = head else {
            return self
        }
        
        var previous: Node? = nil
        while let next = current.next {
            current.next = previous
            previous = current
            current = next
        }
        
        // Need this the because we check `current.next != nil`
        // instead of `current != nil`
        current.next = previous
        
        head = current
        
        return self
    }
}

// MARK: - Tests

import XCTest

public final class ReverseTests: XCTestCase {
    func testSingleLinkedListReversed() {
        let target = SingleLinkedList(value: 9)
        
        XCTAssertEqual(target.reversed().description, "9")
                
        target.append(value: 1)
        target.append(value: 2)
        target.append(value: 3)
        
        XCTAssertEqual(target.reversed().description, "3 -> 2 -> 1 -> 9")
    }
}
