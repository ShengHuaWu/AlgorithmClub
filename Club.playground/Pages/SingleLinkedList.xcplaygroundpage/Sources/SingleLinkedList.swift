import Foundation

public final class SingleLinkedListNode<T> where T: Equatable {
    public let value: T
    public var next: SingleLinkedListNode<T>?
    
    public init(value: T) {
        self.value = value
        self.next = nil
    }
}

public final class SingleLinkedList<T> where T: Equatable {
    public typealias Node = SingleLinkedListNode<T>
    
    var head: Node?
    var last: Node? {
        if var temp = head {
            while let next = temp.next {
                temp = next
            }
            return temp
            
        } else {
            return nil
        }
    }
    
    public init(value: T) {
        self.head = Node(value: value)
    }
    
    init() {
        self.head = nil
    }
    
    @discardableResult
    public func append(value: T) -> Node {
        let newNode = Node(value: value)
        if let last = self.last {
            last.next = newNode
        } else {
            head = Node(value: value)
        }
        
        return newNode
    }
}

extension SingleLinkedListNode: CustomStringConvertible where T: CustomStringConvertible {
    public var description: String {
        return value.description
    }
}

extension SingleLinkedList: CustomStringConvertible where T: CustomStringConvertible {
    public var description: String {
        guard let head = self.head else {
            return ""
        }
        
        var text = "\(head.value)"
        var temp = head
        
        while let next = temp.next {
            text += " -> \(next.value)"
            temp = next
        }
        
        return text
    }
}
