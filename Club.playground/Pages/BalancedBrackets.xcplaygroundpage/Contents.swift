//: [Previous](@previous)

import XCTest

final class BalancedBracketsTests: XCTestCase {
    func testHasBalancedBrackets() {
        XCTAssertTrue("".hasBalancedBrackets())
        XCTAssertTrue("{{{{{[[()()]]}}}}}[]{}".hasBalancedBrackets())
        XCTAssertTrue("{{{{{[[()()]()]}()}}}}{}[]{}".hasBalancedBrackets())
        XCTAssertFalse("{{]](())".hasBalancedBrackets())
        XCTAssertFalse("{{]](()){{}}}{{()".hasBalancedBrackets())
    }
}

BalancedBracketsTests.defaultTestSuite.run()

//: [Next](@next)
