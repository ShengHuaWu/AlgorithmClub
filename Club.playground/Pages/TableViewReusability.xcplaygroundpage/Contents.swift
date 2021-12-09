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
    
    func testDequeueCellAfterEndDisplay() throws {
        let tableView = TDD_TableView()
        let reuseId = "whatever"
        
        tableView.register(MyCell.self, with: reuseId)
        let cell1 = try tableView.dequeue(with: reuseId)
        
        try tableView.didEndDisplay(tableViewCell: cell1)
        
        let cell2 = try tableView.dequeue(with: reuseId)
        
        let addressOfCell1 = Unmanaged.passUnretained(cell1).toOpaque()
        let addressOfCell2 = Unmanaged.passUnretained(cell2).toOpaque()
        XCTAssertEqual(addressOfCell1, addressOfCell2)
    }
    
    // TODO: Write tests for reusability of multiple reuse identifiers
}

TDD_TableViewTests.defaultTestSuite.run()

//: [Next](@next)
