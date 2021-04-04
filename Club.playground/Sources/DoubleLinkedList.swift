import Foundation

public final class DoubleLinkedListNode<T> {
    var value: T
    public var next: DoubleLinkedListNode?
    public var random: DoubleLinkedListNode?
    
    public init(_ value: T) {
        self.value = value
        self.next = nil
        self.random = nil
    }
}

extension DoubleLinkedListNode: CustomStringConvertible {
    public var description: String {
        var s = "\(value) -> "
        var node = next
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

// Copy Linked List With Random Pointer
//
// Given a linked list where the node has two pointers.
// The first is the regular ‘next’ pointer.
// The second pointer is called ‘random’ and it can point to any node in the linked list.
// Write code to make a deep copy of the given linked list.
// Here, deep copy means that any operations on the original list (inserting, modifying and removing) should not affect the copied list.
extension DoubleLinkedListNode {
    // TODO: This is not finished
    public func copyRandomList() -> DoubleLinkedListNode? {
        let result = copy(self) // Create a new list by copying the original
        
        // Use dictionary to store [original: copied]
        // and assign the random pointer
        
        return result
    }
    
    private func copy(_ node: DoubleLinkedListNode?) -> DoubleLinkedListNode? {
        guard let current = node else {
            return nil
        }
        
        let newNode = DoubleLinkedListNode(current.value)
        newNode.next = copy(current.next)
        
        return newNode
    }

    // TODO: This is not correct
    private func recursivelyCopy(_ node: DoubleLinkedListNode?) -> DoubleLinkedListNode? {
        guard let original = node else {
            return nil
        }
        
        let newNode = DoubleLinkedListNode(original.value)
        let newNext = recursivelyCopy(original.next)
        
        // Insert new node after original node
        newNode.next = original.next
        original.next = newNode
        
        // Set newNode.random to original.random.next (this doesn't work now)
        newNode.random = original.random?.next

        // Recovery the original
        newNode.next = newNext
        original.next = original.next?.next
        
        return newNode
    }
}
