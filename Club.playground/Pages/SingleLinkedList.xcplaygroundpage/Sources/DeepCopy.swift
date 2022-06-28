import Foundation

// Deep Copy
extension SingleLinkedList {
    public func deepCopy() -> SingleLinkedList {
        let copy = SingleLinkedList()
        copy.head = deepCopy(node: self.head)
        
        return copy
    }
    
    private func deepCopy(node: Node?) -> Node? {
        guard let node = node else {
            return nil
        }
        
        let newNode = Node(value: node.value)
        newNode.next = deepCopy(node: node.next)
        
        return newNode
    }
}

// MARK: - Tests

import XCTest

public final class DeepCopyTests: XCTestCase {
    func testDeepCopy() {
        let list = SingleLinkedList(value: 9)
        var copy = list.deepCopy()
        
        XCTAssertEqual(copy.description, list.description)
        XCTAssertFalse(copy === list)
        
        list.append(value: 1)
        list.append(value: 2)
        list.append(value: 2)
        list.append(value: 1)
        
        copy = list.deepCopy()
        
        XCTAssertEqual(copy.description, list.description)
        XCTAssertFalse(copy === list)
    }
}
