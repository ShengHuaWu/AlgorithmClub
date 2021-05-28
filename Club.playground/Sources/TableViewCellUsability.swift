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
        Unmanaged.passRetained(lhs).toOpaque() == Unmanaged.passRetained(rhs).toOpaque()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(reuseIdentifier)
        hasher.combine(Unmanaged.passRetained(self).toOpaque())
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
