import Foundation

public struct Tree<T> {
    public let value: T
    public var subtrees: [Tree<T>]
    
    public init(_ value: T) {
        self.value = value
        self.subtrees = []
    }
}

extension Tree where T: Equatable {
    // DFS approach (recursive)
    public func dfsFindFirst(_ value: T) -> Self? {
        return dfsFindFirst(node: self, value: value)
    }
    
    private func dfsFindFirst(node: Self, value: T) -> Self? {
        if node.value == value {
            return node
        }
        
        for descendant in node.subtrees {
            if let result = dfsFindFirst(node: descendant, value: value) {
                return result
            }
        }
        
        return nil
    }
}

extension Tree: CustomStringConvertible where T: CustomStringConvertible {
    // Use this type to determine whether to add a new line or not
    private enum Description {
        case node(Tree<T>)
        case newLine
    }
    
    // BFS approach
    public var description: String {
        var descriptions = [Description.node(self), .newLine] // The next of the root should be new line
        var result = ""
        
        while !descriptions.isEmpty {
            let first = descriptions.removeFirst()
            
            switch first {
            case let .node(tree):
                result += tree.value.description
                
                guard !tree.subtrees.isEmpty else {
                    continue
                }
                
                // Add the descendants to the next round (BFS)
                let descendants = tree.subtrees.map(Description.node)
                descriptions.append(contentsOf: descendants)
                
                // If the next one is new line,
                // then add a new line to the next round
                // This check will avoid adding redundant new lines
                guard case .newLine = descriptions.first else {
                    continue
                }
                
                descriptions.append(.newLine)
                
            case .newLine:
                result += "\n"
            }
        }
        
        return result
    }
}
