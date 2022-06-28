import Foundation

// Detect Cycle

extension SingleLinkedList {
    public func hasCycle() -> Bool {
        var slow = head
        var fast = head
        
        while slow != nil, fast != nil, fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            if slow === fast {
                return true
            }
        }
        
        return false
    }
}
