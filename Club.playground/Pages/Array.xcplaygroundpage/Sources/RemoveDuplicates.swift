import Foundation

// Remove duplication
//
// Given an list of hashables, remove duplications but keep the order
extension Array where Element: Hashable, Element: Comparable {
    public func removeDuplicates() -> [Element] {
        var uniques: Set<Element> = []
        
        return filter { element in
            if uniques.contains(element) {
                return false
            } else {
                uniques.insert(element)
                
                return true
            }
        }
    }
    
    // What if the list is stored on the disk and it's huge (< 10 TB),
    // remove duplications with any new order
    //
    // 1. Divide the list into small pieces which can be loaded into the memory.
    // 2. Sort and remove duplicates for each small piece
    // 3. Store each small piece
    // 4. Load the first element of the two pieces A and B:
    //    If they are the same,
    //    then only store one into the result,
    //    and move to the next elements of both A and B
    //
    //    If thet are NOT the same,
    //    then only store the acending (small) one into the result,
    //    and move to the next element only of the acending one
    //
    //    If there are reminding elements of A or B, store them into the result
    // 5. Repeat above the comparison between the result and the reminding pieces.
    public func removeDuplicatesFromMassiveData() -> [Element] {
        // Split big array into small chunks
        let size = 2 // Could change depends on the memory size
        var chunks = self.chunked(into: size)
        
        guard chunks.count > 1 else {
            return chunks.first?.removeDuplicates() ?? []
        }
        
        // Merge first and second chunks into result
        let first = chunks.removeFirst().removeDuplicates()
        let second = chunks.removeFirst().removeDuplicates()
        var result = first.merged(with: second)
        
        // Merge result with the reminders in `chunks`
        for chunk in chunks {
            let noDuplicates = chunk.removeDuplicates()
            result = result.merged(with: noDuplicates)
        }
        
        return result
    }
}

extension Array where Element: Comparable {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    func merged(with another: [Element]) -> [Element] {
        let first = self.sorted()
        let second = another.sorted()
        
        var result = [Element]()
        var indexOfFirst = 0
        var indexOfSecond = 0
        while indexOfFirst < first.count && indexOfSecond < second.count {
            let elementOfFirst = first[indexOfFirst]
            let elementOfSecond = second[indexOfSecond]
            
            if elementOfFirst < elementOfSecond {
                result.append(elementOfFirst)
                indexOfFirst += 1
            } else if elementOfSecond < elementOfFirst {
                result.append(elementOfSecond)
                indexOfSecond += 1
            } else {
                result.append(elementOfSecond)
                indexOfFirst += 1
                indexOfSecond += 1
            }
        }
        
        if indexOfFirst < first.count {
            result.append(contentsOf: first[indexOfFirst...])
        }
        
        if indexOfSecond < second.count {
            result.append(contentsOf: second[indexOfSecond...])
        }
        
        return result
    }
}

// MARK: - Tests

import XCTest

public final class RemoveDuplicatesTests: XCTestCase {
    func testRemoveDuplicatesWithEmptyArrays() {
        XCTAssertEqual([Int]().removeDuplicates(), [])
        XCTAssertEqual([String]().removeDuplicates(), [])
    }
    
    func testRemoveDuplicatesWithIntegers() {
        var taregt = [1, 2, 3, 3, 2, 1]
        var expect = [1, 2, 3]
        
        XCTAssertEqual(taregt.removeDuplicates(), expect)
        XCTAssertEqual(taregt.removeDuplicatesFromMassiveData(), expect)
        
        taregt = [3, 2, 1, 1, 2, 3]
        expect = [3, 2, 1]
        
        XCTAssertEqual(taregt.removeDuplicates(), expect)
        XCTAssertEqual(taregt.removeDuplicatesFromMassiveData(), [1, 2, 3]) // the list is sorted
        
        taregt = [1, 1, 2, 2, 3, 3]
        expect = [1, 2, 3]
        
        XCTAssertEqual(taregt.removeDuplicates(), expect)
        XCTAssertEqual(taregt.removeDuplicatesFromMassiveData(), expect)
    }
    
    func testRemoveDuplicatesWithStrings() {
        var taregt = ["1", "2", "3", "3", "2", "1"]
        var expect = ["1", "2", "3"]
        
        XCTAssertEqual(taregt.removeDuplicates(), expect)
        XCTAssertEqual(taregt.removeDuplicatesFromMassiveData(), expect)
        
        taregt = ["3", "2", "1", "1", "2", "3"]
        expect = ["3", "2", "1"]
        
        XCTAssertEqual(taregt.removeDuplicates(), expect)
        XCTAssertEqual(taregt.removeDuplicatesFromMassiveData(), ["1", "2", "3"]) // the list is sorted
        
        taregt = ["1", "1", "2", "2", "3", "3"]
        expect = ["1", "2", "3"]
        
        XCTAssertEqual(taregt.removeDuplicates(), expect)
        XCTAssertEqual(taregt.removeDuplicatesFromMassiveData(), expect)
    }
}
