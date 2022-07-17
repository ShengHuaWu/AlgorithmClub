import Foundation

extension Array where Element == String {
    // Time complexity: O(M * N), where N is the length of array and M is the length of strings
    // Space complexity: O(M * N)
    public func groupAnagrams() -> Set<[String]> {
        guard !self.isEmpty else {
            return []
        }
        
        var groups: [[Character: Int]: [String]] = [:]
        
        for string in self {
            let occurrence = string.getCharOccurrence()
            let group = groups[occurrence, default: []]
            groups[occurrence] = group + [string]
        }
        
        var result: Set<[String]> = []
        
        for (_, value) in groups {
            result.insert(value)
        }
        
        return result
    }
}

extension String {
    func getCharOccurrence() -> [Character: Int] {
        guard !self.isEmpty else {
            return [:]
        }
        
        var occurrences: [Character: Int] = [:]
        
        for char in self {
            let count = occurrences[char, default: 0]
            occurrences[char] = count + 1
        }
        
        return occurrences
    }
    
    // Given two strings self and t,
    // return true if t is an anagram of self, and false otherwise.
    //
    // Time complexity: O(S + T) where S is the length of self and T is the length of t
    // Space complexity: O(S + T)
    public func isAnagram(_ t: String) -> Bool {
        guard self.count == t.count else {
            return false
        }
        
        let countInSelf = self.reduce(into: [Character: Int]()) { result, char in
            result[char] = 1 + result[char, default: 0]
        }
        
        let countInT = t.reduce(into: [Character: Int]()) { result, char in
            result[char] = 1 + result[char, default: 0]
        }
        
        return countInSelf == countInT
    }
    
    // Time complexity: O(N log N) where N is the length of self (and t)
    // Space complexity: O(N) in this case because of immutability
    public func isAnagramWithSorting(with word: String) -> Bool {
        guard count == word.count else { return false }
        
        let sortedSelf = String(lowercased().sorted())
        let sortedWord = String(word.lowercased().sorted())
        
        return sortedSelf == sortedWord
    }
}

// MARK: - Tests

import XCTest

public final class AnagramTests: XCTestCase {
    func testGroupAnagrams() {
        XCTAssertEqual([String]().groupAnagrams(), [])
        
        var target = [""]
        XCTAssertEqual(target.groupAnagrams(), [[""]])
        
        target = ["a"]
        XCTAssertEqual(target.groupAnagrams(), [["a"]])
        
        target = ["eat", "tea", "tan", "ate", "nat", "bat"]
        XCTAssertEqual(target.groupAnagrams(), [["tan", "nat"], ["eat", "tea", "ate"], ["bat"]])
    }
    
    func testIsAnagram() {
        var s = "cat"
        var t = "rat"
        
        XCTAssertFalse(s.isAnagram(t))
        XCTAssertFalse(s.isAnagramWithSorting(with: t))
        
        s = "anagram"
        t = "nagaram"
        
        XCTAssertTrue(s.isAnagram(t))
        XCTAssertTrue(s.isAnagramWithSorting(with: t))
    }
}
