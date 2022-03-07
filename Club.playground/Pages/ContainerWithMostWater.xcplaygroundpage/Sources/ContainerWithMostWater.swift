import Foundation

// You are given an integer array height of length n.
// There are n vertical lines drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).
// Find two lines that together with the x-axis form a container,
// such that the container contains the most water.
// Return the maximum amount of water a container can store.

extension Array where Element == Int {
    // https://www.geeksforgeeks.org/container-with-most-water/
    public func getMostWater() -> Int? {
        guard self.count > 1 else {
            return nil
        }
        
        var start = self.startIndex
        var end = self.endIndex - 1
        var result = Swift.min(self[start], self[end]) * (end - start)
        
        while start < end {
            let startElement = self[start]
            let endElement = self[end]
            
            let volume = Swift.min(startElement, endElement) * (end - start)
            result = Swift.max(volume, result)
            if startElement > endElement {
                end -= 1
            } else {
                start += 1
            }
        }
        
        return result
    }
}
