import Foundation

public enum BinaryTree<Value> {
    case leaf
    indirect case node(BinaryTree<Value>, Value, BinaryTree<Value>)
}

extension BinaryTree {
    public enum Side {
        case left
        case right
    }
    
    public func inserted(_ newValue: Value, at side: Side = .left) -> Self {
        switch self {
        case .leaf:
            return .node(.leaf, newValue, .leaf)
            
        case let .node(left, value, right):
            guard case .left = side else {
                return .node(
                    left,
                    value,
                    right.inserted(newValue, at: side)
                )
            }
            
            return .node(
                left.inserted(newValue, at: side),
                value,
                right
            )
        }
    }
}

extension BinaryTree: CustomStringConvertible where Value: CustomStringConvertible {
    public var description: String {
        switch self {
        case .leaf:
            return "*"
            
        case let .node(.leaf, value, .leaf):
            return value.description
            
        case let .node(left, value, right):
            return left.description + "<-" + value.description + "->" + right.description
        }
    }
}

extension BinaryTree: Equatable where Value: Equatable {
    public static func == (lhs: BinaryTree, rhs: BinaryTree) -> Bool {
        switch (lhs, rhs) {
        case (.leaf, .leaf):
            return true
        
        case let (.node(lhsLeft, lhsValue, lhsRight), .node(rhsLeft, rhsValue, rhsRight)):
            return lhsValue == rhsValue && lhsLeft == rhsLeft && lhsRight == rhsRight
            
        default:
            return false
        }
    }
}
