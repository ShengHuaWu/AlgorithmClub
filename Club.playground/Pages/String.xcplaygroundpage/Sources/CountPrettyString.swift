import Foundation

// Definition of a pretty string:
// A string is pretty means that it contains only one repeating character,
// for example, `"abc"` is NOT a pretty string, but `"aaa"` is a pretty string with repeating 3.

extension String {
    public func countPrettyString(with repeating: Int) -> Int {
        guard self.count >= repeating else {
            return 0
        }
        
        return recursiveCountPrettyString(start: self.startIndex, repeating: repeating, result: 0)
    }
}

private extension String {
    func recursiveCountPrettyString(start: Index, repeating: Int, result: Int) -> Int {
        guard start < self.endIndex else {
            return result
        }
        
        let newStart = self.index(after: start)
        
        if isPrettyString(start: start, repeating: repeating) {
            return recursiveCountPrettyString(start: newStart, repeating: repeating, result: result + 1)
        } else {
            return recursiveCountPrettyString(start: newStart, repeating: repeating, result: result)
        }
    }
 
    func isPrettyString(start: Index, repeating: Int) -> Bool {
        guard self.distance(from: start, to: self.endIndex) >= repeating else {
            return false
        }
        
        var offset = repeating - 1
        
        while offset > 0 {
            let index = self.index(start, offsetBy: offset)
                        
            guard self[start] == self[index] else {
                return false
            }
            
            offset -= 1
        }
        
        return true
    }
}

// MARK: - Tests

import XCTest

public final class CountPrettyStringTests: XCTestCase {
    func testCountPrettyString() {
        var text = ""
        XCTAssertEqual(text.countPrettyString(with: 3), 0)

        text = "zooo"
        XCTAssertEqual(text.countPrettyString(with: 3), 1)

        text = "zoookkkklfuckaabbbccdceff"
        XCTAssertEqual(text.countPrettyString(with: 3), 4)
    }
}
