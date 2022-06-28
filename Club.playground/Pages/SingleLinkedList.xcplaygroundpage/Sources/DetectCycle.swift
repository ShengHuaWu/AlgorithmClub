import Foundation

// Detect Cycle

extension SingleLinkedList {
    public func hasCycle() -> Bool {
        var slow = head
        var fast = head
        
        while slow != nil, fast != nil, fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            if slow === fast {
                return true
            }
        }
        
        return false
    }
}

// MARK: - Tests

import XCTest

public final class DetectCycleTests: XCTestCase {
    func testHasCycle() {
        let target = SingleLinkedList(value: 9)
        let node = target.append(value: 1)
        target.append(value: 2)
        let tail = target.append(value: 3)
        
        XCTAssertEqual(target.description, "9 -> 1 -> 2 -> 3")
        XCTAssertFalse(target.hasCycle())
        
        tail.next = node
        
        XCTAssertTrue(target.hasCycle())
    }
}
