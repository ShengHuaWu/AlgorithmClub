import Foundation

extension Array where Element: Equatable {
    // Dynamic programming
    // https://www.youtube.com/watch?v=sSno9rV8Rhg
    //
    // Time complexity: O(N * M),
    // where N is the length of `self` and M is the length of `another`
    public func findLongestCommonSubsequence(with another: Self) -> Int {
        // The key point of the table is reducing duplicated calculations
        // Be careful of `count` argument
        let inner = Array<Int>(repeating: 0, count: another.count + 1)
        var table: [[Int]] = Array<[Int]>(repeating: inner, count: self.count + 1)
                
        for indexOfSelf in 0 ... self.count {
            for indexOfAnother in 0 ... another.count {
                if indexOfSelf == 0 || indexOfAnother == 0 {
                    table[indexOfSelf][indexOfAnother] = 0
                } else if self[indexOfSelf - 1] == another[indexOfAnother - 1] {
                    table[indexOfSelf][indexOfAnother] = 1 + table[indexOfSelf - 1][indexOfAnother - 1]
                } else {
                    table[indexOfSelf][indexOfAnother] = Swift.max(
                        table[indexOfSelf - 1][indexOfAnother],
                        table[indexOfSelf][indexOfAnother - 1]
                    )
                }
            }
        }
        
        return table[self.count][another.count]
    }
}
