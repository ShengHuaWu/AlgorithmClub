import Foundation

final class SinglyLinkedListNode<T> where T: Comparable {
    var value: T
    var next: SinglyLinkedListNode?
    
    init(value: T) {
        self.value = value
        self.next = nil
    }
}

public class SinglyLinkedList<T> where T: Comparable {
    typealias Node = SinglyLinkedListNode<T>
    
    fileprivate var head: Node?
    fileprivate var last: Node? {
        if var node = head {
            while let next = node.next {
                node = next
            }
            
            return node
        } else {
            return nil
        }
    }
    
    public init() {}
}

extension SinglyLinkedList {
    public func append(newValue: T) {
        let newNode = Node(value: newValue)
        if let last = last {
            last.next = newNode
        } else {
            head = newNode
        }
    }
    
    public func remove(with key: T) {
        head = remove(node: head, with: key)
    }
    
    private func remove(node: Node?, with key: T) -> Node? {
        // Basic case
        guard let current = node else { return nil }
        
        // Apply removal
        if current.value == key {
            return current.next
        }
        
        // Recursive call
        current.next = remove(node: current.next, with: key)
        
        return current
    }
}

extension SinglyLinkedList: CustomStringConvertible {
    public var description: String {
        var s = ""
        var node = head
        while let current = node {
            s += "\(current.value)"
            node = current.next
            if node != nil {
                s += " -> "
            }
        }
        return s
    }
}

// Add Two Integers
//
// Given the head pointers of two linked lists where each linked list represents an integer number (each node is a digit),
// add them and return the resulting linked list.
// Here, the first node in a list represents the least significant digit.
// For instance, 1 -> 2 -> 3 represents 321.
extension SinglyLinkedList where T == Int {
    public func add(_ another: SinglyLinkedList<Int>) -> SinglyLinkedList<Int> {
        var first = head
        var second = another.head
        var carry = 0
        let result = SinglyLinkedList()
        while let unwrappedFirst = first, let unwrappedSecond = second {
            let sum = unwrappedFirst.value + unwrappedSecond.value + carry
            result.append(newValue: sum % 10)
            carry = sum / 10
            first = unwrappedFirst.next
            second = unwrappedSecond.next
        }
        
        while let unwrappedFirst = first {
            let sum = unwrappedFirst.value + carry
            result.append(newValue: sum % 10)
            carry = sum / 10
            first = unwrappedFirst.next
        }
        
        while let unwrappedSecond = second {
            let sum = unwrappedSecond.value + carry
            result.append(newValue: sum % 10)
            carry = sum / 10
            second = unwrappedSecond.next
        }
        
        if carry != 0 {
            result.append(newValue: carry)
        }
        
        return result
    }
}

// Merge Two Sorted Lists
//
// Given two sorted linked lists, merge them so that the resulting linked list is also sorted.
extension SinglyLinkedList where T == Int {
    public func merged(_ another: SinglyLinkedList<Int>) -> SinglyLinkedList<Int> {
        var first = head
        var second = another.head
        let result = SinglyLinkedList()
        
        while let unwrappedFirst = first, let unwrappedSecond = second {
            if unwrappedFirst.value <= unwrappedSecond.value {
                result.append(newValue: unwrappedFirst.value)
                first = unwrappedFirst.next
            } else {
                result.append(newValue: unwrappedSecond.value)
                second = unwrappedSecond.next
            }
        }
        
        while let unwrappedFirst = first {
            result.append(newValue: unwrappedFirst.value)
            first = unwrappedFirst.next
        }
        
        while let unwrappedSecond = second {
            result.append(newValue: unwrappedSecond.value)
            second = unwrappedSecond.next
        }
        
        return result
    }
}
