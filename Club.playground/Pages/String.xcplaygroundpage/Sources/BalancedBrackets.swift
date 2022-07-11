import Foundation

// Balanced Brackets
//
// We're provided a string like the following: "{[])}" that is inclusive of the following symbols:
// parentheses `()`, brackets `[]`, and curly braces `{}`.
// Write a function that will check if the symbol pairings in the string follow these below conditions:
// They are correctly ordered, meaning opening braces/symbols should come first.
// They contain the correct pairings, so every opening brace has a closing one.
// They are both of the same kind in a pair, so an opening parenthesis does not close with a closing curly brace.
// For example, `()` is valid. `((` is not. Similarly, `{{[]}}` is valid. `[[}}` is not.

enum Bracket: String {
    case openParenthese = "("
    case closeParenthese = ")"
    case openBracket = "["
    case closeBracket = "]"
    case openCurlyBrace = "{"
    case closeCurlyBrace = "}"
}

extension String {
    public func hasBalancedBrackets() -> Bool {
        guard !self.isEmpty else {
            return true
        }
        
        // The arrays in this dictionary will be sorted because we walk through the indices
        var bracketWithIndices = [Bracket: [Index]]()
        for index in self.indices {
            guard let bracket = Bracket(rawValue: String(self[index])) else {
                return false
            }
            
            let indicesOfBracket = bracketWithIndices[bracket, default: []]
            bracketWithIndices[bracket] = indicesOfBracket + [index]
        }
        
        return bracketWithIndices.isBalanced()
    }
}

extension Dictionary where Key == Bracket, Value == [String.Index] {
    func isBalanced() -> Bool {
        guard let openIndices = self[.openParenthese],
              let closeIndices = self[.closeParenthese],
              isBalanced(openIndices, closeIndices) else {
            return false
        }
        
        guard let openIndices = self[.openBracket],
              let closeIndices = self[.closeBracket],
              isBalanced(openIndices, closeIndices) else {
            return false
        }
        
        guard let openIndices = self[.openCurlyBrace],
              let closeIndices = self[.closeCurlyBrace],
              isBalanced(openIndices, closeIndices) else {
            return false
        }
        
        return true
    }
    
    private func isBalanced(_ openIndices: [String.Index], _ closeIndices: [String.Index]) -> Bool {
        // First of all, check the amount of the open and close indices are the same
        guard openIndices.count == closeIndices.count else {
            return false
        }
        
        // The first open one must occur before the first close one,
        // and this rule should apply for all the indices, for instance, `(())` or `()()`
        return zip(openIndices, closeIndices).reduce(true) { result, indexPair in
            return result && indexPair.0 < indexPair.1
        }
    }
}

// Print Balanced Brace Combinations
//
// Find all braces combinations for a given value ‘N’ so that they are balanced.
public func findAllBraceCombinations(for target: Int) -> [String] {
    guard target > 0 else {
        return []
    }
    
    var temp = ""
    var results = [String]()
    findAllBraceCombinations(openCount: 0, closeCount: 0, target: target, temp: &temp, results: &results)
    
    return results
}

private func findAllBraceCombinations(openCount: Int, closeCount: Int, target: Int, temp: inout String, results: inout [String]) {
    if closeCount == target {
        results.append(temp)
        return
    }
    
    // Append close brace if close count is less than open count
    if openCount > closeCount {
        temp.append("}")
        findAllBraceCombinations(openCount: openCount, closeCount: closeCount + 1, target: target, temp: &temp, results: &results)
        temp.removeLast() // Removing the last element from list (backtracking)
    }
    
    // Append open brace if open count is less than target
    if openCount < target {
        temp.append("{")
        findAllBraceCombinations(openCount: openCount + 1, closeCount: closeCount, target: target, temp: &temp, results: &results)
        temp.removeLast() // Removing the last element from list (backtracking)
    }
}

// MARK: - Tests

import XCTest

public final class BalancedBracketsTests: XCTestCase {
    func testHasBalancedBrackets() {
        XCTAssertTrue("".hasBalancedBrackets())
        XCTAssertTrue("{{{{{[[()()]]}}}}}[]{}".hasBalancedBrackets())
        XCTAssertTrue("{{{{{[[()()]()]}()}}}}{}[]{}".hasBalancedBrackets())
        XCTAssertFalse("{{]](())".hasBalancedBrackets())
        XCTAssertFalse("{{]](()){{}}}{{()".hasBalancedBrackets())
    }
    
    func testFindAllBraceCombinations() {
        XCTAssertEqual(findAllBraceCombinations(for: 0), [])
        XCTAssertEqual(findAllBraceCombinations(for: 3), ["{}{}{}", "{}{{}}", "{{}}{}", "{{}{}}", "{{{}}}"])
    }
}
