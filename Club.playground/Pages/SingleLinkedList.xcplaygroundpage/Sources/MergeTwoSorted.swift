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
