//: [Previous](@previous)

import XCTest

final class RecursiveDescriptionTests: XCTestCase {
    func testRecursiveDescriptionNoSubview() {
        let a = View(
            name: "A",
            frame: .init(
                origin: (10, 20),
                size: (300, 400)
            )
        )
        
        let expected = """
        <View: A> <frame: Frame(origin: (x: 10, y: 20), size: (width: 300, height: 400))>
        """
        
        XCTAssertEqual(a.recursiveDescription(), expected)
    }
    
    func testRecursiveDescriptionTwoSubviews() {
        let b = View(
            name: "B",
            frame: .init(
                origin: (10, 20),
                size: (100, 200)
            )
        )
        
        let c = View(
            name: "C",
            frame: .init(
                origin: (20, 40),
                size: (50, 70)
            )
        )
        
        let a = View(
            name: "A",
            frame: .init(
                origin: (10, 20),
                size: (300, 400)
            ),
            subviews: [b, c]
        )
        
        let expected = """
        <View: A> <frame: Frame(origin: (x: 10, y: 20), size: (width: 300, height: 400))>
        |  <View: B> <frame: Frame(origin: (x: 10, y: 20), size: (width: 100, height: 200))>
        |  <View: C> <frame: Frame(origin: (x: 20, y: 40), size: (width: 50, height: 70))>
        """
        
        XCTAssertEqual(a.recursiveDescription(), expected)
    }
    
    func testRecursiveDescriptionNestedSubviews() {
        let d = View(
            name: "D",
            frame: .init(
                origin: (10, 20),
                size: (50, 50)
            )
        )
        
        let e = View(
            name: "E",
            frame: .init(
                origin: (0, 40),
                size: (20, 20)
            )
        )
        
        let b = View(
            name: "B",
            frame: .init(
                origin: (10, 20),
                size: (100, 200)
            ),
            subviews: [d, e]
        )
        
        let f = View(
            name: "F",
            frame: .init(
                origin: (0, 40),
                size: (20, 20)
            )
        )
        
        let c = View(
            name: "C",
            frame: .init(
                origin: (20, 40),
                size: (50, 70)
            ),
            subviews: [f]
        )
        
        let a = View(
            name: "A",
            frame: .init(
                origin: (10, 20),
                size: (300, 400)
            ),
            subviews: [b, c]
        )
        
        let expected = """
        <View: A> <frame: Frame(origin: (x: 10, y: 20), size: (width: 300, height: 400))>
        |  <View: B> <frame: Frame(origin: (x: 10, y: 20), size: (width: 100, height: 200))>
        |  |  <View: D> <frame: Frame(origin: (x: 10, y: 20), size: (width: 50, height: 50))>
        |  |  <View: E> <frame: Frame(origin: (x: 0, y: 40), size: (width: 20, height: 20))>
        |  <View: C> <frame: Frame(origin: (x: 20, y: 40), size: (width: 50, height: 70))>
        |  |  <View: F> <frame: Frame(origin: (x: 0, y: 40), size: (width: 20, height: 20))>
        """
        
        XCTAssertEqual(a.recursiveDescription(), expected)
    }
}

RecursiveDescriptionTests.defaultTestSuite.run()

//: [Next](@next)
