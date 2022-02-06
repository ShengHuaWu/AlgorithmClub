import Foundation

/*
 The cost of a stock on each day is given in an array,
 find the max profit that you can make by buying and selling in those days.
 For example, if the given array is [100, 180, 260, 310, 40, 535, 695],
 the best profit can earned by buying on day 0, selling on day 3.
 Again buy on day 4 and sell on day 6. So the best profit will be 865.
 If no profit could have been made, return -1.
 */

extension Array where Element == Int {
    // The best profit will be the sum of all positive differences between elements
    public func getBestProfitWhenMultipleBuySell() -> Int {
        guard self.count > 1 else {
            return -1
        }
        
        var bestProfit = 0
        for index in 0 ..< (self.count - 1) {
            let profit = self[index + 1] - self[index]
            if profit > 0 {
                bestProfit += profit
            }
        }
        
        return bestProfit
    }
}
