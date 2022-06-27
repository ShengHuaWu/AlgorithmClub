import Foundation

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

// MARK: - Tests
import XCTest

public final class GraphClonedTests: XCTestCase {
    func testClone() {
        let tempNodeA = GraphNode<String>("A")
        let tempNodeB = GraphNode<String>("B")
        let tempNodeC = GraphNode<String>("C")
        let tempNodeD = GraphNode<String>("D")
        
        tempNodeA.neighbors.append(tempNodeB)
        tempNodeA.neighbors.append(tempNodeD)
        tempNodeB.neighbors.append(tempNodeA)
        tempNodeB.neighbors.append(tempNodeC)
        tempNodeC.neighbors.append(tempNodeB)
        tempNodeC.neighbors.append(tempNodeD)
        tempNodeD.neighbors.append(tempNodeA)
        tempNodeD.neighbors.append(tempNodeC)
        
        let expected = """
        Node: A-cloned with Neigbors: B-cloned D-cloned 
        """
        
        XCTAssertEqual(tempNodeA.cloned().description, expected)
    }
}
