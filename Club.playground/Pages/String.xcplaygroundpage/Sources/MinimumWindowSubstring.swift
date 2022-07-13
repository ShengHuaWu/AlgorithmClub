import Foundation

// Minimum Window Substring
//
// Given two strings self and t of lengths m and n respectively,
// return the minimum window substring of s
// such that every character in t (including duplicates) is included in the window.
// If there is no such substring, return the empty string "".

extension String {
    // 1. Use two dictionaries (`countT` & `window`) to compare the count of characters
    // 2. Use two integers (`need` & `have`) to find the minimum length
    //
    // Time complexity: O(N) where N is the length of self
    // Reference: https://www.youtube.com/watch?v=jSto0O4AJbM
    public func minimumWindow(of t: String) -> String {
        guard !t.isEmpty else {
            return ""
        }
        
        let countT = t.reduce(into: [Character: Int]()) { result, char in
            result[char] = result[char, default: 0] + 1
        }
        let need = countT.keys.count // How many characters are needed matching
        
        var window = [Character: Int]() // Store the count of each character in current window
        var have = 0
        
        var left = self.startIndex
        
        var resultLeft = left
        var resultRight = resultLeft
        var resultLength = Int.max
        
        for right in self.indices {
            let char = self[right]
            window[char] = window[char, default: 0] + 1
            
            // Only increase `have` when the counts in two dictionaries are equal
            if let countInT = countT[char], countInT == window[char] {
                have += 1
            }
            
            // Comparing `have` and `need` can reduce the complexity.
            // Otherwise, we have to look inside `countT` and `window` in each iteration
            while have == need {
                // Update result
                let length = self.distance(from: left, to: right)
                if length < resultLength {
                    resultLeft = left
                    resultRight = right
                    resultLength = length
                }
                
                // Pop character from left
                let leftChar = self[left]
                let leftCount = window[leftChar, default: 0] - 1
                window[leftChar] = leftCount
                
                if let countInT = countT[leftChar], leftCount < countInT {
                    have -= 1
                }
                
                left = self.index(after: left)
            }
        }
        
        // Return empty string if there is no such substring
        return resultLength < Int.max ? String(self[resultLeft...resultRight]) : ""
    }
}

// MARK: - Tests

import XCTest

public final class MinimimWindowSubstringTests: XCTestCase {
    func testMinimumWindow() {
        var s = "ADOBECODEBANC"
        var t = ""
        
        XCTAssertTrue(s.minimumWindow(of: t).isEmpty)
        
        t = "ABC"
        
        XCTAssertEqual(s.minimumWindow(of: t), "BANC")
        
        s = "a"
        t = "a"
        
        XCTAssertEqual(s.minimumWindow(of: t), "a")
        
        t = "aa"
        
        XCTAssertTrue(s.minimumWindow(of: t).isEmpty)
        
        s = "aa"
        
        XCTAssertEqual(s.minimumWindow(of: t), "aa")
    }
}
