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
    public func findAllPalindromeSubstrings() -> Set<String> {
        var results = Set<String>()
        
        indices.forEach { index in
            if let end = self.index(index, offsetBy: 1, limitedBy: self.index(before: endIndex)) {
                results.formUnion(findAllPalindromes(from: self, start: index, end: end))
                
                // The problem requires non-single letter substrings
                // If it also wants single letter substrings,
                // just use `findAllPalindromes(from: self, start: index, end: index)`
                if let start = self.index(index, offsetBy: -1, limitedBy: startIndex) {
                    results.formUnion(findAllPalindromes(from: self, start: start, end: end))
                }
            }
        }
        
        return results
    }
    
    private func findAllPalindromes(from input: String, start: String.Index, end: String.Index) -> Set<String> {
        guard input[start] == input[end] else {
            return []
        }
        
        var results: Set<String> = [String(input[start...end])]
        var copyStart = start
        var copyEnd = end
        while let newStart = input.index(copyStart, offsetBy: -1, limitedBy: input.startIndex),
              let newEnd = input.index(copyEnd, offsetBy: 1, limitedBy: input.index(before: input.endIndex)),
              input[newStart] == input[newEnd] {
            results.insert(String(input[newStart...newEnd]))
            copyStart = newStart
            copyEnd = newEnd
        }
        
        return results
    }
}

// Reverse Words in a Sentence
//
// Reverse the order of words in a given sentence (an array of characters).
// If the input is "Hello World", then outuput should be "World Hello"
extension String {
    public func reversedWords() -> String {
        split(separator: " ").map(String.init).reversed().joined(separator: " ")
    }
}

// Hard drive statistics
//
// Your computer's hard driver is almost full.
// In order to make some space, you need to compile some file statistics.
// You want to know how many bytes of memory each file type is consuming.
// Each file has a name, and the part of the name after the last dot is called the file extension, which identifies what type of file it is.
// * music (only extensions: mp3, aac, flac)
// * image (only extensions: jpg, bmp, gif)
// * movie (only extensions: mp4, avi, mkv)
// * other (all other extensions; for example: 7z, txt, zip)
// You receive string `S`, containing a list of all the files in your computer (each file appears on a separate line).
// Each line contains a file name and the file's size in bytes, separated by a space. For example,
// ```
// "my.song.mp3 11b
// greatSong.flac 1000b
// not3.txt 5b
// video.mp4 200b
// game.exe 100b
// mov!e.mkv 10000b"
// ```
// In total there are 1011 bytes of music, 0 byte of images, 10200 bytes of movies, and 105 bytes of other files.
// Write a function that, given string `S` describing the files on disk,
// returns a string containing four rows, describing music, images, movies, and other file types respectively.
// Each row should consist of a file type and the number of files consumed by files of that type on disk.
// For instance, given string `S` as shown above, your function should return:
// ```
// "music 1011b
// images 0b
// movies 10200b
// other 105b"
// ```
fileprivate struct File {
    enum ExtType {
        case music
        case image
        case movie
        case other
        
        init(_ ext: Substring) {
            switch ext {
            case "mp3", "aac", "flac":
                self = .music
            case "jpg", "bmp", "gif":
                self = .image
            case "mp4", "avi", "mkv":
                self = .movie
            default:
                self = .other
            }
        }
    }
    
    let extType: ExtType
    let size: Int
}

fileprivate struct Statistic {
    var sizeOfMusic: Int = 0
    var sizeOfImages: Int = 0
    var sizeOfMovies: Int = 0
    var sizeOfOthers: Int = 0
    
    var description: String {
        """
        music \(sizeOfMusic)b
        images \(sizeOfImages)b
        movies \(sizeOfMovies)b
        others \(sizeOfOthers)b
        """
    }
    
    mutating func include(_ file: File) {
        switch file.extType {
        case .music:
            sizeOfMusic += file.size
        case .image:
            sizeOfImages += file.size
        case .movie:
            sizeOfMovies += file.size
        case .other:
            sizeOfOthers += file.size
        }
    }
}

extension String {
    public func hardDriveStatistics() -> String {
        split(separator: "\n")
            .compactMap { $0.parseToFile() }
            .reduce(into: Statistic()) { $0.include($1) }
            .description
    }
}

extension Substring {
    fileprivate func parseToFile() -> File? {
        guard let indexBeforeExt = lastIndex(of: "."),
              let startIndexOfExt = index(indexBeforeExt, offsetBy: 1, limitedBy: endIndex),
              let indexOfSpace = lastIndex(of: " "),
              let startIndexOfSize = index(indexOfSpace, offsetBy: 1, limitedBy: endIndex),
              let startIndexOfByte = lastIndex(of: "b"),
              let size = Int(String(self[startIndexOfSize ..< startIndexOfByte])) else {
            return nil // Wrong input format
        }
        
        let ext = self[startIndexOfExt ..< indexOfSpace]
        
        return File(extType: .init(ext), size: size)
    }
}

// Parse Accept Language
//
// The accept language headers is comma-separated list and it could contain spaces, for example, `"en-US, fr-CA"`.
// In addition, it could also contain non-region form, such as, `"en, fr-CA"`,
// and there could also be a wildcard tag `"*"` inside the accept language headers.
// The order of the accept language headers matters.
public func parseAcceptLanguage(
    _ acceptLanguageHeaders: String,
    _ supportedLanguages: [String]
) -> [String] {
    acceptLanguageHeaders
        .split(separator: ",")
        .map { tag in tag.replacingOccurrences(of: " ", with: "") }
        .reduce([]) { results, tag in
            let languages = supportedLanguages.filter { language in
                language == tag || language.contains(tag) || tag == "*" // wildcard
            }
            
            return results + languages.filter { language in !results.contains(language) }
        }
}
