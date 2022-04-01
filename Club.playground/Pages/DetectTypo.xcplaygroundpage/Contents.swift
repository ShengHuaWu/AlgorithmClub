//: [Previous](@previous)

import XCTest

final class DetectTypoTests: XCTestCase {
    func testDetectOneCharDiff() {
        var input = "domain"
        XCTAssertEqual(input.detectOneCharDiff(), .success(input))
        
        input = "donain"
        XCTAssertEqual(input.detectOneCharDiff(), .failure(.oneCharDiff))
        
        input = "damain"
        XCTAssertEqual(input.detectOneCharDiff(), .failure(.oneCharDiff))
        
        input = "damein"
        XCTAssertEqual(input.detectOneCharDiff(), .failure(.moreCharsDiff))
        
        input = "danein"
        XCTAssertEqual(input.detectOneCharDiff(), .failure(.moreCharsDiff))
        
        input = "aaa"
        XCTAssertEqual(input.detectOneCharDiff(), .failure(.lengthMismatch))
    }
    
    func testDetectOneCharDiffAtKeyboard() {
        var input = "domain"
        XCTAssertEqual(input.detectOneCharDiffAtKeyboard(), .success(input))
        
        input = "donain"
        XCTAssertEqual(input.detectOneCharDiffAtKeyboard(), .failure(.oneCharDiff))
        
        input = "domqim"
        XCTAssertEqual(input.detectOneCharDiffAtKeyboard(), .failure(.moreCharsDiff))
        
        input = "damain"
        XCTAssertEqual(input.detectOneCharDiffAtKeyboard(), .failure(.notEqual))
        
        input = "damein"
        XCTAssertEqual(input.detectOneCharDiffAtKeyboard(), .failure(.notEqual))
        
        input = "danein"
        XCTAssertEqual(input.detectOneCharDiffAtKeyboard(), .failure(.notEqual))
        
        input = "aaa"
        XCTAssertEqual(input.detectOneCharDiffAtKeyboard(), .failure(.lengthMismatch))
    }
    
    func testDetectOneMoreOrLessChar() {
        var input = "domain"
        XCTAssertEqual(input.detectOneMoreOrLessChar(), .success(input))
        
        input = "donain"
        XCTAssertEqual(input.detectOneMoreOrLessChar(), .failure(.notEqual))
        
        input = "dmain"
        XCTAssertEqual(input.detectOneMoreOrLessChar(), .failure(.oneLessChar))
        
        input = "dopmain"
        XCTAssertEqual(input.detectOneMoreOrLessChar(), .failure(.oneMoreChar))
        
        input = "aaa"
        XCTAssertEqual(input.detectOneMoreOrLessChar(), .failure(.notEqual))
    }
}

DetectTypoTests.defaultTestSuite.run()

//: [Next](@next)
