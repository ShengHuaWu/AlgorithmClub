//: [Previous](@previous)

import XCTest

final class FindPalindromeTests: XCTestCase {
    func testFindPalindrome() {
        XCTAssertEqual("".findPalindromes(), [])
        XCTAssertEqual("ab".findPalindromes(), [])
        XCTAssertEqual("aaaa".findPalindromes(), ["aa", "aaa", "aaaa"])
        XCTAssertEqual("aabbbaa".findPalindromes(), ["aabbbaa", "aa", "abbba", "bbb", "bb"])
    }
    
    func testFindLongestPalindromeSubstring() {
        XCTAssertEqual("".findLongestPalindromeSubstring(), "")
        XCTAssertEqual("babad".findLongestPalindromeSubstring(), "bab")
        XCTAssertEqual("aabbbaa".findLongestPalindromeSubstring(), "aabbbaa")
        XCTAssertEqual("forgeeksskeegfor".findLongestPalindromeSubstring(), "geeksskeeg")
    }
}

FindPalindromeTests.defaultTestSuite.run()

//: [Next](@next)
