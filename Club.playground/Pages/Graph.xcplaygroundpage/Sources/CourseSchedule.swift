import Foundation
import XCTest

// Course Schedule
//
// There are a total of `numCourses` courses you have to take,
// labeled from 0 to numCourses-1.
// You are given an array `prerequisites` where `prerequisites[i] = [ai, bi]`
// indicates that you must take course `bi` first if you want to take course `ai`.
// For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
// Return true if you can finish all courses. Otherwise, return false.
//
// This quiz is equal to determine if tasks can all be scheduled

// 1. Convert `prerequisites` to a map instead of graph (easier for DFS)
// 2. Use DFS to iterate every course
// 3. Use `visited` set to check whether there is a loop
//
// Time complexity: O(N + P) where N is `numCourse` and `P` is the length of `prerequisites`
// Space complexity: O(N + P)
public func canFinish(numCourses: Int, prerequisites: [(Int, Int)]) -> Bool {
    guard !prerequisites.isEmpty else {
        return true
    }
    
    var map = [Int: [Int]]()
    for (first, second) in prerequisites {
        map[first, default: []] += [second]
    }
    
    var visied = Set<Int>()
    
    func dfs(course: Int) -> Bool {
        // Check loop
        if visied.contains(course) {
            return false
        }
        
        // Check course still has prerequisite
        guard let list = map[course], !list.isEmpty else {
            return true
        }
        
        visied.insert(course)
        for prerequisite in list {
            guard dfs(course: prerequisite) else {
                return false
            }
        }
        visied.remove(course)
        map[course] = [] // Can early return if encountering the same course again
        
        return true
    }
    
    for course in 0 ..< numCourses {
        guard dfs(course: course) else {
            return false
        }
    }
    
    return true
}

public final class CourseScheduleTests: XCTestCase {
    func testCanFinish() {
        XCTAssertTrue(canFinish(numCourses: 1, prerequisites: []))
        XCTAssertTrue(canFinish(numCourses: 2, prerequisites: [(1, 0)]))
        XCTAssertFalse(canFinish(numCourses: 2, prerequisites: [(1, 0), (0, 1)]))
        XCTAssertTrue(canFinish(numCourses: 5, prerequisites: [(0, 1), (0, 2), (1, 3), (3, 4)]))
        XCTAssertFalse(canFinish(numCourses: 5, prerequisites: [(0, 1), (0, 2), (1, 3), (3, 4), (4, 1)]))
    }
}
