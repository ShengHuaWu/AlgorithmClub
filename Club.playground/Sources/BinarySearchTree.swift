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
                return right
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
    public func adding(_ value: Value, _ predicate: () -> Bool = { Int.random(in: 0...9) % 2 == 0 }) -> BinaryTree {
        switch self {
        case .leaf:
            return .node(.leaf, value, .leaf)
            
        case let .node(left, v, right):
            if predicate() {
                return .node(left.adding(value, predicate), v, right)
            } else {
                return .node(left, v, right.adding(value, predicate))
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
