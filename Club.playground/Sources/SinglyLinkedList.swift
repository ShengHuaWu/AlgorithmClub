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
