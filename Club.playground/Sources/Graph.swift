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
        lhs.value == rhs.value && lhs.neighbors == rhs.neighbors
    }
}

extension GraphNode: Hashable where T: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

// Clone a Directed Graph
//
// Given the root node of a directed graph, clone this graph by creating its deep copy so that the cloned graph has the same vertices and edges as the original graph.
// We are assuming that all vertices are reachable from the root vertex. i.e. we have a connected graph.
extension GraphNode where T == String {
    public func cloned() -> GraphNode {
        var nodes = [self]
        var visited = [GraphNode: GraphNode]()
        while let first = nodes.first {
            let newNode = GraphNode(first.value + "-cloned")
            visited[first] = newNode
            
            // Add nodes that we haven't visited before only
            for neighbor in first.neighbors {
                if !visited.keys.contains(neighbor) {
                    nodes.append(neighbor)
                }
            }
            
            nodes.removeFirst()
        }
        
        // Re-assign neigbors
        for (original, new) in visited {
            for neighbor in original.neighbors {
                if let newNeighbor = visited[neighbor] {
                    new.neighbors.append(newNeighbor)
                }
            }
        }
        
        return visited[self]!
    }
}
