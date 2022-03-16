import Foundation

// MARK: - Definitions

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
    
    private var head: Node?
    private var last: Node? {
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
    
    private init() {
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

// MARK: - Remove Nodes

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

// MARK: - Deep Copy

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

// MARK: - Reverse

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

// MARK: - Detect Cycle

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
