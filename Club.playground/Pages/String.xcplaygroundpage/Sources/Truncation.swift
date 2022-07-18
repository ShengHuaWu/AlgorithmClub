import Foundation

// Truncation
extension String {
    public func recursiveTruncate(with length: Int) -> String {
        guard !isEmpty, length > 0, count > length else { return self }
        
        return recursiveTruncate(with: length, end: index(startIndex, offsetBy: length))
    }
    
    private func recursiveTruncate(with length: Int, end: Index) -> String {
        guard end > startIndex else { return "" }
        
        switch self[end] {
        case ".", ",", ":", ";", "?", "!", " ":
            return String(self[startIndex ... end])
        default:
            return recursiveTruncate(with: length, end: index(before: end))
        }
    }
}

// MARK: - Tests

import XCTest

public final class TruncationTests: XCTestCase {
    func testTruncation() {
        let text = """
        Grab, the ride-hailing company competing with Uber in Southeast Asia, has pulled in $2 billion of new financing from existing investors Didi Chuxing, the company that defeated Uber in China, and SoftBank.
        """
        XCTAssertEqual(text.recursiveTruncate(with: 16), "Grab, the ")
    }
}
