import Foundation

// You are given an array of non-overlapping intervals intervals
// and intervals is sorted in ascending order by start.
// You are also given an interval `newInterval = (start, end)`
// that represents the start and end of another interval.
// Insert `newInterval` into intervals such that intervals is still sorted in ascending order
// by start and intervals still does not have any overlapping intervals
// (merge overlapping intervals if necessary).

extension Array where Element == (Int, Int) {
    public func insert(_ newInterval: (Int, Int)) -> Self {
        guard !self.isEmpty else {
            return [newInterval]
        }
        
        var result: Self = []
        var new = newInterval
        
        for index in self.indices {
            let interval = self[index]
            
            if interval.0 > new.1 {
                result.append(new)
                result.append(interval)
            } else if interval.1 < new.0 {
                result.append(interval)
                if index == self.count - 1 {
                    result.append(new)
                }
            } else if interval.1 > new.0 {
                new.0 = Swift.min(interval.0, new.0)
                new.1 = Swift.max(interval.1, new.1)
                if index == self.count - 1 {
                    result.append(new)
                }
            }
        }
        
        return result
    }
}
