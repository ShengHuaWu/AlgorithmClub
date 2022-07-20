//: [Previous](@previous)

import XCTest

final class TreeTests: XCTestCase {
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
    
    func testBinaryTreeIsEqual() {
        let tree1 = BinaryTree.leaf
            .inserted(5)
            .inserted(9, at: .right)
            .inserted(6)
            .inserted(10, at: .right)
        
        XCTAssertNotEqual(tree1, .leaf)
        
        let tree2 = tree1
        
        XCTAssertEqual(tree1, tree2)
    }
    
    func testFindAllPaths() {
        let tree = BinaryTree.leaf
            .inserted(5)
            .inserted(3, at: .right)
            .inserted(2)
            .inserted(8, at: .right)
            .inserted(7)
            .inserted(4, at: .right)
            .inserted(9)
        
        XCTAssertEqual(tree.findAllPaths(for: 16), [[5, 3, 8]])
    }
    
    func testFindLowestCommonAncestor() {
        let tree = BinaryTree.leaf
            .inserted(5)
            .inserted(3, at: .right)
            .inserted(2)
            .inserted(8, at: .right)
            .inserted(7)
            .inserted(4, at: .right)
            .inserted(9)
        
        XCTAssertNil(tree.findLowestCommonAncestor(99, 100))
        XCTAssertEqual(tree.findLowestCommonAncestor(2, 3), 5)
        XCTAssertEqual(tree.findLowestCommonAncestor(8, 9), 5)
        
        XCTAssertNil(tree.findLowestCommonAncestorAnotherWay(99, 100))
        XCTAssertEqual(tree.findLowestCommonAncestorAnotherWay(2, 3), 5)
        XCTAssertEqual(tree.findLowestCommonAncestorAnotherWay(8, 9), 5)
    }
}

TreeTests.defaultTestSuite.run()

//: [Next](@next)
