//: [Previous](@previous)

import XCTest

final class LinkedListTests: XCTestCase {
    func testSingleLinkedListDescription() {
        let target = SingleLinkedList(value: 9)
        
        XCTAssertEqual(target.description, "9")
        
        target.append(value: 1)
        target.append(value: 2)
        target.append(value: 3)
        
        XCTAssertEqual(target.description, "9 -> 1 -> 2 -> 3")
    }
    
    func testSingleLinkedListRemoveAllNotContainValue() {
        let target = SingleLinkedList(value: 9)
        let expected = target
        
        target.removeAll(value: 0)
        
        XCTAssertEqual(target.description, expected.description)
    }
    
    func testSingleLinkedListRemoveAll() {
        let target = SingleLinkedList(value: 1)
        target.append(value: 1)
        target.append(value: 2)
        target.append(value: 1)
        
        let expected = SingleLinkedList(value: 2)
        
        target.removeAll(value: 1)
        
        XCTAssertEqual(target.description, expected.description)
    }
    
    func testSingleLinkedListRemoveKthNotContainValue() {
        let target = SingleLinkedList(value: 9)
        let expected = target
        
        target.remove(value: 0, at: 1)
        
        XCTAssertEqual(target.description, expected.description)
    }
    
    func testSingleLinkedListRemoveKth() {
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
    
    func testSingleLinkedListRemoveKthAnotherApproach() {
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
    
    func testSingleLinkedListDeepCopy() {
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
    
    func testSingleLinkedListReversed() {
        let target = SingleLinkedList(value: 9)
        
        XCTAssertEqual(target.reversed().description, "9")
                
        target.append(value: 1)
        target.append(value: 2)
        target.append(value: 3)
        
        XCTAssertEqual(target.reversed().description, "3 -> 2 -> 1 -> 9")
    }
    
    func testSingleLinkedListHasCycle() {
        let target = SingleLinkedList(value: 9)
        let node = target.append(value: 1)
        target.append(value: 2)
        let tail = target.append(value: 3)
        
        XCTAssertEqual(target.description, "9 -> 1 -> 2 -> 3")
        XCTAssertFalse(target.hasCycle())
        
        tail.next = node
        
        XCTAssertTrue(target.hasCycle())
    }
    
    func testSingleLinkedListReordered() {
        let target = SingleLinkedList(value: 1)
        
        XCTAssertEqual(target.reordered().description, "1")
        
        target.append(value: 2)
        target.append(value: 3)
        target.append(value: 4)
        
        XCTAssertEqual(target.reordered().description, "1 -> 4 -> 2 -> 3")
        
        target.append(value: 5)
        
        XCTAssertEqual(target.reordered().description, "1 -> 5 -> 2 -> 4 -> 3")
    }
}

LinkedListTests.defaultTestSuite.run()

//: [Next](@next)
