import Foundation

// Targets and Vicinities
//
// Targets are digits in the guessed number that have the same value of the digit in actual at the same position.
// Here's an example,
// Actual: "34"
// Guess:  "34"
// Then result is "2T0V"
extension String {
    public func getTargetsVicinities(for guess: String) -> String {
        guard count == guess.count else {
            return "0T0V"
        }
        
        let actualIndices = getCharsIndicesDictionary()
        let guessIndices = guess.getCharsIndicesDictionary()
        
        var numberOfTarget = 0
        var numberOfVicinity = 0
        for (char, indices) in guessIndices {
            guard let indicesOfCharInActual = actualIndices[char] else {
                continue
            }
            
            let intersectionCount = indices.intersection(indicesOfCharInActual).count
            numberOfTarget += intersectionCount
            numberOfVicinity += indices.count - intersectionCount
        }
        
        return "\(numberOfTarget)T\(numberOfVicinity)V"
    }
    
    private func getCharsIndicesDictionary() -> [Character: Set<Index>] {
        var dictionary = [Character: Set<Index>]()
        zip(indices, self).forEach { index, char in
            if let indicesOfChar = dictionary[char] {
                dictionary[char] = indicesOfChar.union([index])
            } else {
                dictionary[char] = [index]
            }
        }
        
        return dictionary
    }
}

// MARK: - Tests

import XCTest

public final class TargetsVicinitiesTests: XCTestCase {
    func testGetTargetsVicinities() {
        XCTAssertEqual("341".getTargetsVicinities(for: "341"), "3T0V")
        XCTAssertEqual("341".getTargetsVicinities(for: "123"), "0T2V")
        XCTAssertEqual("341".getTargetsVicinities(for: "134"), "0T3V")
    }
}
