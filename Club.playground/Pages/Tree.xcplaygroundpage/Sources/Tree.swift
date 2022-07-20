import Foundation

public struct Tree<T> {
    public let value: T
    public var subtrees: [Tree<T>]
    
    public init(_ value: T) {
        self.value = value
        self.subtrees = []
    }
}

extension Tree {
    public var maximumDepth: Int {
        guard let maximmumDepthOfSubtrees = self.subtrees.map({ $0.maximumDepth }).max() else {
            return 1
        }
        
        return 1 + maximmumDepthOfSubtrees
    }
}

extension Tree where T: Equatable {
    // DFS approach (recursive)
    public func dfsFindFirst(_ value: T) -> Self? {
        if self.value == value {
            return self
        }
        
        for subtree in self.subtrees {
            if let result = subtree.dfsFindFirst(value) {
                return result
            }
        }
        
        return nil
    }
}

extension Tree: CustomStringConvertible where T: CustomStringConvertible {
    // Use this type to determine whether to add a new line or not
    private enum Description {
        case node(Tree<T>)
        case newLine
    }
    
    // BFS approach
    public var description: String {
        var descriptions = [Description.node(self), .newLine] // The next of the root should be new line
        var result = ""
        
        while !descriptions.isEmpty {
            let first = descriptions.removeFirst()
            
            switch first {
            case let .node(tree):
                result += tree.value.description
                
                guard !tree.subtrees.isEmpty else {
                    continue
                }
                
                // Add the descendants to the next round (BFS)
                let descendants = tree.subtrees.map(Description.node)
                descriptions.append(contentsOf: descendants)
                
                // If the next one is new line,
                // then add a new line to the next round
                // This check will avoid adding redundant new lines
                guard case .newLine = descriptions.first else {
                    continue
                }
                
                descriptions.append(.newLine)
                
            case .newLine:
                result += "\n"
            }
        }
        
        return result
    }
}

extension Tree: Equatable where T: Equatable {
    public static func ==(_ lhs: Self, _ rhs: Self) -> Bool {
        guard lhs.value == rhs.value,
              lhs.subtrees.count == rhs.subtrees.count else {
            return false
        }
        
        return zip(lhs.subtrees, rhs.subtrees).reduce(true) { result, pair in
            result && pair.0 == pair.1
        }
    }
}

// MARK: - Tests

import XCTest

public final class TreeTests: XCTestCase {
    func testTreeMaximumDepth() {
        var tree = Tree(5)
        
        XCTAssertEqual(tree.maximumDepth, 1)
        
        var right = Tree(2)
        right.subtrees = [Tree(10)]
        var left = Tree(1)
        left.subtrees = [Tree(3), Tree(7)]
        tree.subtrees = [left, right]
        
        XCTAssertEqual(tree.maximumDepth, 3)
    }
    
    func testTreeFindFirst() {
        var tree = Tree(5)
        
        XCTAssertNil(tree.dfsFindFirst(7))
        
        var right = Tree(2)
        right.subtrees = [Tree(10)]
        var left = Tree(1)
        left.subtrees = [Tree(3), Tree(7)]
        tree.subtrees = [left, right]
        
        XCTAssertEqual(tree.dfsFindFirst(2)?.value, 2)
        XCTAssertEqual(tree.dfsFindFirst(7)?.value, 7)
        XCTAssertEqual(tree.dfsFindFirst(10)?.value, 10)
        XCTAssertNil(tree.dfsFindFirst(19))
    }
    
    func testTreeDescription() {
        var tree = Tree(5)
        
        XCTAssertEqual(tree.description, "5\n")
        
        var right = Tree(2)
        right.subtrees = [Tree(10)]
        var left = Tree(1)
        left.subtrees = [Tree(3), Tree(7)]
        tree.subtrees = [left, right]
        
        XCTAssertEqual(tree.description, "5\n12\n3710\n")
    }
    
    func testTreeEqutable() {
        var tree1 = Tree(5)
        var tree2 = Tree(3)
        
        XCTAssertNotEqual(tree1, tree2)
        
        tree2 = Tree(5)
        
        XCTAssertEqual(tree1, tree2)
        
        var right = Tree(2)
        right.subtrees = [Tree(10)]
        var left = Tree(1)
        left.subtrees = [Tree(3), Tree(7)]
        tree1.subtrees = [left, right]
        
        XCTAssertNotEqual(tree1, tree2)
        
        tree2.subtrees = [left, right]
        
        XCTAssertEqual(tree1, tree2)
    }
}
