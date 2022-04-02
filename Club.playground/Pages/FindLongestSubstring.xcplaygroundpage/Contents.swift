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
    
    func testCharacterReplacement() {
        XCTAssertEqual("".characterReplacement(for: 9), 0)
        XCTAssertEqual("ABAB".characterReplacement(for: 2), 4)
        XCTAssertEqual("AABABBA".characterReplacement(for: 1), 4)
    }
}

FindLongestSubstringTests.defaultTestSuite.run()

//: [Next](@next)
