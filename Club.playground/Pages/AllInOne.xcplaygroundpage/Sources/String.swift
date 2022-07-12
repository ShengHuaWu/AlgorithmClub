import Foundation

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
}

// Reorganize String
//
// Given a string, find if its letters can be rearranged
// in such a way that no two same characters come next to each other.
extension String {
    public func reorganize() -> String? {
        guard !isEmpty else {
            return ""
        }
        
        var chars: Set<Character> = []
        var charCounts: [Character: Int] = [:]
        for char in self {
            chars.insert(char)
            
            let count = charCounts[char, default: 0]
            charCounts[char] = count + 1
        }
        
        var result = ""
        while !chars.isEmpty {
            // Find the char with largest count
            var charWithMaxCount: Character = first!
            var maxCount = charCounts[charWithMaxCount] ?? 0
            for (char, count) in charCounts {
                if count > maxCount {
                    charWithMaxCount = char
                    maxCount = count
                }
            }
            
            chars.remove(charWithMaxCount)
            
            while maxCount > 0 {
                result.append(charWithMaxCount)
                maxCount -= 1
                
                if chars.isEmpty {
                    // Not enough character
                    if maxCount > 0 {
                        return nil
                    }
                    
                    break // This means the char is the last one
                }
                
                // Find another char to fill in between
                let anotherChar = chars.removeFirst()
                let anotherCount = charCounts[anotherChar] ?? 0
                if anotherCount > 0 {
                    result.append(anotherChar)
                    let newCount = anotherCount - 1
                    charCounts[anotherChar] = newCount
                    
                    // Insert the another char back for next iteration
                    if newCount > 0 {
                        chars.insert(anotherChar)
                    }
                } else {
                    // This should not happen becasue the char has been removed already
                    return nil
                }
            }
        }
        
        return result
    }
}

// Find Most Often Character
//
// Given a string, find the character that appears the most often in the string.
extension String {
    public func findMostOftenCharacter() -> Character? {
        guard let first = first else {
            return nil
        }
        
        var charCounts: [Character: Int] = [:]
        for character in self {
            let count = charCounts[character, default: 0]
            charCounts[character] = count + 1
        }
        
        // If the count of two different character are the same, choose the first one
        return charCounts.reduce(first) { result, pair in
            charCounts[result, default: 0] < pair.value ? pair.key : result
        }
    }
    
    public func findMostOftenCharacterAnotherWay() -> Character? {
        guard !isEmpty else {
            return nil
        }
        
        let sortedString = sorted()
        var start = sortedString.startIndex
        var count = 0
        var result = sortedString.first
        for index in sortedString.indices {
            guard sortedString[start] != sortedString[index] else {
                continue
            }
            
            let newCount = index - start
            count = count == 0 ? newCount : count // Make sure the consider the count of the first chararcter after sorting
            result = newCount > count ? sortedString[start] : result
            start = index
        }
        
        return result
    }
    
    // What if the string file is too huge to load into the memory?
    //
    // 1. Divide the file into small pieces which can be loaded into the memory.
    // 2. Sort each small piece one by one to reduce memory consumption.
    // 3. Merge all the piece into one sorted file.
    // 4. Use `findMostOftenCharacterAnotherWay` but load one character at a time.
}
