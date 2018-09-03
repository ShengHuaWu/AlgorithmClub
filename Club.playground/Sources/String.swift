import Foundation

extension String {
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

// Boyer-Moore Algorithm
extension String {
    // The closer a character is to the end of the pattern, the smaller the skip amount.
    // If a character appears more than once in the pattern, 
    // the one nearest to the end of the pattern determines the skip value for that character.
    private var skipTable: [Character : Int] {
        var skipTable = [Character : Int]()
        
        for (index, character) in zip(Array(0 ... characters.count), characters) {
            skipTable[character] = characters.count - 1 - index
        }
        
        return skipTable
    }
    
    // Backwards match 2 strings character by character.
    private func match(from currentIndex: Index, with pattern: String) -> Index? {
        if currentIndex < startIndex { return nil }
        if currentIndex >= endIndex { return nil }
        
        if self[currentIndex] != pattern.characters.last { return nil }
        
        if pattern.characters.count == 1 && self[currentIndex] == pattern.characters.last {
            return currentIndex
        }
        
        return match(from: index(before: currentIndex), with:String(pattern.characters.dropLast()))
    }
    
    public func index(of pattern: String) -> Index? {
        let patternLength = pattern.characters.count
        guard patternLength > 0, patternLength <= characters.count else { return nil }
        
        let skipTable = pattern.skipTable
        let lastChar = pattern.characters.last!
        
        var i = index(startIndex, offsetBy: patternLength - 1)
        while i < endIndex {
            let char = self[i]
            
            if char == lastChar {
                // If the current character of the source string matches the last character of the pattern string, you'll attempt to run the match function.
                // If this returns a non nil value, it means you've found a match, so you'll return the index that matches the pattern. 
                // Otherwise, you'll move to the next index.
                if let found = match(from: i, with: pattern) { return found }
                
                i = index(after: i)
            } else {
                // If you can't make a match, you'll consult the skip table to see how many indexes you can skip.
                // If this skip goes beyond the length of the source string, you'll just head straight to the end.
                i = index(i, offsetBy: skipTable[char] ?? patternLength, limitedBy: endIndex) ?? endIndex
            }
        }
        
        return nil
    }
}

public func fizzBuzz(numberOfTurns: Int) {
    for i in 1 ... numberOfTurns {
        var result = ""

        if i % 3 == 0 {
            result += "Fizz"
        }
        
        if i % 5 == 0 {
            if result.isEmpty {
                result += "Buzz"
            } else {
                result += " Buzz"
            }
        }
        
        if result.isEmpty {
            result += "\(i)"
        }
        
        print(result)
    }
}
