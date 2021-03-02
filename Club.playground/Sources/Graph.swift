import Foundation

public class GraphNode {
    let title: String
    public var neighbors: [GraphNode]
    
    public init(title: String) {
        self.title = title
        self.neighbors = []
    }
}

extension GraphNode: CustomStringConvertible {
    public var description: String {
        var temp = ""
        for node in neighbors {
            temp += node.title + " "
        }
        return "Node: \(title) with Neigbors: \(temp)"
    }
}

extension GraphNode: Hashable {
    public static func == (lhs: GraphNode, rhs: GraphNode) -> Bool {
        lhs.title == rhs.title && lhs.neighbors == rhs.neighbors
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

// Clone a Directed Graph
//
// Given the root node of a directed graph, clone this graph by creating its deep copy so that the cloned graph has the same vertices and edges as the original graph.
// We are assuming that all vertices are reachable from the root vertex. i.e. we have a connected graph.
extension GraphNode {
    public func cloned() -> GraphNode {
        var nodes = [self]
        var temp = [GraphNode: GraphNode]()
        while let first = nodes.first {
            let newNode = GraphNode(title: first.title + "-cloned")
            temp[first] = newNode
            
            // Add nodes that we haven't visited before only
            for neighbor in first.neighbors {
                if !temp.keys.contains(neighbor) {
                    nodes.append(neighbor)
                }
            }
            
            nodes.removeFirst()
        }
        
        // Re-assign neigbors
        for (original, new) in temp {
            for neighbor in original.neighbors {
                if let newNeighbor = temp[neighbor] {
                    new.neighbors.append(newNeighbor)
                }
            }
        }
        
        return temp[self]!
    }
}
