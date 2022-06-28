import Foundation

// Re-order
//
// Given a single linked list `L0 -> L1 -> … -> Ln-1 -> Ln`.
// Reorder the nodes in the list
// so that the new formed list is : `L0 -> Ln -> L1 -> Ln-1 -> L2 -> Ln-2 …`
// You are required to do this in place without altering the nodes’ values.

extension SingleLinkedList where T: CustomStringConvertible {
    // 1. Split the list into two: first half and second half
    // 2. Reversed the second half
    // 3. Merge the first half and the reversed second half
    public func reordered() -> Self {
        let splitResult = splitIntoTwo()
        
        let reversedOfSecond = splitResult.second.reversed()
        var takeNodeFromFirst = true
        var currentOfFirst = splitResult.first.head
        var currentOfReversedSecond = reversedOfSecond.head
        
        let result = Self()
        
        while currentOfFirst != nil || currentOfReversedSecond != nil {
            defer { takeNodeFromFirst.toggle() }
            
            if takeNodeFromFirst, let first = currentOfFirst {
                result.append(value: first.value)
                currentOfFirst = first.next
            }
            
            if !takeNodeFromFirst, let second = currentOfReversedSecond {
                result.append(value: second.value)
                currentOfReversedSecond = second.next
            }
        }
        
        return result
    }
    
    struct SplitResult {
        let first: SingleLinkedList
        let second: SingleLinkedList
    }
    
    private func splitIntoTwo() -> SplitResult {
        var length = 0
        var current = head
        while current != nil {
            length += 1
            current = current?.next
        }
                
        var halfLength = length / 2 - 1 // Have to minus 1 here, because it starts from `head`
        current = head // Represents the tail of the first half
        var secondHead = current?.next
        
        while halfLength > 0 {
            current = current?.next
            secondHead = current?.next
            halfLength -= 1
        }
        
        let second = SingleLinkedList()
        while let node = secondHead {
            second.append(value: node.value)
            secondHead = node.next
        }
        
        let first = SingleLinkedList()
        var firstHead = head
        while let node = firstHead, node !== current {
            first.append(value: node.value)
            firstHead = node.next
        }
        
        if let tail = current {
            first.append(value: tail.value)
        }
        
        return .init(first: first, second: second)
    }
}
