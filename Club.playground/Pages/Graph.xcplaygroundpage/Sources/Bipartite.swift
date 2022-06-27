import Foundation

// Check Graph Is Bipartite
//
// A Bipartite Graph is a graph whose vertices can be divided into two independent sets,
// U and V such that every edge (u, v) either connects a vertex from U to V or a vertex from V to U.
// In other words, for every edge (u, v), either u belongs to U and v to V, or u belongs to V and v to U.
// We can also say that there is no edge that connects vertices of same set.
extension GraphNode where T: Hashable {
    private enum Color {
        case red
        case blue
        
        var toggled: Color {
            switch self {
            case .red:
                return .blue
            case .blue:
                return .red
            }
        }
    }
    
    // 1. Assign red color to the first vertex
    // 2. Assign blue color to the first vertex's neighbors (BFS)
    // 3. Assign red color to the neighbors of the first vertex's neighbors
    // 4. ...
    // 5. While assigning colors, if there is a neighbor with the same color as the current vertex, then the graph is not bipatite
    public var isBipartite: Bool {
        var queue: [GraphNode] = [self]
        var visited: Set<GraphNode> = []
        var colored: [GraphNode: Color] = [:]
        
        while let first = queue.first {
            visited.insert(first)
            
            let color = colored[first, default: .red] // Assign red color to the source node (aka `self`)
            for neighbor in first.neighbors {
                if !visited.contains(neighbor), colored[neighbor] == nil {
                    colored[neighbor] = color.toggled
                    queue.append(neighbor)
                } else if let neighborColor = colored[neighbor], neighborColor == color {
                    return false
                }
            }
            
            queue.removeFirst()
        }
        
        return true
    }
}

// MARK: - Tests

import XCTest

public final class GraphBipartiteTests: XCTestCase {
    func testIsBipartite() {
        let nodeA = GraphNode<String>("A")
        let nodeB = GraphNode<String>("B")
        let nodeC = GraphNode<String>("C")
        let nodeD = GraphNode<String>("D")
        
        nodeA.neighbors.append(nodeB)
        nodeA.neighbors.append(nodeC)
        nodeB.neighbors.append(nodeD)
        nodeD.neighbors.append(nodeC)
        
        XCTAssertTrue(nodeA.isBipartite)
        
        nodeB.neighbors.append(nodeC)
        
        XCTAssertFalse(nodeA.isBipartite)
    }
}
