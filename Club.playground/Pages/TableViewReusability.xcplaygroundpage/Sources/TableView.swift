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
