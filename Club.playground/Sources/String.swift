import Foundation

extension String {
    public func countOfPrettyString(with length: Int) -> Int {
        guard length > 0 else { return 0 }
        
        if length == 1 { return characters.count }
        
        var result = 0
        for index in characters.indices {
            guard let end = self.index(index, offsetBy: length, limitedBy: endIndex) else { break }
            
            let bounds = (index, end)
            let range = Range(uncheckedBounds: bounds)
            if isPrettyString(in: range) {
                result += 1
            }
        }
        
        return result
    }
    
    private func isPrettyString(in range: Range<Index>) -> Bool {
        var index = self.index(after: range.lowerBound)
        while index < range.upperBound {
            if self[index] != self[self.index(before: index)] {
                return false
            }
            
            index = self.index(after: index)
        }
        
        return true
    }
}
