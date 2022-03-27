//: [Previous](@previous)

import XCTest

final class TreeTests: XCTestCase {
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
}

TreeTests.defaultTestSuite.run()

//: [Next](@next)
