import Foundation

// Table View Cell Reusability
//
// Implement an approach to reuse table view cells like UIKit does

class TableViewCell: Equatable, Hashable {
    let reuseIdentifier: String
    
    required init(reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
    }
    
    static func == (lhs: TableViewCell, rhs: TableViewCell) -> Bool {
        Unmanaged.passUnretained(lhs).toOpaque() == Unmanaged.passUnretained(rhs).toOpaque()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(reuseIdentifier)
        hasher.combine(Unmanaged.passUnretained(self).toOpaque())
    }
}

final class TableView {
    private var registered: [String: TableViewCell.Type] = [:]
    private var onScreen: [String: Set<TableViewCell>] = [:]
    private var offScreen: [String: Set<TableViewCell>] = [:]
    
    func register<T: TableViewCell>(_ type: T.Type, with reuseIdentifier: String) {
        registered[reuseIdentifier] = type
    }
    
    /*
     If `offScreen` contains a cell with the `reuseIdentifier`, then move it to `onScreen` and return it (reusability).
     Otherwise, create a new instance of the type from the registered, and then move it to `onScreen` and return it (the first time).
     */
    func dequeue(with reuseIdentifier: String) -> TableViewCell {
        let cell: TableViewCell
        if var cellsOffScreen = offScreen[reuseIdentifier], !cellsOffScreen.isEmpty {
            cell = cellsOffScreen.removeFirst()
            offScreen[reuseIdentifier] = cellsOffScreen
        } else if let cellType = registered[reuseIdentifier] {
            cell = cellType.init(reuseIdentifier: reuseIdentifier)
        } else {
            fatalError("Attempt to dequeue unregistered cell type.")
        }
        
        let cellsOnScreen = onScreen[reuseIdentifier, default: []]
        onScreen[reuseIdentifier] = cellsOnScreen.union([cell])
        
        return cell
    }
    
    // Move the cell from `onScreen` to `offScreen`
    func didEndDisplay(tableViewCell: TableViewCell) {
        var cellsOnScreen = onScreen[tableViewCell.reuseIdentifier, default: []]
        cellsOnScreen.remove(tableViewCell)
        onScreen[tableViewCell.reuseIdentifier] = cellsOnScreen
        
        let cellsOffScreen = offScreen[tableViewCell.reuseIdentifier, default: []]
        offScreen[tableViewCell.reuseIdentifier] = cellsOffScreen.union([tableViewCell])
    }
}

// Second Thought

struct ReuseModel {
    let reuseId: String
    let registeredCellType: TableViewCell.Type
    var cellsOnScreen: [TableViewCell] = []
    var cellsOffScreen: [TableViewCell] = []
}

final class ReuseManager {
    private var models: [String: ReuseModel] = [:]
    
    func register<T: TableViewCell>(reuseId: String, type: T.Type) {
        guard let model = models[reuseId] else {
            models[reuseId] = .init(reuseId: reuseId, registeredCellType: type)
            return
        }
        
        if model.registeredCellType.self != type.self {
            fatalError("Attempt to register the same reuse id \(reuseId) for different cell types \(model.registeredCellType.self) and \(type.self)")
        }
    }
    
    func dequeue(with reuseId: String) -> TableViewCell {
        guard var model = models[reuseId] else {
            fatalError("Attempt to dequeue unregistered cell type.")
        }
        
        if let first = model.cellsOffScreen.first {
            model.cellsOffScreen.removeFirst()
            model.cellsOnScreen.append(first)
            models[reuseId] = model
            
            return first
        } else {
            let cell = model.registeredCellType.init(reuseIdentifier: reuseId)
            model.cellsOnScreen.append(cell)
            models[reuseId] = model
            
            return cell
        }
    }
    
    func didEndDisplay(tableViewCell: TableViewCell) {
        guard var model = models[tableViewCell.reuseIdentifier] else {
            fatalError("Attempt to store a unregistered table view cell into reuse cycle.")
        }
        
        guard let index = model.cellsOnScreen.firstIndex(where: { $0 == tableViewCell }) else {
            fatalError("Unable to find the on screen cell.")
        }
        
        let cell = model.cellsOnScreen.remove(at: index)
        model.cellsOffScreen.append(cell)
        models[tableViewCell.reuseIdentifier] = model
    }
}

// TDD

open class TDD_TableViewCell {
    let reuseIdentifier: String
    
    public required init(reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
    }
}

public class TDD_TableView {
    // TODO: Rename this error type
    enum Reason: Error {
        case dequeueUnregisteredCellType
        case unableToFindCellOnScreen
    }
    
    typealias ReuseId = String
    
    private var registered: [ReuseId: TDD_TableViewCell.Type] = [:]
    private var offScreen: [TDD_TableViewCell] = []
    private var onScreen: [TDD_TableViewCell] = []
    
    public init() {}
    
    public func register<T: TDD_TableViewCell>(_ type: T.Type, with reuseIdentifier: String) {
        registered[reuseIdentifier] = type
    }
    
    public func dequeue(with reuseIdentifier: String) throws -> TDD_TableViewCell {
        guard let type = registered[reuseIdentifier] else {
            throw Reason.dequeueUnregisteredCellType
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
            throw Reason.unableToFindCellOnScreen
        }
        
        onScreen.remove(at: index)
        offScreen.append(tableViewCell)
    }
}
