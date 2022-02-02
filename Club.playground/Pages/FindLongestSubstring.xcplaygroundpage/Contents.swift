//: [Previous](@previous)

import XCTest

final class FindLongestSubstringTests: XCTestCase {
    func testFindLongestSubstringWithoutRepeating() {
        XCTAssertEqual("".findLongestSubstringWithoutRepeating(), "")
        XCTAssertEqual("aaa".findLongestSubstringWithoutRepeating(), "a")
        XCTAssertEqual("abced".findLongestSubstringWithoutRepeating(), "abced")
        XCTAssertEqual("aaabced".findLongestSubstringWithoutRepeating(), "abced")
        XCTAssertEqual("abbced".findLongestSubstringWithoutRepeating(), "bced")
        XCTAssertEqual("abcedd".findLongestSubstringWithoutRepeating(), "abced")
        XCTAssertEqual("aabbcedd".findLongestSubstringWithoutRepeating(), "bced")
    }
}

FindLongestSubstringTests.defaultTestSuite.run()

//: [Next](@next)
