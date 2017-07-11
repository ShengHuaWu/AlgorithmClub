import Foundation

public enum BinarySearchTree<Element: Comparable> {
    case empty
    indirect case node(BinarySearchTree<Element>, Element, BinarySearchTree<Element>)
}

extension BinarySearchTree {
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
