import Foundation

// Is A Subsequence
//
// Given two strings, one named `sub` and the other `str`, determine if `sub` is a subsequence of `str`.
// Here are some examples of subsequences: `hen` is a subsequence of `chicken` and `bell` is a subsequence of `barbell`.

extension String {
    // The time complexity will be O(M log N), where M is the length of `sub` (self) and N is the length of `str`.
    // However, the space complexity is O(N)
    public func isSubsequence(of str: String) -> Bool {
        guard !self.isEmpty, !str.isEmpty else {
            return false
        }
        
        // Create a `[Character: [String.Index]]` dictionary by looping each character of `str` from its beginning.
        // Since we start from the beginning, the arrays in the dictionary should be sorted automatically (this is important).
        var indicesOfChars = [Character: [String.Index]]()
        
        for index in str.indices {
            let char = str[index]
            let indicesOfChar = indicesOfChars[char, default: []]
            indicesOfChars[char] = indicesOfChar + [index]
        }
                
        var previousIndex = str.startIndex
        
        // Loop `sub` (self) and check whether there is an index in the above dictionary which is larger than the `previousIndex` variable.
        // When finding such an index, we can adopt binary search because the index arrays in the dictionary are sorted (see `getRightBoundary` method below).
        // If there is no such larger index, then return `false`. Otherwise, return `true`.
        for char in self {
            guard let indicesOfChar = indicesOfChars[char] else {
                return false
            }
            
            let index = indicesOfChar.getRightBoundary(for: previousIndex)
                        
            if previousIndex > index {
                return false
            }
            
            previousIndex = index
        }
        
        return true
    }
    
    // The time complexity will be O(M * N), where M is the length of `sub` (self) and N is the length of `str`.
    public func isSubsequenceAnotherApproach(of str: String) -> Bool {
        guard !self.isEmpty, !str.isEmpty else {
            return false
        }
        
        var previousIndex = str.startIndex
        
        for char in self {
            guard let indexOfChar = str[previousIndex...].firstIndex(of: char) else {
                return false
            }
            
            previousIndex = indexOfChar
        }
        
        return true
    }
}

extension Array where Element == String.Index {
    // The array must be sorted and elements are unique, so we can adopt binary search
    func getRightBoundary(for index: String.Index) -> String.Index {
        var start = self.startIndex
        var end = self.endIndex
        
        while start < end {
            let mid = start + (end - start) / 2
            if index < self[mid] {
                end = mid
            } else {
                start = mid + 1
            }
        }
        
        return start < self.count ? self[start] : self.last!
    }
}

// MARK: - Tests

import XCTest

public final class IsSubsequenceTests: XCTestCase {
    func testIsSubsequence() {
        XCTAssertTrue("bell".isSubsequence(of: "barbell"))
        XCTAssertTrue("bell".isSubsequence(of: "bearbell"))
        XCTAssertTrue("hen".isSubsequence(of: "chicken"))
        XCTAssertTrue("hen".isSubsequence(of: "chincken"))
        XCTAssertTrue("kgb".isSubsequence(of: "kkapggplebb"))
        XCTAssertFalse("kgb".isSubsequence(of: "kfcapple"))
        XCTAssertFalse("kgb".isSubsequence(of: "gbkfcapple"))
        XCTAssertFalse("".isSubsequence(of: "gbkfcapple"))
        XCTAssertFalse("abc".isSubsequence(of: ""))
        
        XCTAssertTrue("bell".isSubsequenceAnotherApproach(of: "barbell"))
        XCTAssertTrue("bell".isSubsequenceAnotherApproach(of: "bearbell"))
        XCTAssertTrue("hen".isSubsequenceAnotherApproach(of: "chicken"))
        XCTAssertTrue("hen".isSubsequenceAnotherApproach(of: "chincken"))
        XCTAssertTrue("kgb".isSubsequenceAnotherApproach(of: "kkapggplebb"))
        XCTAssertFalse("kgb".isSubsequenceAnotherApproach(of: "kfcapple"))
        XCTAssertFalse("kgb".isSubsequenceAnotherApproach(of: "gbkfcapple"))
        XCTAssertFalse("".isSubsequenceAnotherApproach(of: "gbkfcapple"))
        XCTAssertFalse("abc".isSubsequenceAnotherApproach(of: ""))
    }
}
