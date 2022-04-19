import Foundation

// You are given an array of non-overlapping intervals intervals
// and intervals is sorted in ascending order by start.
// You are also given an interval `newInterval = (start, end)`
// Insert `newInterval` into intervals such that intervals is still sorted in ascending order
// by start and intervals still does not have any overlapping intervals.

extension Array where Element == (Int, Int) {
    public func insert(_ newInterval: (Int, Int)) -> Self {
        guard !self.isEmpty else {
            return [newInterval]
        }
        
        // Insert `newInterval` into the array and keep the order by start
        var temp: Self = []
        var inserted = false // Track `newInterval` is already inserted or not
        for interval in self {
            if inserted {
                temp.append(interval)
                continue
            }
            
            // case of |-interval-| |--newInterval--|
            if newInterval.0 > interval.1 {
                temp.append(interval)
                continue
            }
            
            // case of |--newInterval--| |-interval-|
            if newInterval.1 < interval.0 {
                temp.append(contentsOf: [newInterval, interval])
                inserted = true
                continue
            }
            
            // case of overlapping
            let new = (
                Swift.min(newInterval.0, interval.0),
                Swift.max(newInterval.1, interval.1)
            )
            temp.append(new)
            inserted = true
        }
        
        // The `newInterval` could be the last one
        if !inserted {
            temp.append(newInterval)
        }
        
        // Merge the intervals
        var result = [temp.first!]
        for interval in temp[1...] {
            var lastOfResult = result.removeLast()
            if lastOfResult.1 >= interval.0 {
                lastOfResult.1 = Swift.max(lastOfResult.1, interval.1)
                result.append(lastOfResult)
            } else {
                result.append(contentsOf: [lastOfResult, interval])
            }
        }
        
        return result
    }
}
