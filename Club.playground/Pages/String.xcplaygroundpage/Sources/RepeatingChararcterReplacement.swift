import Foundation

// Given a string `s` and an integer `k`,
// you can choose any character of the string
// and change it to any other uppercase English character.
// You can perform this operation at most `k` times.
// Return the length of the longest substring containing the same letter
// you can get after performing the above operations.

// This quiz is very similar to `findLongestSubstringWithoutRepeating`

extension String {
    public func characterReplacement(for k: Int) -> Int {
        guard !self.isEmpty else {
            return 0
        }
        
        var start = self.startIndex
        var end = start
        
        var low = start
        var high = start
        
        var occurrence: [Character: Int] = [:] // Track the count of each character
        
        while let newHigh = self.index(high, offsetBy: 1, limitedBy: self.endIndex) {            
            let char = self[high]
            let count = occurrence[char, default: 0]
            occurrence[char] = count + 1
            
            // Keep the number of non-repeating characters smaller than `k`
            if occurrence.nonrepeatingCount() > k  {
                let char = self[low]
                let count = occurrence[char, default: 0]
                occurrence[char] = count - 1
                low = self.index(after: low)
            }
            
            if self.distance(from: start, to: end) < self.distance(from: low, to: high) {
                start = low
                end = high
            }
            
            high = newHigh
        }
                
        return self.distance(from: start, to: end) + 1 // Don't forget to plus 1
    }
}

extension Dictionary where Key == Character, Value == Int {
    func nonrepeatingCount() -> Int {
        var sum = 0
        var maxOccurrenceCount = 0
        
        for (_, count) in self {
            sum += count
            maxOccurrenceCount = Swift.max(count, maxOccurrenceCount)
        }
        
        return sum - maxOccurrenceCount
    }
}

// MARK: - Tests

import XCTest

public final class CharacterReplacementTests: XCTestCase {
    func testCharacterReplacement() {
        XCTAssertEqual("".characterReplacement(for: 9), 0)
        XCTAssertEqual("ABAB".characterReplacement(for: 2), 4)
        XCTAssertEqual("AABABBA".characterReplacement(for: 1), 4)
    }
}
