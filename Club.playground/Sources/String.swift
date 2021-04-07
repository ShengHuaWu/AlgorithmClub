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
    
    public func hardDriveStatisticsWithParser() -> String {
        var copy = self
        
        return files().run(&copy)?.reduce(into: Statistic()) { $0.include($1) }.description ?? ""
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

struct Parser<Result> {
    let run: (inout String) -> Result?
}

extension Parser {
    static var never: Self {
        Parser { _ in nil }
    }
    
    func map<NewResult>(_ f: @escaping (Result) -> NewResult) -> Parser<NewResult> {
        Parser<NewResult> { string in
            self.run(&string).map(f)
        }
    }
    
    func flatMap<NewResult>(_ f: @escaping (Result) -> Parser<NewResult>) -> Parser<NewResult> {
        Parser<NewResult> { string in
            let original = string
            let result = self.run(&string)
            let newParser = result.map(f)
            
            guard let newResult = newParser?.run(&string) else {
                string = original
                return nil
            }
            
            return newResult
        }
    }
}

func always<Result>(_ result: Result) -> Parser<Result> {
    Parser { _ in result }
}

func zeroOrMore<Result>(_ parser: Parser<Result>, separatedBy separator: Parser<Void>) -> Parser<[Result]> {
    Parser { string in
        var reminder = string
        var matches = [Result]()
        while let match = parser.run(&string) {
            reminder = string
            matches.append(match)
            if separator.run(&string) == nil {
                return matches
            }
        }
        string = reminder // Assign the reminder back to ensure not accidentally removing anything
        return matches
    }
}

func oneOrMore<Result>(_ parser: Parser<Result>, separatedBy separator: Parser<Void>) -> Parser<[Result]> {
    zeroOrMore(parser, separatedBy: separator).flatMap { $0.isEmpty ? .never : always($0) }
}

func literal(_ text: String) -> Parser<Void> {
    Parser { string in
        guard string.hasPrefix(text) else {
            return nil
        }
        
        string.removeFirst(text.count)
        return ()
    }
}

fileprivate func files() -> Parser<[File]> {
    oneOrMore(.file, separatedBy: literal("\n"))
}

func zip<A, B>(_ a: Parser<A>, _ b: Parser<B>) -> Parser<(A, B)> {
  return Parser<(A, B)> { str -> (A, B)? in
    let original = str
    guard let matchA = a.run(&str) else {
        return nil
    }
    
    guard let matchB = b.run(&str) else {
      str = original
      return nil
    }
    
    return (matchA, matchB)
  }
}

func zip<A, B, C>(_ a: Parser<A>, _ b: Parser<B>, _ c: Parser<C>) -> Parser<(A, B, C)> {
  return zip(a, zip(b, c)).map { a, bc in (a, bc.0, bc.1) }
}

fileprivate extension Parser {
    static var file: Parser<File> {
        zip(.ext, literal(" "), .size).map { ext, _, size in
            File(extType: ext, size: size)
        }
    }
    
    static var ext: Parser<File.ExtType> {
        Parser<File.ExtType> { string in
            let line = string.prefix(while: { $0 != "\n" })
            guard let indexOfLastDot = line.lastIndex(of: "."),
                  let startOfExt = line.index(indexOfLastDot, offsetBy: 1, limitedBy: line.endIndex),
                  let indexOfSpace = line.lastIndex(of: " ") else {
                return nil
            }
            
            let ext = File.ExtType(string[startOfExt ..< indexOfSpace])
            string.removeSubrange(string.startIndex ..< indexOfSpace)
            
            return ext
        }
    }
    
    static var size: Parser<Int> {
        Parser<Int> { string in
            let sizeString = string.prefix(while: { $0 != "b" })
            guard let size = Int(String(sizeString)) else {
                return nil
            }
            
            string.removeFirst(sizeString.count + 1) // Remove the `b` symbol as well
            
            return size
        }
    }
}

// Parse Accept Language
//
// The accept language headers is comma-separated list and it could contain spaces, for example, `"en-US, fr-CA"`.
// In addition, it could also contain non-region form, such as, `"en, fr-CA"`,
// and there could also be a wildcard tag `"*"` inside the accept language headers.
// The order of the accept language headers matters.
public func parseAcceptLanguage(_ acceptLanguageHeaders: String, _ supportedLanguages: [String]) -> [String] {
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

// Balanced Brackets
//
// We're provided a string like the following: "{[])}" that is inclusive of the following symbols:
// parentheses `()`, brackets `[]`, and curly braces `{}`.
// Write a function that will check if the symbol pairings in the string follow these below conditions:
// They are correctly ordered, meaning opening braces/symbols should come first.
// They contain the correct pairings, so every opening brace has a closing one.
// They are both of the same kind in a pair, so an opening parenthesis does not close with a closing curly brace.
// For example, `()` is valid. `((` is not. Similarly, `{{[]}}` is valid. `[[}}` is not.
extension String {
    public func validateBalancedBrackets() -> Bool {
        guard !isEmpty else {
            return true
        }
        
        var bracketsWithIndices = [Character: [String.Index]]()
        zip(indices, self).forEach { index, character in
            if let indices = bracketsWithIndices[character] {
                bracketsWithIndices[character] = indices + [index]
            } else {
                bracketsWithIndices[character] = [index]
            }
        }
        
        let openParenthese: Character = "("
        let closeParenthese: Character = ")"
        let openBracket: Character = "["
        let closeBracket: Character = "]"
        let openCurlyBrace: Character = "{"
        let closeCurlyBrace: Character = "}"
        
        // First of all, check the amount of the open and close pairs are the same
        guard bracketsWithIndices[openParenthese]?.count == bracketsWithIndices[closeParenthese]?.count,
              bracketsWithIndices[openBracket]?.count == bracketsWithIndices[closeBracket]?.count,
              bracketsWithIndices[openCurlyBrace]?.count == bracketsWithIndices[closeCurlyBrace]?.count else {
            return false
        }
        
        return checkOpenOccurBeforeClose(open: openParenthese, close: closeParenthese, in: bracketsWithIndices)
            && checkOpenOccurBeforeClose(open: openBracket, close: closeBracket, in: bracketsWithIndices)
            && checkOpenOccurBeforeClose(open: openCurlyBrace, close: closeCurlyBrace, in: bracketsWithIndices)
    }
    
    // The first open one must occur before the first close one,
    // and this rule should apply for all the indices, for instance, `(())` or `()()`
    private func checkOpenOccurBeforeClose(open: Character, close: Character, in dictionary: [Character: [String.Index]]) -> Bool {
        guard let openIndices = dictionary[open],
              let closeIndices = dictionary[close],
              openIndices.count == closeIndices.count else {
            return false
        }
        
        return zip(openIndices, closeIndices).reduce(true) { result, indexPair in
            result && indexPair.0 < indexPair.1
        }
    }
}

// Is A Subsequence
//
// Given two strings, one named `sub` and the other `str`, determine if `sub` is a subsequence of `str`.
extension String {
    public func isSubsequence(of str: String) -> Bool {
        guard !isEmpty, !str.isEmpty else {
            return false
        }
        
        var indexOfPreviousCharInStr = str.startIndex
        // ???: Perhaps we can check the first and last together and exclude them at once
        for char in self {
            if let indexOfCharInStr = str[indexOfPreviousCharInStr...].firstIndex(of: char) {
                indexOfPreviousCharInStr = indexOfCharInStr
            } else {
                return false
            }
        }
        
        return true
    }
}

// Targets and Vicinities
//
// Targets are digits in the guessed number that have the same value of the digit in actual at the same position.
// Here's an example,
// Actual: "34"
// Guess:  "34"
// Then result is "2T0V"
extension String {
    public func getTargetsVicinities(for guess: String) -> String {
        guard count == guess.count else {
            return "0T0V"
        }
        
        let actualIndices = getCharsIndicesDictionary()
        let guessIndices = guess.getCharsIndicesDictionary()
        
        var numberOfTarget = 0
        var numberOfVicinity = 0
        for (char, indices) in guessIndices {
            guard let indicesOfCharInActual = actualIndices[char] else {
                continue
            }
            
            let intersectionCount = indices.intersection(indicesOfCharInActual).count
            numberOfTarget += intersectionCount
            numberOfVicinity += indices.count - intersectionCount
        }
        
        return "\(numberOfTarget)T\(numberOfVicinity)V"
    }
    
    private func getCharsIndicesDictionary() -> [Character: Set<Index>] {
        var dictionary = [Character: Set<Index>]()
        zip(indices, self).forEach { index, char in
            if let indicesOfChar = dictionary[char] {
                dictionary[char] = indicesOfChar.union([index])
            } else {
                dictionary[char] = [index]
            }
        }
        
        return dictionary
    }
}

// Longest Substring With No More Than ‘K’ Distinct Characters
//
// Given a string, find the length of the longest substring in it with no more than K distinct characters.
extension String {
    public func findLongestSubstringWithNoMoreThan(kDistinctCharacters k: Int) -> String {
        var distinctChars: Set<Character> = []
        
        // Store the count of characters present in the distinct characters.
        var charCounts: [Character: Int] = [:]
        
        // Store the longest substring boundaries
        var start = startIndex
        var end = start
        
        // Maintains the sliding window boundaries
        var low = start
        var high = start
        
        while let newHigh = index(high, offsetBy: 1, limitedBy: endIndex) {
            let char = self[high]
            distinctChars.insert(char)
            if let count = charCounts[char] {
                charCounts[char] = count + 1
            } else {
                charCounts[char] = 1
            }
            
            // If the size is more than `k`, remove characters from the left
            while distinctChars.count > k {
                let charToBeRemoved = self[low]
                if let count = charCounts[charToBeRemoved] {
                    let newCount = count - 1
                    charCounts[charToBeRemoved] = newCount
                    
                    // If the leftmost character's count becomes 0 after removing it in the window, remove it from the set as well
                    if newCount == 0 {
                        distinctChars.remove(charToBeRemoved)
                    }
                }
                
                // Reduce window size
                if let newLow = index(low, offsetBy: 1, limitedBy: endIndex) {
                    low = newLow
                }
            }
            
            // Update the maximum window size if necessary
            if distance(from: start, to: end) < distance(from: low, to: high) {
                start = low
                end = high
            }
            
            high = newHigh
        }
        
        return String(self[start ... end])
    }
}
