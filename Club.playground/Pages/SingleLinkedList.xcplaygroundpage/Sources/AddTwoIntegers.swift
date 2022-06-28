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
