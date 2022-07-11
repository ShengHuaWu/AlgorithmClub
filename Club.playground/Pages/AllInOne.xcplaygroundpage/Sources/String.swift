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

// Reverse Words in a Sentence
//
// Reverse the order of words in a given sentence (an array of characters).
// If the input is "Hello World", then outuput should be "World Hello"
extension String {
    public func reversedWords() -> String {
        split(separator: " ").map(String.init).reversed().joined(separator: " ")
    }
    
    // What if the string file is too huge to load into the memory?
    //
    // 1. Divide the huge string file into small piece which can be load into the memory, but the files should be divided by words.
    // 2. Reverse each small piece one by one to reduce memory consumption.
    // 3. Append the first reversed piece into the second, and the second into the third, and so on.
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

// Determine If Number Is Valid
//
// Given an input string, determine if it makes a valid number or not.
// For simplicity, assume that white spaces are not present in the input.
extension String {
    // Assume that we don't have `Int.init`
    public func toInt() -> Int? {
        guard !isEmpty else {
            return nil
        }
        
        var copy = self
        
        return Parser.number.run(&copy)
    }
}

extension Parser where Result == Int {
    static let int: Parser = .init { string in
        guard !string.isEmpty else {
            return nil
        }
        
        let numbers: [Character: Int] = [
            "0": 0,
            "1": 1,
            "2": 2,
            "3": 3,
            "4": 4,
            "5": 5,
            "6": 6,
            "7": 7,
            "8": 8,
            "9": 9
        ]
        
        guard let firstDigital = numbers[string[string.startIndex]] else {
            return nil
        }
                
        string.removeFirst()
                
        return firstDigital
    }
    
    static let number: Parser = oneOrMore(.int, separatedBy: literal("")).map { numbers -> [Int] in
        guard numbers.first == 0 else {
            return numbers
        }
        
        return numbers.count == 1 ? [0] : Array(numbers.dropFirst())
    }.map { numbers -> Int in
        var power = 0
        let sum = numbers.reversed().reduce(0) { result, number in
            let powerOf10 = Int(pow(10.0, Double(power)))
            power += 1
            
            return result + number * powerOf10
        }
        
        return sum
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
