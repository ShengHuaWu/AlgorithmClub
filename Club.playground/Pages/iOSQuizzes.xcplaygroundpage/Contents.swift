//: [Previous](@previous)

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
        XCTAssertTrue(cell1 === cell2)
    }
    
    func testDequeueCellsWithTwoReuseIdsAfterEndDisplay() throws {
        let tableView = TDD_TableView()
        let reuseId1 = "whatever1"
        let reuseId2 = "whatever2"
        
        tableView.register(MyCell.self, with: reuseId1)
        tableView.register(MyCell.self, with: reuseId2)
        
        let cell1ForReuseId1 = try tableView.dequeue(with: reuseId1)
        let cell1ForReuseId2 = try tableView.dequeue(with: reuseId2)
        
        try tableView.didEndDisplay(tableViewCell: cell1ForReuseId1)
        try tableView.didEndDisplay(tableViewCell: cell1ForReuseId2)
        
        let cell2ForReuseId1 = try tableView.dequeue(with: reuseId1)
        let cell2ForReuseId2 = try tableView.dequeue(with: reuseId2)
        
        XCTAssertTrue(cell1ForReuseId1 === cell2ForReuseId1)
        XCTAssertTrue(cell1ForReuseId2 === cell2ForReuseId2)
    }
    
    func testDequeueCellsWithTheSameReuseIdAfterEndDisplay() throws {
        let tableView = TDD_TableView()
        let reuseId = "whatever"
        
        tableView.register(MyCell.self, with: reuseId)
        
        let cell1 = try tableView.dequeue(with: reuseId)
        let cell2 = try tableView.dequeue(with: reuseId)
        
        try tableView.didEndDisplay(tableViewCell: cell1)
        try tableView.didEndDisplay(tableViewCell: cell2)
        
        let cell3 = try tableView.dequeue(with: reuseId)
        let cell4 = try tableView.dequeue(with: reuseId)
        
        XCTAssertTrue(cell1 === cell3)
        XCTAssertTrue(cell2 === cell4)
    }
}

TDD_TableViewTests.defaultTestSuite.run()

//: [Next](@next)
