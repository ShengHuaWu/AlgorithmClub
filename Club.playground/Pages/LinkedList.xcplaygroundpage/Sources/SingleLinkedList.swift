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

// MARK: - Re-order
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
