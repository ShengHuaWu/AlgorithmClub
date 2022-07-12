import Foundation

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

// MARK: - Tests

import XCTest

public final class ReverseWordTests: XCTestCase {
    func testReversedWords() {
        let text = """
        Playing a text adventure game about the zombie apocalypse, with text on the screen so you can read with me while you listen. Video version available. Play the game with me – follow the links below. AUDIO VERSION [DOWNLOAD AUDIO] VIDEO VERSION Links Play “Zombolocaust” by Peter Carlson
        """
        
        let expect = """
        Carlson Peter by “Zombolocaust” Play Links VERSION VIDEO AUDIO] [DOWNLOAD VERSION AUDIO below. links the follow – me with game the Play available. version Video listen. you while me with read can you so screen the on text with apocalypse, zombie the about game adventure text a Playing
        """
        XCTAssertEqual(text.reversedWords(), expect)
    }
}
