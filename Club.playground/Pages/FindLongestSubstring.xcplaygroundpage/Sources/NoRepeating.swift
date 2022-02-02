import Foundation

// Longest Substring Without Repeating Characters

extension String {
    public func findLongestSubstringWithoutRepeating() -> Self {
        guard !self.isEmpty else {
            return self
        }
        
        var start = self.startIndex
        var end = start
        
        var low = start
        var high = start
        
        var nonrepeating: Set<Character> = []
        
        // `self.endIndex` does NOT contain character
        while let newHigh = self.index(high, offsetBy: 1, limitedBy: self.endIndex) {
            let char = self[high]
            
            if nonrepeating.contains(char) {
                nonrepeating.removeAll()
                low = high
            }
            
            nonrepeating.insert(char)
            
            if self.distance(from: start, to: end) < self.distance(from: low, to: high) {
                start = low
                end = high
            }
            
            high = newHigh // Assign the high after comparison
        }
        
        return String(self[start...end])
    }
}
