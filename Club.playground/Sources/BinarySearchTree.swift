import Foundation

public enum BinarySearchTree<Element: Comparable> {
    case empty
    indirect case node(BinarySearchTree<Element>, Element, BinarySearchTree<Element>)
}

extension BinarySearchTree {
    private var minimun: BinarySearchTree {
        switch self {
        case .empty:
            return self
        case let .node(left, _, _):
            if case .empty = left {
                return self
            } else {
                return left.minimun
            }
        }
    }
    
    public func appending(_ newElement: Element) -> BinarySearchTree {
        switch self {
        case .empty:
            return .node(.empty, newElement, .empty)
        case let .node(left, element, right):
            if element > newElement {
                return .node(left.appending(newElement), element, right)
            } else {
                return .node(left, element, right.appending(newElement))
            }
        }
    }
    
    public mutating func append(_ newElement: Element) {
        self = appending(newElement)
    }
    
    public func contains(_ key: Element) -> Bool {
        switch  self {
        case .empty:
            return false
        case let .node(left, element, right):
            if element == key {
                return true
            } else if element > key {
                return left.contains(key)
            } else {
                return right.contains(key)
            }
        }
    }
    
    public func traverseInOrder(_ process: (Element) -> ()) {
        switch self {
        case .empty:
            return
        case let .node(left, element, right):
            left.traverseInOrder(process)
            process(element)
            right.traverseInOrder(process)
        }
    }
    
    public func traversePreOrder(_ process: (Element) -> ()) {
        switch self {
        case .empty:
            return
        case let .node(left, element, right):
            process(element)
            left.traversePreOrder(process)
            right.traversePreOrder(process)
        }
    }
    
    public func traversePostOrder(_ process: (Element) -> ()) {
        switch self {
        case .empty:
            return
        case let .node(left, element, right):
            left.traversePostOrder(process)
            right.traversePostOrder(process)
            process(element)
        }
    }
    
    public func inverting() -> BinarySearchTree {
        switch self {
        case .empty:
            return self
        case let .node(left, element, right):
            return .node(right.inverting(), element, left.inverting())
        }
    }
    
    public func removing(_ key: Element) -> BinarySearchTree {
        switch self {
        case .empty:
            return self
        case let .node(.empty, element, .empty) where element == key:
            return .empty
        case let .node(.empty, element, right) where element == key:
            return right
        case let .node(left, element, .empty) where element == key:
            return left
        case let .node(left, element, right) where element < key:
            return .node(left, element, right.removing(key))
        case let .node(left, element, right) where element > key:
            return .node(left.removing(key), element, right)
        case let .node(left, element, right) where element == key:
            // Here, I replace the smallest element from right,
            // but replacing the largest element from left also works.
            switch right.minimun {
            case .empty:
                return self
            case let .node(_, min, _):
                return .node(left, min, right.removing(min))
            }
        default:
            // Doesn't contain key
            return self
        }
    }
    
    public mutating func remove(_ key: Element) {
        self = removing(key)
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        switch self {
        case .empty:
            return "()"
        case let .node(.empty, element, .empty):
            return "(\(element))"
        case let .node(left, element, right):
            return "(\(left) <- \(element) -> \(right))"
        }
    }
}

public enum BinaryTree<Value> {
    case leaf
    indirect case node(BinaryTree<Value>, Value, BinaryTree<Value>)
}

extension BinaryTree {
    public func adding(_ value: Value, predicate: () -> Bool = { Int.random(in: 0...9) % 2 == 0 }) -> BinaryTree {
        switch self {
        case .leaf:
            return .node(.leaf, value, .leaf)
            
        case let .node(left, v, right):
            if predicate() {
                return .node(left.adding(value), v, right)
            } else {
                return .node(left, v, right.adding(value))
            }
        }
    }
}

extension BinaryTree: CustomStringConvertible where Value: CustomStringConvertible {
    public var description: String {
        switch self {
        case .leaf:
            return "*"
            
        case let .node(.leaf, value, .leaf):
            return "(\(value.description))"
            
        case let .node(left, value, right):
            return "(\(left.description) <- \(value.description) -> \(right.description))"
        }
    }
}

// Determine If Two Binary Trees Are Identical
//
// Given the roots of two binary trees, determine if these trees are identical or not.
// Identical trees have the same layout and data at each node.
extension BinaryTree where Value: Equatable {
    public func isIdenticial(with another: BinaryTree<Value>) -> Bool {
        if case .leaf = self, case .leaf = another {
            return true
        }
        
        guard case let .node(leftSelf, valueSelf, rightSelf) = self, case let .node(leftAnother, valueAnother, rightAnother) = another else {
            return false
        }
        
        return valueSelf == valueAnother
            && leftSelf.isIdenticial(with: leftAnother)
            && rightSelf.isIdenticial(with: rightAnother)
    }
}

// Mirror Binary Tree Nodes
//
// Given the root node of a binary tree, swap the ‘left’ and ‘right’ children for each node.
extension BinaryTree {
    public func mirroring() -> BinaryTree {
        guard case let .node(left, value, right) = self else {
            return .leaf
        }
        
        return .node(right.mirroring(), value, left.mirroring())
    }
}
