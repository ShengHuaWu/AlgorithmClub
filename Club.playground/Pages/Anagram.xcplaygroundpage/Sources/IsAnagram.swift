import Foundation

extension String {
    public func isAnagram(with word: String) -> Bool {
        guard count == word.count else { return false }
        
        let sortedSelf = String(lowercased().sorted())
        let sortedWord = String(word.lowercased().sorted())
        
        return sortedSelf == sortedWord
    }
}
