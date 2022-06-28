import Foundation

// Reverse

extension SingleLinkedList {
    public func reversed() -> Self {
        guard var current = head else {
            return self
        }
        
        var previous: Node? = nil
        while let next = current.next {
            current.next = previous
            previous = current
            current = next
        }
        
        // Need this the because we check `current.next != nil`
        // instead of `current != nil`
        current.next = previous
        
        head = current
        
        return self
    }
}
