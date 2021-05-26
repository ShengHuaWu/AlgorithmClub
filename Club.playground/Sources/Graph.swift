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

// Determine If Tasks Can All Be Scheduled
//
// There are ‘N’ tasks, labeled from ‘0’ to ‘N-1’.
// Each task can have some prerequisite tasks which need to be completed before it can be scheduled.
// Given the number of tasks and a list of prerequisite pairs, find out if it is possible to schedule all the tasks.
// This problem is equivalent to detecting a cycle in the graph represented by prerequisites.

// TODO: This doesn't work yet
public func canAllBeScheduled(with prerequisites: [(Int, Int)]) -> Bool {
    guard !prerequisites.isEmpty else {
        return false
    }
    
    var nodes: Set<GraphNode<Int>> = []
    for (first, second) in prerequisites {
        if let firstNode = nodes.first(where: { $0.value == first }),
           let secondNode = nodes.first(where: { $0.value == second }) {
            nodes.remove(firstNode)
            nodes.remove(secondNode)
            secondNode.neighbors.append(firstNode)
            nodes.insert(secondNode)
        } else if let firstNode = nodes.first(where: { $0.value == first }) {
            nodes.remove(firstNode)
            let secondNode = GraphNode<Int>(second)
            secondNode.neighbors.append(firstNode)
            nodes.insert(secondNode)
        } else if let secondNode = nodes.first(where: { $0.value == second }) {
            nodes.remove(secondNode)
            let firstNode = GraphNode<Int>(first)
            secondNode.neighbors.append(firstNode)
            nodes.insert(secondNode)
        } else {
            let firstNode = GraphNode<Int>(first)
            let secondNode = GraphNode<Int>(second)
            secondNode.neighbors.append(firstNode)
            nodes.insert(secondNode)
        }
    }
    
    var visited: Set<GraphNode<Int>> = []
    
    var result = false
    while !nodes.isEmpty {
        let node = nodes.removeFirst()
        result = result || hasCycle(for: node, onPath: nodes, visited: &visited)
    }
    
    return !result
}

private func hasCycle(for node: GraphNode<Int>, onPath: Set<GraphNode<Int>>, visited: inout Set<GraphNode<Int>>) -> Bool {
    print("node:")
    print(node.value)
    
    print("visited:")
    visited.forEach {
        print($0.value)
    }
    
    if visited.contains(node) {
        return true
    }
    
    if !onPath.contains(node) {
        visited.insert(node)
    }
        
    return node.neighbors.reduce(false) { result, neighbor in
        result || hasCycle(for: neighbor, onPath: onPath, visited: &visited)
    }
}
