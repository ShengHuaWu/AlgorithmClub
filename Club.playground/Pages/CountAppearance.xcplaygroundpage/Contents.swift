//: [Previous](@previous)

import XCTest

final class CountAppearanceTests: XCTestCase {
    func testCountAppearanceNotContainWord() {
        let word = "aaa"
        
        XCTAssertEqual("aa".countAppearance(of: word), 0)
        XCTAssertEqual("bcdf".countAppearance(of: word), 0)
        
        XCTAssertEqual("aa".countAppearanceAnotherApproach(word), 0)
        XCTAssertEqual("bcdf".countAppearanceAnotherApproach(word), 0)
    }
    
    func testCountAppearanceContainsWordOnce() {
        let word = "aaa"
        
        XCTAssertEqual("bcdfaaabytr".countAppearance(of: word), 1)
        
        XCTAssertEqual("bcdfaaabytr".countAppearanceAnotherApproach(word), 1)
    }
    
    func testCountAppearanceContainsWordMoreThanOnce() {
        let word = "aaa"
        
        XCTAssertEqual("aaabcdfaaabytraaa".countAppearance(of: word), 3)
        XCTAssertEqual("aaaa".countAppearance(of: word), 2)
        
        XCTAssertEqual("aaabcdfaaabytraaa".countAppearanceAnotherApproach(word), 3)
        XCTAssertEqual("aaaa".countAppearanceAnotherApproach(word), 2)
    }
}

CountAppearanceTests.defaultTestSuite.run()

//: [Next](@next)
