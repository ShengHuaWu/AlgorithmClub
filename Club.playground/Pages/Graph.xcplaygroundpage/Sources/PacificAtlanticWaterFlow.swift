import Foundation

// Pacific Atlantic Water Flow
//
// There is an m x n rectangular island that borders both the Pacific Ocean and Atlantic Ocean.
// The Pacific Ocean touches the island's left and top edges,
// and the Atlantic Ocean touches the island's right and bottom edges.
// The island is partitioned into a grid of square cells.
// You are given an m x n integer matrix heights
// where heights[r][c] represents the height above sea level of the cell at coordinate (r, c).
//
// The island receives a lot of rain,
// and the rain water can flow to neighboring cells directly north, south, east, and west
// if the neighboring cell's height is less than or equal to the current cell's height.
// Water can flow from any cell adjacent to an ocean into the ocean.
// Return a 2D list of grid coordinates result
// where result[i] = [ri, ci] denotes that rain water can flow
// from cell (ri, ci) to both the Pacific and Atlantic oceans.

public struct Cell: Hashable {
    public let row: Int
    public let column: Int
}

// 1. Water flow can reaches both oceans means both oceans can reach these cells (think backward)
// 2. Use DFS to check the cell resursively
// 3. Use two sets to avoid double-checking
//
// Time complexity: O (N * M) where N is the number of rows and M is the number of columns
public func pacificAtlantic(_ heights: [[Int]]) -> [Cell] {
    let rowCount = heights.count
    
    guard rowCount > 0,
          let columnCount = heights.first?.count,
          columnCount > 0 else {
        return []
    }
    
    var pacifics = Set<Cell>()
    var atlantics = Set<Cell>()
    
    func dfs(row: Int, column: Int, visited: inout Set<Cell>, previousHeight: Int) {
        let cell = Cell(row: row, column: column)

        guard !visited.contains(cell),
              row >= 0, column >= 0, row < rowCount, column < columnCount, // Avoid out-of-bounds
              heights[row][column] >= previousHeight else {
            return
        }
        
        visited.insert(cell)
        
        // Recursively check the adjacent cells in four directions
        dfs(row: row - 1, column: column, visited: &visited, previousHeight: heights[row][column])
        dfs(row: row + 1, column: column, visited: &visited, previousHeight: heights[row][column])
        dfs(row: row, column: column - 1, visited: &visited, previousHeight: heights[row][column])
        dfs(row: row, column: column + 1, visited: &visited, previousHeight: heights[row][column])
    }
    
    for row in 0 ..< rowCount {
        // Start from cells in first column (which can reach Pacific Ocean)
        dfs(row: row, column: 0, visited: &pacifics, previousHeight: heights[row][0])
        
        // Start from cells in last column (which can reach Atlantic Ocean)
        dfs(row: row, column: columnCount - 1, visited: &atlantics, previousHeight: heights[row][columnCount - 1])
    }
    
    for column in 0 ..< columnCount {
        // Start from the cells in first row (which can reach Pacific Ocean)
        dfs(row: 0, column: column, visited: &pacifics, previousHeight: heights[0][column])
        
        // Start from the cells in last row (which can reach Atlantic Ocean)
        dfs(row: rowCount - 1, column: column, visited: &atlantics, previousHeight: heights[rowCount - 1][column])
    }
    
    var results = [Cell]()
    for row in 0 ..< rowCount {
        for column in 0 ..< columnCount {
            let cell = Cell(row: row, column: column)
            if pacifics.contains(cell) && atlantics.contains(cell) {
                results.append(cell)
            }
        }
    }
    
    return results
}

// MARK: - Tests

import XCTest

public final class PacificAtlanticWaterFlowTests: XCTestCase {
    func testPacificAtlantic() {
        var heights = [[Int]]()
        
        XCTAssertTrue(pacificAtlantic(heights).isEmpty)
        
        heights = [[2, 1], [1, 2]]
        
        var expected: [Cell] = [
            .init(row: 0, column: 0),
            .init(row: 0, column: 1),
            .init(row: 1, column: 0),
            .init(row: 1, column: 1)
        ]
        
        XCTAssertEqual(pacificAtlantic(heights), expected)
        
        heights = [
            [1, 2, 2, 3, 5],
            [3, 2, 3, 4, 4],
            [2, 4, 5, 3, 1],
            [6, 7, 1, 4, 5],
            [5, 1, 1, 2, 4]
        ]
        
        expected = [
            .init(row: 0, column: 4),
            .init(row: 1, column: 3),
            .init(row: 1, column: 4),
            .init(row: 2, column: 2),
            .init(row: 3, column: 0),
            .init(row: 3, column: 1),
            .init(row: 4, column: 0)
        ]
        
        XCTAssertEqual(pacificAtlantic(heights), expected)
    }
}
