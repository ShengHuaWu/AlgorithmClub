import Foundation

// Deep Copy
extension SingleLinkedList {
    public func deepCopy() -> SingleLinkedList {
        let copy = SingleLinkedList()
        copy.head = deepCopy(node: self.head)
        
        return copy
    }
    
    private func deepCopy(node: Node?) -> Node? {
        guard let node = node else {
            return nil
        }
        
        let newNode = Node(value: node.value)
        newNode.next = deepCopy(node: node.next)
        
        return newNode
    }
}
