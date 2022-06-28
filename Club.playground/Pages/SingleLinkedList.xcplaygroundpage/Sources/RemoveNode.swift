import Foundation

// Remove Nodes

extension SingleLinkedList where T == Int {
    public func removeAll(value: T) {
        remove { $0 == value }
    }
    
    public func remove(value: T, at k: Int) {
        var temp = k
        remove {
            if $0 == value {
                temp -= 1
                return temp == 0
            } else {
                return false
            }
        }
    }
    
    private func remove(_ exclude: (T) -> Bool) {
        head = remove(node: head, exclude)
    }
    
    private func remove(node: Node?, _ exclude: (T) -> Bool) -> Node? {
        guard let node = node else {
            return nil
        }
        
        if exclude(node.value) {
            node.next = remove(node: node.next, exclude)
            return node.next
        } else {
            node.next = remove(node: node.next, exclude)
            return node
        }
    }
    
    public func removeAnotherApproach(value: T, at k: Int) {
        head = remove(node: head, value: value, at: k)
    }
    
    private func remove(node: Node?, value: T, at k: Int) -> Node? {
        guard let node = node else {
            return nil
        }
        
        if node.value == value {
            if k == 1 {
                return node.next // This will return earlier than using `remove(_ exclude:)`
            } else {
                node.next = remove(node: node.next, value: value, at: k - 1)
                return node
            }
        } else {
            node.next = remove(node: node.next, value: value, at: k)
            return node
        }
    }
}
