import Foundation

extension String {
    public func isAnagram(with word: String) -> Bool {
        guard count == word.count else { return false }
        
        let sortedSelf = String(lowercased().sorted())
        let sortedWord = String(word.lowercased().sorted())
        
        return sortedSelf == sortedWord
    }
}

// Count the occurrence of a string in a source string.
// 1. Loop the index of the source string.
// 2. In each loop, compare the substring and the string we want by the index.
extension String {
    public func occurrence(of word: String) -> Int {
        var result = 0
        
        for index in indices {
            if isSubstringEqual(to: word, from: index) {
                result += 1
            }
        }
        
        return result
    }
    
    private func isSubstringEqual(to word: String, from start: Index) -> Bool {
        var selfIndex = start
        for wordIndex in word.indices {
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
        
        for (index, character) in zip(Array(0 ... count), self) {
            skipTable[character] = count - 1 - index
        }
        
        return skipTable
    }
    
    // Backwards match 2 strings character by character.
    private func match(from currentIndex: Index, with pattern: String) -> Index? {
        if currentIndex < startIndex { return nil }
        if currentIndex >= endIndex { return nil }
        
        if self[currentIndex] != pattern.last { return nil }
        
        if pattern.count == 1 && self[currentIndex] == pattern.last {
            return currentIndex
        }
        
        return match(from: index(before: currentIndex), with:String(pattern.dropLast()))
    }
    
    public func index(of pattern: String) -> Index? {
        let patternLength = pattern.count
        guard patternLength > 0, patternLength <= count else { return nil }
        
        let skipTable = pattern.skipTable
        let lastChar = pattern.last!
        
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
    
    private func isPrettyString(in range: ClosedRange<Index>) -> Bool {
        var index = self.index(after: range.lowerBound)
        while index < range.upperBound {
            if self[index] != self[self.index(before: index)] {
                return false
            }

            index = self.index(after: index)
        }

        return true
    }
    
    private func recursiveIsPrettyString(in range: ClosedRange<Index>) -> Bool {
        let end = index(after: range.lowerBound)
        if end == range.upperBound {
            return true
        }
        
        if self[range.lowerBound] != self[end] {
            return false
        } else {
            return recursiveIsPrettyString(in: end ... range.upperBound)
        }
    }
    
    public func recursiveCountNumberOfPrettyStrings(with repeating: Int) -> Int {
        guard !isEmpty, repeating > 0 else { return 0 }
        
        return recursiveCountNumberOfPrettyStrings(with: repeating, start: startIndex, result: 0)
    }
    
    private func recursiveCountNumberOfPrettyStrings(with repeating: Int, start: Index, result: Int) -> Int {
        guard let end = index(start, offsetBy: repeating, limitedBy: endIndex) else {
            return result
        }
        
        if recursiveIsPrettyString(in: start ... end) {
            return recursiveCountNumberOfPrettyStrings(with: repeating, start: end, result: result + 1)
        } else {
            return recursiveCountNumberOfPrettyStrings(with: repeating, start: index(after: start), result: result)
        }
    }
    
    public func recursiveFindOccurence(of key: String) -> Int {
        guard !isEmpty, !key.isEmpty else { return 0 }
        
        return recursiveFindOccurence(of: key, start: startIndex, result: 0)
    }
    
    private func recursiveFindOccurence(of key: String, start: Index, result: Int) -> Int {
        guard let end = index(start, offsetBy: key.count, limitedBy: endIndex) else {
            return result
        }
        
        let temp = String(self[start ..< end])
        if temp == key {
            return recursiveFindOccurence(of: key, start: end, result: result + 1)
        } else {
            return recursiveFindOccurence(of: key, start: index(after: start), result: result)
        }
    }
    
    public func recursiveTruncate(with length: Int) -> String {
        guard !isEmpty, length > 0, count > length else { return self }
        
        return recursiveTruncate(with: length, end: index(startIndex, offsetBy: length))
    }
    
    private func recursiveTruncate(with length: Int, end: Index) -> String {
        guard end > startIndex else { return "" }
        
        switch self[end] {
        case ".", ",", ":", ";", "?", "!", " ":
            return String(self[startIndex ... end])
        default:
            return recursiveTruncate(with: length, end: index(before: end))
        }
    }
    
    static public func recursiveFizzBuss(in turns: Int) -> String {
        guard turns > 0 else { return "" }
        
        return recursiveFizzBuzz(in: turns, result: "")
    }
    
    private static func recursiveFizzBuzz(in turns: Int, result: String) -> String {
        guard turns > 0 else { return result }
        
        if turns % 3 == 0, turns % 5 == 0 {
            return recursiveFizzBuzz(in: turns - 1, result: "Fizz Buzz " + result)
        } else if turns % 3 == 0 {
            return recursiveFizzBuzz(in: turns - 1, result: "Fizz " + result)
        } else if turns % 5 == 0 {
            return recursiveFizzBuzz(in: turns - 1, result: "Buzz " + result)
        } else {
            return recursiveFizzBuzz(in: turns - 1, result: "\(turns) " + result)
        }
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
