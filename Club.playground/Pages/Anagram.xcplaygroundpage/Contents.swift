//: [Previous](@previous)

import XCTest

final class AnagramTests: XCTestCase {
    func testGroupAnagrams() {
        XCTAssertEqual([String]().groupAnagrams(), [])
        
        var target = [""]
        XCTAssertEqual(target.groupAnagrams(), [[""]])
        
        target = ["a"]
        XCTAssertEqual(target.groupAnagrams(), [["a"]])
        
        target = ["eat", "tea", "tan", "ate", "nat", "bat"]
        XCTAssertEqual(target.groupAnagrams(), [["tan", "nat"], ["eat", "tea", "ate"], ["bat"]])
    }
}

AnagramTests.defaultTestSuite.run()

//: [Next](@next)
