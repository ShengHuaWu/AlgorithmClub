import Foundation

extension Array where Element == Int {
    public func getSortedSquares() -> Self {
        guard !self.isEmpty else {
            return self
        }
                
        var start = self.startIndex
        var end = self.endIndex - 1 // `endIndex` is NOT included
        var result = [Int]()
        
        while start < end {
            let startSquare = self[start] * self[start]
            let endSquare = self[end] * self[end]
            
            if startSquare > endSquare {
                result = [startSquare] + result
                start += 1
            } else if startSquare < endSquare {
                result = [endSquare] + result
                end -= 1
            } else {
                result = [startSquare, endSquare] + result
                start += 1
                end -= 1
            }
        }
        
        // Insert the last at the beginning
        let startSquare = self[start] * self[start]
        result = [startSquare] + result
        
        return result
    }
}
