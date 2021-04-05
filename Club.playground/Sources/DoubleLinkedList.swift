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
        var s = "\(value)"
        var node = next
        while let current = node {
            s += " -> \(current.value)"
            node = current.next
        }
        return s
    }
}

// TODO: Support more general case
extension DoubleLinkedListNode: Equatable where T: Equatable {
    public static func == (lhs: DoubleLinkedListNode<T>, rhs: DoubleLinkedListNode<T>) -> Bool {
        lhs === rhs
    }
}

// TODO: Only support different values for now
extension DoubleLinkedListNode: Hashable where T: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

// Copy Linked List With Random Pointer
//
// Given a linked list where the node has two pointers.
// The first is the regular ‘next’ pointer.
// The second pointer is called ‘random’ and it can point to any node in the linked list.
// Write code to make a deep copy of the given linked list.
// Here, deep copy means that any operations on the original list
// (inserting, modifying and removing) should not affect the copied list.
extension DoubleLinkedListNode where T: Hashable {
    // Time comlexity: O(n)
    // Space complexity: O(n) (because of the dictionary)
    public func copyRandomList() -> DoubleLinkedListNode? {
        let result = copy(self) // Create a new list by copying the original
        
        // Use a dictionary to store [original: copied]
        var pairs: [DoubleLinkedListNode: DoubleLinkedListNode] = [:]
        var original: DoubleLinkedListNode? = self
        var copied = result
        while let unwrappedOriginal = original, let unwrappedCopied = copied {
            pairs[unwrappedOriginal] = unwrappedCopied
            original = original?.next
            copied = copied?.next
        }
        
        // Assign the random pointer based on the dictionary
        for (original, copied) in pairs {
            if let originalRandom = original.random {
                copied.random = pairs[originalRandom]
            }
        }
        
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
    
    // Time comlexity: O(n)
    // Space complexity: O(1)
    public func copyRandomListAnotherWay() -> DoubleLinkedListNode? {
        var current: DoubleLinkedListNode? = self
        var temp: DoubleLinkedListNode? = nil
        
        // Insert new node after original node
        while let unwrappedCurrent = current {
            temp = unwrappedCurrent.next
            
            unwrappedCurrent.next = DoubleLinkedListNode(unwrappedCurrent.value)
            unwrappedCurrent.next?.next = temp
            current = temp
        }
        
        // Adjust the random pointers of the newly inserted nodes
        // current.next.random = current.random.next
        current = self
        while let unwrappedCurrent = current {
            if unwrappedCurrent.next != nil {
                unwrappedCurrent.next?.random = unwrappedCurrent.random != nil ? unwrappedCurrent.random?.next : nil
            }
            
            // Move to the next newly inserted node by skipping an original node
            current = unwrappedCurrent.next != nil ? unwrappedCurrent.next?.next : nil
        }
        
        var original: DoubleLinkedListNode? = self
        var copied = original?.next
        
        // Save the start of copied linked list for returning
        temp = copied
        
        // Split the original list and copied list
        while let unwrappedOriginal = original, let unwrappedCopied = copied {
            unwrappedOriginal.next = unwrappedOriginal.next != nil ? unwrappedOriginal.next?.next : nil
            unwrappedCopied.next = unwrappedCopied.next != nil ? unwrappedCopied.next?.next : nil
            
            original = unwrappedOriginal.next
            copied = unwrappedCopied.next
        }
        
        return temp
    }
}
