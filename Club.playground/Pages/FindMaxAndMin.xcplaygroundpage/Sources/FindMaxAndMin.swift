import Foundation

// Find both the maximum and minimum values contained in array
// while minimizing the number of comparisons we can compare the items in pairs.

extension Array where Element: Comparable {
    public func findMaxAndMin() -> (Element, Element)? {
        guard !self.isEmpty else {
            return nil
        }
        
        var copy = self
        if !copy.count.isMultiple(of: 2) {
            copy.append(copy.first!)
        }
        
        var max: Element = copy.first!
        var min: Element = max
        
        while !copy.isEmpty {
            let first = copy.removeFirst()
            let second = copy.removeFirst()
            
            if first > second {
                max = Swift.max(first, max)
                min = Swift.min(second, min)
            } else {
                max = Swift.max(second, max)
                min = Swift.min(first, min)
            }
        }
        
        return (max, min)
    }
}
