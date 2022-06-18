//: [Previous](@previous)

import XCTest

final class WordBreakTests: XCTestCase {
    func testWordBreak() {
        var target = ""
        var words = ["leet", "code"]
        
        XCTAssertFalse(target.workBreak(in: words))
        
        target = "leetcode"
        
        XCTAssertTrue(target.workBreak(in: words))
        
        target = "leetleet"
        
        XCTAssertTrue(target.workBreak(in: words))
        
        target = "neetcode"
        
        XCTAssertFalse(target.workBreak(in: words))
        
        target = "applepenapple"
        words = ["apple", "pen"]
        
        XCTAssertTrue(target.workBreak(in: words))
    }
}

WordBreakTests.defaultTestSuite.run()

//: [Next](@next)
