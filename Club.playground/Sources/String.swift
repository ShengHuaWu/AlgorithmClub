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
    
    public func isAnagram(with word: String) -> Bool {
        guard characters.count == word.characters.count else { return false }
        
        let sortedSelf = String(lowercased().characters.sorted())
        let sortedWord = String(word.lowercased().characters.sorted())
        
        return sortedSelf == sortedWord
    }
}

// Count the occurrence of a string in a source string.
// 1. Loop the index of the source string.
// 2. In each loop, compare the substring and the string we want by the index.
extension String {
    public func occurrence(of word: String) -> Int {
        var result = 0
        
        for index in characters.indices {
            if isSubstringEqual(to: word, from: index) {
                result += 1
            }
        }
        
        return result
    }
    
    private func isSubstringEqual(to word: String, from start: Index) -> Bool {
        var selfIndex = start
        for wordIndex in word.characters.indices {
            if self[selfIndex] != word[wordIndex] { return false }
            
            guard let nextIndex = index(selfIndex, offsetBy: 1, limitedBy: endIndex) else { return false }
            
            selfIndex = nextIndex
        }
        
        return true
    }
}

// Truncate String Without Fragment
extension String {
    public func truncate(with length: Int) -> String {
        guard !isEmpty, length > 0 else { return "" }
        
        var end = index(startIndex, offsetBy: length + 1, limitedBy: endIndex) ?? endIndex
        while !needsTruncating(at: end) {
            end = index(before: end)
        }
        
        return substring(to: end)
    }
    
    private func needsTruncating(at index: Index) -> Bool {
        guard index < endIndex else { return false }
        
        switch self[index] {
        case " ", ".", ",", ";", "?", "!": return true
        default: return false
        }
    }
}
