import Foundation

// Find All Palindrome Substrings
//
// Given a string find all non-single letter substrings that are palindromes.
// For example, if input string is `aabbbaa`, then the palindromes are
// `aa`, `bb`, `bbb`, `abbba`, `aabbbaa`

extension String {
    // The idea in the centralization approach is to consider each character
    // as the pivot and expand in both directions to find palindromes.
    // We'll only expand if the characters on the left and right side match,
    // qualifying the string to be a palindrome. Otherwise, we continue to the next character.
    // The time complexity of this approach is O(n^2)
    public func findPalindromes() -> Set<String> {
        var result = Set<String>()
        
        for index in self.indices {
            guard let upperBound = self.index(index, offsetBy: 1, limitedBy: self.index(before: self.endIndex)) else {
                continue
            }
            
            result.formUnion(findPalindromes(in: index ... upperBound, result: []))
            
            // The problem requires non-single letter substrings
            // If it also wants single letter substrings,
            // just use `findAllPalindromes(in: index ... index, result: [])`
            guard let lowerBound = self.index(index, offsetBy: -1, limitedBy: self.startIndex) else {
                continue
            }
            
            result.formUnion(findPalindromes(in: lowerBound ... upperBound, result: []))
        }
        
        return result
    }
}

extension String {
    // The `startWindow` will become bigger and bigger in each iteration,
    // but the iteration will stop once the lower bound is before the start index
    // or the upper bound is after the end index (but remember the end index is NOT counted as the last character of a string)
    private func findPalindromes(in startWindow: ClosedRange<Index>, result: Set<String>) -> Set<String> {
        guard self[startWindow.lowerBound] == self[startWindow.upperBound] else {
            return result
        }
        
        let palindrome = String(self[startWindow.lowerBound ... startWindow.upperBound])
        let newResult = result.union([palindrome])
        
        if let newLowerBound = self.index(startWindow.lowerBound, offsetBy: -1, limitedBy: self.startIndex),
           let newUpperBound = self.index(startWindow.upperBound, offsetBy: 1, limitedBy: self.index(before: self.endIndex)) {
            return findPalindromes(in: newLowerBound ... newUpperBound, result: newResult)
        } else {
            return newResult
        }
    }
}
