import Foundation

extension String {
    public func countAppearance(of word: String) -> Int {
        guard self.count >= word.count, self.contains(word) else {
            return 0
        }
        
        var result = 0
        let offset = word.count
        for index in self.indices {
            guard let endIndex = self.index(index, offsetBy: offset, limitedBy: self.endIndex) else {
                break
            }
            
            if self[index ..< endIndex] == word {
                result += 1
            }
        }
        
        return result
    }
    
    public func countAppearanceAnotherApproach(_ word: String) -> Int {
        return countAppearanceAnotherApproach(word, start: self.startIndex, result: 0)
    }
    
    private func countAppearanceAnotherApproach(_ word: String, start: Index, result: Int) -> Int {
        let offset = word.count
        guard let end = self.index(start, offsetBy: offset, limitedBy: self.endIndex) else {
            return result
        }
        
        let next = self.index(after: start)
        if self[start ..< end] == word {
            return countAppearanceAnotherApproach(word, start: next, result: result + 1)
        } else {
            return countAppearanceAnotherApproach(word, start: next, result: result)
        }
    }
}

// MARK: - Tests

import XCTest

public final class CountAppearanceTests: XCTestCase {
    func testCountAppearanceNotContainWord() {
        let word = "aaa"
        
        XCTAssertEqual("aa".countAppearance(of: word), 0)
        XCTAssertEqual("bcdf".countAppearance(of: word), 0)
        
        XCTAssertEqual("aa".countAppearanceAnotherApproach(word), 0)
        XCTAssertEqual("bcdf".countAppearanceAnotherApproach(word), 0)
    }
    
    func testCountAppearanceContainsWordOnce() {
        let word = "aaa"
        
        XCTAssertEqual("bcdfaaabytr".countAppearance(of: word), 1)
        
        XCTAssertEqual("bcdfaaabytr".countAppearanceAnotherApproach(word), 1)
    }
    
    func testCountAppearanceContainsWordMoreThanOnce() {
        let word = "aaa"
        
        XCTAssertEqual("aaabcdfaaabytraaa".countAppearance(of: word), 3)
        XCTAssertEqual("aaaa".countAppearance(of: word), 2)
        
        XCTAssertEqual("aaabcdfaaabytraaa".countAppearanceAnotherApproach(word), 3)
        XCTAssertEqual("aaaa".countAppearanceAnotherApproach(word), 2)
    }
}
