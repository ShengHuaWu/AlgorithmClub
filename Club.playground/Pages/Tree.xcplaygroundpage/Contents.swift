//: [Previous](@previous)

import XCTest

final class TreeTests: XCTestCase {
    func testFindFirst() {
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
    
    func testDescription() {
        var tree = Tree(5)
        
        XCTAssertEqual(tree.description, "5\n")
        
        var right = Tree(2)
        right.subtrees = [Tree(10)]
        var left = Tree(1)
        left.subtrees = [Tree(3), Tree(7)]
        tree.subtrees = [left, right]
        
        XCTAssertEqual(tree.description, "5\n12\n3710\n")
    }
}

TreeTests.defaultTestSuite.run()

//: [Next](@next)
