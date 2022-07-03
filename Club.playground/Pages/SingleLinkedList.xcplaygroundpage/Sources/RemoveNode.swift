import Foundation

// Remove Nodes

extension SingleLinkedList where T == Int {
    public func removeAll(value: T) {
        remove { $0 == value }
    }
    
    public func remove(value: T, at k: Int) {
        var temp = k
        remove {
            if $0 == value {
                temp -= 1
                return temp == 0
            } else {
                return false
            }
        }
    }
    
    public func removeNthFromEnd(_ n: Int) {
        guard !self.isEmpty else {
            return
        }
        
        var temp = self.count - n + 1
        if temp <= 0 {
            temp = 1
        }
        
        remove { _ in
            temp -= 1
            return temp == 0
        }
    }
    
    private func remove(_ exclude: (T) -> Bool) {
        head = remove(node: head, exclude)
    }
    
    private func remove(node: Node?, _ exclude: (T) -> Bool) -> Node? {
        guard let node = node else {
            return nil
        }
        
        if exclude(node.value) {
            node.next = remove(node: node.next, exclude)
            return node.next
        } else {
            node.next = remove(node: node.next, exclude)
            return node
        }
    }
    
    public func removeAnotherApproach(value: T, at k: Int) {
        head = remove(node: head, value: value, at: k)
    }
    
    private func remove(node: Node?, value: T, at k: Int) -> Node? {
        guard let node = node else {
            return nil
        }
        
        if node.value == value {
            if k == 1 {
                return node.next // This will return earlier than using `remove(_ exclude:)`
            } else {
                node.next = remove(node: node.next, value: value, at: k - 1)
                return node
            }
        } else {
            node.next = remove(node: node.next, value: value, at: k)
            return node
        }
    }
}

// MARK: - Tests

import XCTest

public final class RemoveNodeTests: XCTestCase {
    func testRemoveAllNotContainValue() {
        let target = SingleLinkedList(value: 9)
        let expected = target
        
        target.removeAll(value: 0)
        
        XCTAssertEqual(target.description, expected.description)
    }
    
    func testRemoveAll() {
        let target = SingleLinkedList(value: 1)
        target.append(value: 1)
        target.append(value: 2)
        target.append(value: 1)
        
        let expected = SingleLinkedList(value: 2)
        
        target.removeAll(value: 1)
        
        XCTAssertEqual(target.description, expected.description)
    }
    
    func testRemoveKthNotContainValue() {
        let target = SingleLinkedList(value: 9)
        let expected = target
        
        target.remove(value: 0, at: 1)
        
        XCTAssertEqual(target.description, expected.description)
    }
    
    func testRemoveKth() {
        var target = SingleLinkedList(value: 1)
        target.append(value: 1)
        target.append(value: 2)
        target.append(value: 1)
        
        var expected = SingleLinkedList(value: 1)
        expected.append(value: 2)
        expected.append(value: 1)
        
        target.remove(value: 1, at: 1)
        
        XCTAssertEqual(target.description, expected.description)
        
        target = SingleLinkedList(value: 1)
        target.append(value: 1)
        target.append(value: 2)
        target.append(value: 1)
        
        expected = SingleLinkedList(value: 1)
        expected.append(value: 2)
        expected.append(value: 1)
        
        target.remove(value: 1, at: 2)
        
        XCTAssertEqual(target.description, expected.description)
        
        target = SingleLinkedList(value: 1)
        target.append(value: 1)
        target.append(value: 2)
        target.append(value: 1)
        
        expected = SingleLinkedList(value: 1)
        expected.append(value: 1)
        expected.append(value: 2)
        
        target.remove(value: 1, at: 3)
        
        XCTAssertEqual(target.description, expected.description)
    }
    
    func testRemoveKthAnotherApproach() {
        var target = SingleLinkedList(value: 1)
        target.append(value: 1)
        target.append(value: 2)
        target.append(value: 1)
        
        var expected = SingleLinkedList(value: 1)
        expected.append(value: 2)
        expected.append(value: 1)
        
        target.removeAnotherApproach(value: 1, at: 1)
        
        XCTAssertEqual(target.description, expected.description)
        
        target = SingleLinkedList(value: 1)
        target.append(value: 1)
        target.append(value: 2)
        target.append(value: 1)
        
        expected = SingleLinkedList(value: 1)
        expected.append(value: 2)
        expected.append(value: 1)
        
        target.removeAnotherApproach(value: 1, at: 2)
        
        XCTAssertEqual(target.description, expected.description)
        
        target = SingleLinkedList(value: 1)
        target.append(value: 1)
        target.append(value: 2)
        target.append(value: 1)
        
        expected = SingleLinkedList(value: 1)
        expected.append(value: 1)
        expected.append(value: 2)
        
        target.removeAnotherApproach(value: 1, at: 3)
        
        XCTAssertEqual(target.description, expected.description)
    }
    
    func testRemoveNthFromEnd() {
        var target = SingleLinkedList(value: 1)
        var expected = SingleLinkedList<Int>()
        
        target.removeNthFromEnd(1)
        
        XCTAssertEqual(target.description, expected.description)
        
        target = SingleLinkedList(value: 1)
        target.append(value: 2)
        
        expected = SingleLinkedList(value: 1)
        
        target.removeNthFromEnd(1)
        
        XCTAssertEqual(target.description, expected.description)
        
        target = SingleLinkedList(value: 1)
        target.append(value: 2)
        target.append(value: 3)
        target.append(value: 4)
        target.append(value: 5)
        
        expected = SingleLinkedList(value: 1)
        expected.append(value: 2)
        expected.append(value: 3)
        expected.append(value: 5)
        
        target.removeNthFromEnd(2)
        
        XCTAssertEqual(target.description, expected.description)
    }
}
