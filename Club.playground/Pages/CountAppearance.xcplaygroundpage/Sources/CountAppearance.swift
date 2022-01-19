import Foundation

extension String {
    public func countAppearance(of word: String) -> Int {
        guard self.count >= word.count, self.contains(word) else {
            return 0
        }
        
        var result = 0
        let offset = word.count
        for index in self.indices {
            guard let endIndex = self.index(index, offsetBy: offset, limitedBy: self.endIndex) else {
                break
            }
            
            if self[index ..< endIndex] == word {
                result += 1
            }
        }
        
        return result
    }
    
    public func countAppearanceAnotherApproach(_ word: String) -> Int {
        return countAppearanceAnotherApproach(word, start: self.startIndex, result: 0)
    }
    
    private func countAppearanceAnotherApproach(_ word: String, start: Index, result: Int) -> Int {
        let offset = word.count
        guard let end = self.index(start, offsetBy: offset, limitedBy: self.endIndex) else {
            return result
        }
        
        let next = self.index(after: start)
        if self[start ..< end] == word {
            return countAppearanceAnotherApproach(word, start: next, result: result + 1)
        } else {
            return countAppearanceAnotherApproach(word, start: next, result: result)
        }
    }
}
