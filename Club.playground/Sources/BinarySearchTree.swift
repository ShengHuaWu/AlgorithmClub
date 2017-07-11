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
