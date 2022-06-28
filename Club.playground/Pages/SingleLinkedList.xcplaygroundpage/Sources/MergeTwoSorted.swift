import Foundation

// Merge Two Sorted Lists
//
// Given two sorted linked lists, merge them so that the resulting linked list is also sorted.
extension SingleLinkedList where T == Int {
    public func merged(_ another: SingleLinkedList<Int>) -> SingleLinkedList<Int> {
        var first = head
        var second = another.head
        let result = SingleLinkedList()
        
        while let unwrappedFirst = first, let unwrappedSecond = second {
            if unwrappedFirst.value <= unwrappedSecond.value {
                result.append(value: unwrappedFirst.value)
                first = unwrappedFirst.next
            } else {
                result.append(value: unwrappedSecond.value)
                second = unwrappedSecond.next
            }
        }
        
        while let unwrappedFirst = first {
            result.append(value: unwrappedFirst.value)
            first = unwrappedFirst.next
        }
        
        while let unwrappedSecond = second {
            result.append(value: unwrappedSecond.value)
            second = unwrappedSecond.next
        }
        
        return result
    }
}

// MARK: - Tests

import XCTest

public final class MergeSortedTests: XCTestCase {
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
}
