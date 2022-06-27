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

// Find all paths for a sum
//
// Given a binary tree and a number ‘S’, find all paths from root-to-leaf such that the sum of all the node values of each path equals ‘S’.
extension BinaryTree where Value == Int {
    public func findAllPaths(for target: Int) -> [[Int]] {
        var results = [[Int]]()
        var temp = [Int]()
        
        recursivelyFindAllPaths(for: target, currentSum: 0, start: self, temp: &temp, results: &results)
        
        return results
    }
    
    private func recursivelyFindAllPaths(for target: Int, currentSum: Int, start: BinaryTree, temp: inout [Int], results: inout [[Int]]) {
        switch start {
        case .leaf:
            if target == currentSum {
                results.append(temp)
            }
            
        case let .node(.leaf, value, .leaf):
            let newCurrentSum = value + currentSum
            if newCurrentSum == target {
                results.append(temp + [value])
            }
            
        case let .node(left, value, right):
            let newCurrentSum = value + currentSum
            if newCurrentSum <= target {
                temp.append(value)
                recursivelyFindAllPaths(for: target, currentSum: newCurrentSum, start: left, temp: &temp, results: &results)
                recursivelyFindAllPaths(for: target, currentSum: newCurrentSum, start: right, temp: &temp, results: &results)
                temp.removeLast() // Removing the last element from list (backtracking)
            }
        }
    }
}

// Find Lowest Common Ancestor
extension BinaryTree where Value: Comparable {
    // 1. Travel from root to `value1` and `value2` respectively and obtains two arrays of values
    // 2. Compare the two arrays and return the one before the mismatch
    // 3. Time complexity & space complexity: O(n)
    public func findLowestCommonAncestor(_ value1: Value, _ value2: Value) -> Value? {
        let pathForValue1 = traverse(to: value1)
        let pathForValue2 = traverse(to: value2)
        
        return zip(pathForValue1, pathForValue2).reduce(nil) { result, pair in
            pair.0 == pair.1 ? pair.0 : result
        }
    }
    
    private func traverse(to key: Value) -> [Value] {
        switch self {
        case .leaf:
            return []
            
        case let .node(_, value, _) where value == key:
            return [value]
            
        case let .node(left, value, right):
            let leftValues = left.traverse(to: key)
            let rightValues = right.traverse(to: key)
            
            // Cannot find the key
            if leftValues.isEmpty, rightValues.isEmpty {
                return []
            }
            
            if rightValues.isEmpty {
                return [value] + leftValues
            } else if leftValues.isEmpty {
                return [value] + rightValues
            } else {
                assertionFailure("Both of left & right path are non-empty, but values should be unique")
                return []
            }
        }
    }
    
    // 1. If the value of the current node is equal to `value1` or `value2`, then the current node is the lowest common ancestor
    // 2. If the value of the current node is NOT equal to `value1` or `value2`, then find the lowest common ancestor for left and right subtree
    // 3. If both of the left and right lowest common ancestors are NOT nil, then the current node is the lowest common ancestor
    // 4. If one of the left and right lowest common ancestors is nil, then the other one is the lowest common ancestor
    // 5. Time complexity: O(n); Space complexlity: O(1)
    public func findLowestCommonAncestorAnotherWay(_ value1: Value, _ value2: Value) -> Value? {
        switch self {
        case .leaf:
            return nil
            
        case let .node(_, value, _) where value == value1 || value == value2:
            // This assumes both of the values exist in thr tree
            return value
            
        case let .node(left, value, right):
            let leftLCA = left.findLowestCommonAncestorAnotherWay(value1, value2)
            let rightLCA = right.findLowestCommonAncestorAnotherWay(value1, value2)
            
            if leftLCA != nil, rightLCA != nil {
                return value
            }
            
            return leftLCA != nil ? leftLCA : rightLCA
        }
    }
}
