//: [Previous](@previous)

import Foundation
import XCTest

final class MyCell: TDD_TableViewCell {}

final class TDD_TableViewTests: XCTestCase {
    func testDequeueCellWithoutRegistration() {
        let tableView = TDD_TableView()
        
        XCTAssertThrowsError(try tableView.dequeue(with: "whatever"))
    }
    
    func testDequeueCellForFirstTime() throws {
        let tableView = TDD_TableView()
        let reuseId = "whatever"
        
        tableView.register(MyCell.self, with: reuseId)
        
        XCTAssertNoThrow(try tableView.dequeue(with: reuseId))
    }
    
    // TODO: Write tests for actually re-using
}

//TDD_TableViewTests.defaultTestSuite.run()

//: [Next](@next)
