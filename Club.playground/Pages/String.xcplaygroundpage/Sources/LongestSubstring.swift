import Foundation

// Longest Substring Without Repeating Characters

extension String {
    public func findLongestSubstringWithoutRepeating() -> Self {
        guard !self.isEmpty else {
            return self
        }
        
        var start = self.startIndex
        var end = start
        
        var low = start
        var high = start
        
        var nonrepeating: Set<Character> = []
        
        // `self.endIndex` does NOT contain character
        while let newHigh = self.index(high, offsetBy: 1, limitedBy: self.endIndex) {
            let char = self[high]
            
            if nonrepeating.contains(char) {
                nonrepeating.removeAll()
                low = high
            }
            
            nonrepeating.insert(char)
            
            if self.distance(from: start, to: end) < self.distance(from: low, to: high) {
                start = low
                end = high
            }
            
            high = newHigh // Assign the high after comparison
        }
        
        return String(self[start...end])
    }
}

// Longest Substring With No More Than ‘K’ Distinct Characters
//
// Given a string, find the length of the longest substring in it with no more than K distinct characters.
extension String {
    public func findLongestSubstringWithNoMoreThan(kDistinctCharacters k: Int) -> String {
        guard !isEmpty else {
            return ""
        }
        
        var distinctChars: Set<Character> = []
        
        // Store the count of characters present in the distinct characters.
        var charCounts: [Character: Int] = [:]
        
        // Store the longest substring boundaries
        var start = startIndex
        var end = start
        
        // Maintains the sliding window boundaries
        var low = start
        var high = start
        
        while let newHigh = index(high, offsetBy: 1, limitedBy: endIndex) {
            let char = self[high]
            distinctChars.insert(char)
            let count = charCounts[char, default: 0]
            charCounts[char] = count + 1
            
            // If the count is more than `k`, remove characters from the left
            while distinctChars.count > k {
                let charToBeRemoved = self[low]
                if let count = charCounts[charToBeRemoved] {
                    let newCount = count - 1
                    charCounts[charToBeRemoved] = newCount
                    
                    // If the leftmost character's count becomes 0 after removing it in the window, remove it from the set as well
                    if newCount == 0 {
                        distinctChars.remove(charToBeRemoved)
                    }
                }
                
                // Reduce window size
                if let newLow = index(low, offsetBy: 1, limitedBy: endIndex) {
                    low = newLow
                }
            }
            
            // Update the maximum window size if necessary
            if distance(from: start, to: end) < distance(from: low, to: high) {
                start = low
                end = high
            }
            
            high = newHigh // Update high after the comparison
        }
        
        return String(self[start ... end])
    }
}

// MARK: - Tests

import XCTest

public final class FindLongestSubstringTests: XCTestCase {
    func testFindLongestSubstringWithoutRepeating() {
        XCTAssertEqual("".findLongestSubstringWithoutRepeating(), "")
        XCTAssertEqual("aaa".findLongestSubstringWithoutRepeating(), "a")
        XCTAssertEqual("abced".findLongestSubstringWithoutRepeating(), "abced")
        XCTAssertEqual("aaabced".findLongestSubstringWithoutRepeating(), "abced")
        XCTAssertEqual("abbced".findLongestSubstringWithoutRepeating(), "bced")
        XCTAssertEqual("abcedd".findLongestSubstringWithoutRepeating(), "abced")
        XCTAssertEqual("aabbcedd".findLongestSubstringWithoutRepeating(), "bced")
    }
    
    func testFindLongestSubstringWithNoMoreThan() {
        XCTAssertEqual("".findLongestSubstringWithNoMoreThan(kDistinctCharacters: 2), "")
        XCTAssertEqual("aabbaacc".findLongestSubstringWithNoMoreThan(kDistinctCharacters: 2), "aabbaa")
        XCTAssertEqual("aaabbcc".findLongestSubstringWithNoMoreThan(kDistinctCharacters: 2), "aaabb")
        XCTAssertEqual("aabbccc".findLongestSubstringWithNoMoreThan(kDistinctCharacters: 2), "bbccc")
    }
}
