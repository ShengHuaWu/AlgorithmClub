import Foundation

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

// MARK: - Tests

import XCTest

public final class ParserTests: XCTestCase {
    func testHardDriveStatistics() {
        let report = """
        my.song.mp3 11b
        greatSong.flac 1000b
        not3.txt 5b
        video.mp4 200b
        game.exe 100b
        mov!e.mkv 10000b
        """
        
        let expect = """
        music 1011b
        images 0b
        movies 10200b
        others 105b
        """
        
        XCTAssertEqual(report.hardDriveStatistics(),  expect)
        XCTAssertEqual(report.hardDriveStatisticsWithParser(), expect)
    }
}
