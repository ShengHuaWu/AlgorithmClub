import Foundation

public class GraphNode<T> {
    let value: T
    public var neighbors: [GraphNode]
    
    public init(_ value: T) {
        self.value = value
        self.neighbors = []
    }
}

extension GraphNode: CustomStringConvertible where T: CustomStringConvertible {
    public var description: String {
        var temp = ""
        for node in neighbors {
            temp += node.value.description + " "
        }
        return "Node: \(value) with Neigbors: \(temp)"
    }
}

extension GraphNode: Equatable where T: Equatable {
    public static func == (lhs: GraphNode, rhs: GraphNode) -> Bool {
        lhs.value == rhs.value// && lhs.neighbors == rhs.neighbors
    }
}

extension GraphNode: Hashable where T: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}
