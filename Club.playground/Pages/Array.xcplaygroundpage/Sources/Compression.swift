import Foundation

// Compression
//
// The array should be sorted at first.
extension Array where Element == Int {
    public func compress() -> [String] {
        var results = [String]()
        var start = startIndex
        var index = startIndex + 1
        
        while index < endIndex {
            if self[index] != self[index - 1] + 1 {
                let output = compressNumber(start: start, end: index)
                results.append(output)
                start = index
            }
            
            index += 1
        }
        
        if start == index {
            results.append("\(self[index])")
        } else {
            let output = compressNumber(start: start, end: index)
            results.append(output)
        }
        
        return results
    }
    
    public func recursiveCompress() -> [String] {
        return recursiveCompress(start: startIndex, end: startIndex + 1, result: [])
    }
    
    private func recursiveCompress(start: Index, end: Index, result: [String]) -> [String] {
        guard end < endIndex else {
            return result + [compressNumber(start: start, end: end)]
        }
        
        if self[end] - self[end - 1] > 1 {
            return [compressNumber(start: start, end: end)] + recursiveCompress(start: end, end: end + 1, result: result)
        } else {
            return recursiveCompress(start: start, end: end + 1, result: result)
        }
    }
    
    private func compressNumber(start: Index, end: Index) -> String {
        return self[start] == self[end - 1] ? "\(self[start])" : "\(self[start])-\(self[end - 1])"
    }
}

// MARK: - Tests

import XCTest

public final class CompressionTests: XCTestCase {
    func testRecursiveCompress() {
        XCTAssertEqual([1, 2, 3, 4, 5, 8, 9, 11, 14, 17].compress(), ["1-5", "8-9", "11", "14", "17"])
        XCTAssertEqual([1, 2, 3, 4, 5, 8, 9, 11, 14, 17].recursiveCompress(), ["1-5", "8-9", "11", "14", "17"])
    }
}
