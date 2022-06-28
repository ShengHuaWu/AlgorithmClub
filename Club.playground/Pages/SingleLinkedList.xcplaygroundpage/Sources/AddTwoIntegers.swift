import Foundation

// Add Two Integers
//
// Given the head pointers of two linked lists where each linked list represents an integer number (each node is a digit),
// add them and return the resulting linked list.
// Here, the first node in a list represents the least significant digit.
// For instance, 1 -> 2 -> 3 represents 321.
extension SingleLinkedList where T == Int {
    public func add(_ another: SingleLinkedList<Int>) -> SingleLinkedList<Int> {
        var first = head
        var second = another.head
        var carry = 0
        let result = SingleLinkedList()
        while let unwrappedFirst = first, let unwrappedSecond = second {
            let sum = unwrappedFirst.value + unwrappedSecond.value + carry
            result.append(value: sum % 10)
            carry = sum / 10
            first = unwrappedFirst.next
            second = unwrappedSecond.next
        }
        
        while let unwrappedFirst = first {
            let sum = unwrappedFirst.value + carry
            result.append(value: sum % 10)
            carry = sum / 10
            first = unwrappedFirst.next
        }
        
        while let unwrappedSecond = second {
            let sum = unwrappedSecond.value + carry
            result.append(value: sum % 10)
            carry = sum / 10
            second = unwrappedSecond.next
        }
        
        if carry != 0 {
            result.append(value: carry)
        }
        
        return result
    }
}

// MARK: - Tests

import XCTest

public final class AddTwoIntegersTests: XCTestCase {
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
