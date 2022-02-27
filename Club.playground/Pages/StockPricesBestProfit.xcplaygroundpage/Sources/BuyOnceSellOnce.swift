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
        guard let first = self.first, self.count > 1 else {
            return -1
        }
        
        var buy = first
        var sell: Int
        var max = 0
        
        for index in 1 ..< self.count {
            sell = self[index]
            let profit = sell - buy
            if profit < 0 {
                buy = sell
                continue
            }
            
            max = Swift.max(max, profit)
        }
        
        return max
    }
}
