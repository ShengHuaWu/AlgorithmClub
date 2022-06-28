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

// Merge K Sorted Lists
//
// Given K sorted linked lists, merge them so that the resulting linked list is also sorted.
// The difficulty of this quiz is to optimize time complexity.
extension Array where Element == SingleLinkedList<Int> {
    // 1. Divide the entire array into pairs with `stride` function
    // 2. Merge pairs one by one
    // 3. Recursion
    //
    // Time complexity: O(N log K)
    // where N is the total number of nodes in all lists and K is the length of array
    public func merged() -> SingleLinkedList<Int> {
        guard let first = self.first else {
            return SingleLinkedList()
        }
        
        // This is also the base case
        if self.count == 1 {
            return first
        }
        
        var copy = self
        if !copy.count.isMultiple(of: 2) {
            copy.append(SingleLinkedList())
        }
        
        return stride(from: 0, to: copy.count - 1, by: 2)
            .map { index in (copy[index], copy[index + 1]) }
            .map { first, second in first.merged(second) } // `merged` is defined above
            .merged()
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
    
    func testMergeKSorted() {
        let list1 = SingleLinkedList<Int>(value: 4)
        list1.append(value: 8)
        list1.append(value: 15)
        list1.append(value: 19)
        
        let list2 = SingleLinkedList<Int>(value: 7)
        list2.append(value: 9)
        list2.append(value: 10)
        list2.append(value: 16)
        
        let list3 = SingleLinkedList<Int>(value: 1)
        list3.append(value: 10)
        list3.append(value: 16)
        list3.append(value: 20)
        
        XCTAssertEqual(
            [list1, list2, list3].merged().description,
            "1 -> 4 -> 7 -> 8 -> 9 -> 10 -> 10 -> 15 -> 16 -> 16 -> 19 -> 20"
        )
    }
}
