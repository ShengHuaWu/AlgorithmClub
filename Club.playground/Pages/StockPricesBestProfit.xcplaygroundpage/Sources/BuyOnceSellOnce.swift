import Foundation

/*
 You will be given a list of stock prices for a given day
 and your goal is to return the maximum profit that could have been made
 by buying a stock at the given price and then selling the stock later on.
 For example if the input is: [45, 24, 35, 31, 40, 38, 11]
 then your program should return 16
 because if you bought the stock at $24 and sold it at $40,
 a profit of $16 was made and this is the largest profit that could be made.
 If no profit could have been made, return -1.
 */

extension Array where Element == Int {
    public func getBestProfitWhenBuyOnceSellOnce() -> Int {
        guard !self.isEmpty else {
            return -1
        }
        
        var buyPrice = Int.min
        var sellPrice = Int.min
        
        var shouldChangeBuyPrice = true // Use this to track the `buyPrice`
        
        var bestProfit = 0
        
        for index in 0 ..< (self.count - 1) {
            buyPrice = shouldChangeBuyPrice ? self[index] : buyPrice
            sellPrice = self[index + 1]
            let profit = sellPrice - buyPrice
            
            // Cannot make position profit from the current `buyPrice` and `sellPrice`
            // So we need to get a new `buyPrice`
            if profit < 0 {
                shouldChangeBuyPrice = true
                continue
            }
            
            if bestProfit < profit {
                bestProfit = profit
                shouldChangeBuyPrice = false
            }
        }
        
        return bestProfit
    }
}
