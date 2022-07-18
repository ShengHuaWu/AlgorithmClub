import Foundation

// Find Most Often Character
//
// Given a string, find the character that appears the most often in the string.
extension String {
    public func findMostOftenCharacter() -> Character? {
        guard let first = first else {
            return nil
        }
        
        var charCounts: [Character: Int] = [:]
        for character in self {
            let count = charCounts[character, default: 0]
            charCounts[character] = count + 1
        }
        
        // If the count of two different character are the same, choose the first one
        return charCounts.reduce(first) { result, pair in
            charCounts[result, default: 0] < pair.value ? pair.key : result
        }
    }
    
    public func findMostOftenCharacterAnotherWay() -> Character? {
        guard !isEmpty else {
            return nil
        }
        
        let sortedString = sorted()
        var start = sortedString.startIndex
        var count = 0
        var result = sortedString.first
        for index in sortedString.indices {
            guard sortedString[start] != sortedString[index] else {
                continue
            }
            
            let newCount = index - start
            count = count == 0 ? newCount : count // Make sure the consider the count of the first chararcter after sorting
            result = newCount > count ? sortedString[start] : result
            start = index
        }
        
        return result
    }
    
    // What if the string file is too huge to load into the memory?
    //
    // 1. Divide the file into small pieces which can be loaded into the memory.
    // 2. Sort each small piece one by one to reduce memory consumption.
    // 3. Merge all the piece into one sorted file.
    // 4. Use `findMostOftenCharacterAnotherWay` but load one character at a time.
}

// MARK: - Tests

import XCTest

public final class MostOftenCharacterTests: XCTestCase {
    func testFindMostOftenCharacter() {
        XCTAssertNil("".findMostOftenCharacter())
        XCTAssertEqual("shenghua".findMostOftenCharacter(), "h")
        XCTAssertEqual("what if something goes wrong?".findMostOftenCharacter(), " ")
        
        XCTAssertNil("".findMostOftenCharacterAnotherWay())
        XCTAssertEqual("shenghua".findMostOftenCharacterAnotherWay(), "h")
        XCTAssertEqual("what if something goes wrong?".findMostOftenCharacterAnotherWay(), " ")
    }
}
