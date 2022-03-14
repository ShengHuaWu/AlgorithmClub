import Foundation

// Given an array of intervals `[(start, end)]`,
// return the minimum number of intervals
// you need to remove to make the rest of the intervals non-overlapping.

extension Array where Element == (Int, Int) {
    public func eraseOverlapping() -> Int {
        guard !self.isEmpty else {
            return 0
        }
        
        let sorted = self.sorted { $0.0 < $1.0 } // Sorted by start
        var count = 0
        var temp = [sorted.first!]
        for interval in sorted[1...] {
            let last = temp.removeLast()
            
            guard last.1 > interval.0 else {
                temp.append(contentsOf: [last, interval])
                continue
            }
            
            count += 1 // If `last` & `interval` are overlapping, increase `count`
            
            // Drop the one with larger end, because we want minimum number of removal
            if last.1 > interval.1 {
                temp.append(interval)
            } else {
                temp.append(last)
            }
        }
        
        return count
    }
}
