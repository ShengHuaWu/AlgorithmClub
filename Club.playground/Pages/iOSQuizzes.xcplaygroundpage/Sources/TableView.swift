import Foundation

// Table View Cell Reusability
//
// Implement an approach to reuse table view cells like UIKit does

open class TDD_TableViewCell {
    let reuseIdentifier: String
    
    public required init(reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
    }
}

public class TDD_TableView {
    enum TableViewError: Error {
        case dequeueUnregisteredCellType
        case unableToFindCellOnScreen
    }
    
    typealias ReuseId = String
    
    private var registered: [ReuseId: TDD_TableViewCell.Type] = [:]
    
    // Change both of `offScreen` and `onScreen` to Set<TDD_TableViewCell>
    // to reduce the lookup time, but it requires `Hashable`
    private var offScreen: [TDD_TableViewCell] = []
    private var onScreen: [TDD_TableViewCell] = []
    
    public init() {}
    
    public func register<T: TDD_TableViewCell>(_ type: T.Type, with reuseIdentifier: String) {
        registered[reuseIdentifier] = type
    }
    
    public func dequeue(with reuseIdentifier: String) throws -> TDD_TableViewCell {
        guard let type = registered[reuseIdentifier] else {
            throw TableViewError.dequeueUnregisteredCellType
        }
        
        if let index = offScreen.firstIndex(where: { $0.reuseIdentifier == reuseIdentifier }) {
            let cell = offScreen.remove(at: index)
            onScreen.append(cell)
            
            return cell
        } else {
            let cell = type.init(reuseIdentifier: reuseIdentifier)
            onScreen.append(cell)
            
            return cell
        }
    }
    
    public func didEndDisplay(tableViewCell: TDD_TableViewCell) throws {
        guard let index = onScreen.firstIndex(where: { $0.reuseIdentifier == tableViewCell.reuseIdentifier }) else {
            throw TableViewError.unableToFindCellOnScreen
        }
        
        onScreen.remove(at: index)
        offScreen.append(tableViewCell)
    }
}

// MARK: - Tests

import XCTest

final class MyCell: TDD_TableViewCell {}

public final class TDD_TableViewTests: XCTestCase {
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
