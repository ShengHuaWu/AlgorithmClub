import Foundation

// Table View Cell Reusability
//
// Implement an approach to reuse table view cell as UIKit does

class TableViewCell {
    let reuseIdentifier: String
    
    init(reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
    }
}

// Invocation order:
// register > dequeue > didEndDisplay
final class TableView {
    func register<T: TableViewCell>(_ type: T.Type, with reuseIdentifier: String) {}
    
    func dequeue(with reuseIdentifier: String) -> TableViewCell {
        fatalError()
    }
    
    func didEndDisplay(tableViewCell: TableViewCell) {}
}
