import Foundation

extension String {
    // Dynamic programming
    //
    // Usually the size of `words` array is much smaller than the length of `self`
    // Time complexity: O(N * M) where N is the length of `self` and M is the size of `words`
    // Space complexity: O(N)
    public func workBreak(in words: [String]) -> Bool {
        guard !self.isEmpty else {
            return false
        }
        
        var temp = Array<Bool>(repeating: false, count: self.count + 1)
        temp[0] = true // Initial value
        
        for stringIndex in self.indices {
            let index = self.distance(from: self.startIndex, to: stringIndex)
            
            // Take the advantage of cache to continue early
            // because we already calculate the result
            // It works since we set the initial value of `temp[0]` to `true`
            guard temp[index] else {
                continue
            }
            
            for word in words {
                let length = word.count
                let newIndex = index + length
                
                guard newIndex < temp.count else {
                    continue
                }
                
                // Take the advantage of cache to avoid duplicated calculations
                if temp[newIndex] {
                    continue
                }
                
                if let end = self.index(stringIndex, offsetBy: length, limitedBy: self.endIndex),
                   self[stringIndex ..< end] == word {
                    temp[newIndex] = true
                }
            }
        }
        
        return temp[self.count]
    }
}
