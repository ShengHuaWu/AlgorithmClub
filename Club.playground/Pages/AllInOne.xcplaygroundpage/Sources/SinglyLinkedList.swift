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

// Add Two Integers
//
// Given the head pointers of two linked lists where each linked list represents an integer number (each node is a digit),
// add them and return the resulting linked list.
// Here, the first node in a list represents the least significant digit.
// For instance, 1 -> 2 -> 3 represents 321.
extension SinglyLinkedList where T == Int {
    public func add(_ another: SinglyLinkedList<Int>) -> SinglyLinkedList<Int> {
        var first = head
        var second = another.head
        var carry = 0
        let result = SinglyLinkedList()
        while let unwrappedFirst = first, let unwrappedSecond = second {
            let sum = unwrappedFirst.value + unwrappedSecond.value + carry
            result.append(newValue: sum % 10)
            carry = sum / 10
            first = unwrappedFirst.next
            second = unwrappedSecond.next
        }
        
        while let unwrappedFirst = first {
            let sum = unwrappedFirst.value + carry
            result.append(newValue: sum % 10)
            carry = sum / 10
            first = unwrappedFirst.next
        }
        
        while let unwrappedSecond = second {
            let sum = unwrappedSecond.value + carry
            result.append(newValue: sum % 10)
            carry = sum / 10
            second = unwrappedSecond.next
        }
        
        if carry != 0 {
            result.append(newValue: carry)
        }
        
        return result
    }
}

// Merge Two Sorted Lists
//
// Given two sorted linked lists, merge them so that the resulting linked list is also sorted.
extension SinglyLinkedList where T == Int {
    public func merged(_ another: SinglyLinkedList<Int>) -> SinglyLinkedList<Int> {
        var first = head
        var second = another.head
        let result = SinglyLinkedList()
        
        while let unwrappedFirst = first, let unwrappedSecond = second {
            if unwrappedFirst.value <= unwrappedSecond.value {
                result.append(newValue: unwrappedFirst.value)
                first = unwrappedFirst.next
            } else {
                result.append(newValue: unwrappedSecond.value)
                second = unwrappedSecond.next
            }
        }
        
        while let unwrappedFirst = first {
            result.append(newValue: unwrappedFirst.value)
            first = unwrappedFirst.next
        }
        
        while let unwrappedSecond = second {
            result.append(newValue: unwrappedSecond.value)
            second = unwrappedSecond.next
        }
        
        return result
    }
}

// Grab Random Node
//
// Given a linked list, write a function to get a random node within it.
// Let's assume you're given a random node generator.
// The linked list will have at least 2 nodes, and may look something like this: 1 -> 2 -> 3 -> 4
// The odds of getting any number between 1 and 4 inclusive should be the exactly the same.
extension SinglyLinkedList where T == Int {
    private var count: Int {
        var next = head
        var count = 0
        while next != nil {
            count += 1
            next = next?.next
        }
        
        return count
    }
    
    public func getRandomNode(_ randomGenerator: (Int) -> Bool = { _ in Bool.random() }) -> Int? {
        let count = self.count
        guard count > 1 else {
            return nil
        }
        
        var number = getRandomNumber(startFromZeroAndLessThan: count, randomGenerator)
        var node = head
        while number > 0 {
            number -= 1
            node = node?.next
        }
        
        return node?.value
    }
    
    private func getRandomNumber(startFromZeroAndLessThan upper: Int, _ randomGenerator: (Int) -> Bool) -> Int {
//        Int.random(in: 0 ..< upper)
        recursivelyGetRandomNumber(in: Set(0 ..< upper), randomGenerator)
    }
    
    // Can use a threshold to escape from the recursive calls for better performance
    private func recursivelyGetRandomNumber(in numbers: Set<Int>, _ randomGenerator: (Int) -> Bool) -> Int {
        if numbers.count == 1, let first = numbers.first {
            return first
        }
        
        let next: Set<Int> = numbers.reduce([]) { result, number in
            randomGenerator(number) ? result.union([number]) : result
        }
        
        return next.count == 0
            ? recursivelyGetRandomNumber(in: numbers, randomGenerator)
            : recursivelyGetRandomNumber(in: next, randomGenerator)
    }
}
