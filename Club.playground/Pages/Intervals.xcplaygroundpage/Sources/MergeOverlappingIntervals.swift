import Foundation

// Merge Overlapping Intervals
//
// You are given an array (list) of interval pairs as input where each interval has a start and end timestamp.
// The input array is sorted by starting timestamps.
// You are required to merge overlapping intervals and return a new output array.
// Consider the input array below.
// Intervals (1, 5), (3, 7), (4, 6), (6, 8) are overlapping so they should be merged to one big interval (1, 8).
// Similarly, intervals (10, 12) and (12, 15) are also overlapping and should be merged to (10, 15).

extension Array where Element == (Int, Int) {
    public func mergeOverlappings() -> Self {
        guard let first = self.first else {
            return self
        }
        
        var result = [first]
        for interval in self[1...] {
            var lastOfResult = result.removeLast()
            if lastOfResult.1 > interval.0 {
                lastOfResult.1 = Swift.max(lastOfResult.1, interval.1)
                result.append(lastOfResult)
            } else {
                result.append(contentsOf: [lastOfResult, interval])
            }
        }
        
        return result
    }
}
