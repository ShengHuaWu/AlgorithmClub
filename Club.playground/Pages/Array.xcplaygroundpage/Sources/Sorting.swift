import Foundation

// Quick Sort
//
// The time complexity is O(n log n).
// 1. Split the array into three parts based on a pivot variable.
// 2. All the elements less than the pivot go into a new array called less.
//  All the elements equal to the pivot go into the equal array.
//  All elements greater than the pivot go into the greater array.
// 3. Once we have these three arrays, quick sort recursively sorts the less array
//  and the greater array, then glues those sorted subarrays back together
//  with the equal array to get the final result.
extension Array where Element: Comparable {
    public func quickSorting() -> [Element] {
        guard count > 1 else { return self }
        
        let pivot = self[count / 2]
        let less = filter { $0 < pivot }
        let equal = filter { $0 == pivot }
        let greater = filter { $0 > pivot }
        
        return less.quickSorting() + equal + greater.quickSorting()
    }
}

// Merge Sort
//
// Divide and conquer. This is NOT an in-place sort. The time complexity is O(n log n).
// 1. Split the array into two unsorted piles.
// 2. Keep splitting the resulting piles until you cannot split anymore.
//  In the end, you will have n piles with one number in each pile.
// 3. Begin to merge the piles together by pairing them sequentially.
//  During each merge, put the contents in sorted order.
extension Array where Element: Comparable {
    public func mergeSorting() -> [Element] {
        guard count > 1 else { return self }
        
        let mid = count / 2
        let left = Array(self[0 ..< mid]).mergeSorting()
        let right = Array(self[mid ..< count]).mergeSorting()
        
        return left.merging(with: right)
    }
    
    private func merging(with pile: [Element]) -> [Element] {
        var selfIndex = startIndex
        var pileIndex = pile.startIndex
        var results = [Element]()
        
        while selfIndex < count && pileIndex < pile.count {
            let selfElement = self[selfIndex]
            let pileElement = pile[pileIndex]
            if selfElement < pileElement {
                results.append(selfElement)
                selfIndex += 1
            } else if selfElement > pileElement {
                results.append(pileElement)
                pileIndex += 1
            } else {
                results.append(selfElement)
                selfIndex += 1
                results.append(pileElement)
                pileIndex += 1
            }
        }
        
        while selfIndex < count {
            results.append(self[selfIndex])
            selfIndex += 1
        }
        
        while pileIndex < pile.count {
            results.append(pile[pileIndex])
            pileIndex += 1
        }
        
        return results
    }
}

// MARK: - Tests

import XCTest

public final class SortingTests: XCTestCase {
    func testSorting() {
        let numbers = [-10, -3, 0, 1, 3, 4, 6, 9, 12, 29]
        XCTAssertEqual(numbers.quickSorting(), [-10, -3, 0, 1, 3, 4, 6, 9, 12, 29])
        XCTAssertEqual(numbers.mergeSorting(), [-10, -3, 0, 1, 3, 4, 6, 9, 12, 29])
    }
}
