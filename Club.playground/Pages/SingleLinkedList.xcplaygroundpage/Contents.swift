//: [Previous](@previous)

import XCTest

final class SingleLinkedListTests: XCTestCase {
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
    
    func testMergeTwoSorted() {
        let list1 = SingleLinkedList<Int>(value: 4)
        list1.append(value: 8)
        list1.append(value: 15)
        list1.append(value: 19)
        
        let list2 = SingleLinkedList<Int>(value: 7)
        list2.append(value: 9)
        list2.append(value: 10)
        list2.append(value: 16)

        XCTAssertEqual(list1.merged(list2).description, "4 -> 7 -> 8 -> 9 -> 10 -> 15 -> 16 -> 19")
    }
    
    func testAddTwoIntegers() {
        let list1 = SingleLinkedList<Int>(value: 1)
        list1.append(value: 2)
        list1.append(value: 3)
        let list2 = SingleLinkedList<Int>(value: 9)
        list2.append(value: 9)

        XCTAssertEqual(list1.add(list2).description, "0 -> 2 -> 4")

        let list3 = SingleLinkedList<Int>(value: 1)
        list3.append(value: 0)
        list3.append(value: 9)
        list3.append(value: 9)
        let list4 = SingleLinkedList<Int>(value: 7)
        list4.append(value: 3)
        list4.append(value: 2)

        XCTAssertEqual(list3.add(list4).description, "8 -> 3 -> 1 -> 0 -> 1")
    }
}

SingleLinkedListTests.defaultTestSuite.run()

//: [Next](@next)
