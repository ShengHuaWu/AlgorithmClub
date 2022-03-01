//: [Previous](@previous)

import XCTest

final class FindLongestCommonPrefixTests: XCTestCase {
    func testFindLongestCommonPrefix() {
        var target = [String]()
        XCTAssertEqual(target.getLongestCommonPrefix(), "")
        
        target = ["apple"]
        XCTAssertEqual(target.getLongestCommonPrefix(), "apple")
        
        target = ["apple", "ape", "april"]
        XCTAssertEqual(target.getLongestCommonPrefix(), "ap")
        
        target = ["apple", "ape", "bell", "april", "big", "apple"]
        XCTAssertEqual(target.getLongestCommonPrefix(), "ap")
        
        target = ["bell", "apple", "good", "keep", "bell", "big"]
        XCTAssertEqual(target.getLongestCommonPrefix(), "b")
    }
}

FindLongestCommonPrefixTests.defaultTestSuite.run()

//: [Next](@next)
