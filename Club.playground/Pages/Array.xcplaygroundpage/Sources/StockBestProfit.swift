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

// MARK: - Tests

import XCTest

public final class StockPricesBestProfitTests: XCTestCase {
    func testGetBestProfitWhenBuyOnceSellOnce() {
        XCTAssertEqual([Int]().getBestProfitWhenBuyOnceSellOnce(), -1)
        XCTAssertEqual([1].getBestProfitWhenBuyOnceSellOnce(), -1)
        XCTAssertEqual([1, 1].getBestProfitWhenBuyOnceSellOnce(), 0)
        XCTAssertEqual([10, 7, 5, 8, 11, 9].getBestProfitWhenBuyOnceSellOnce(), 6)
        XCTAssertEqual([10, 7, 5, 8, 4, 11, 9].getBestProfitWhenBuyOnceSellOnce(), 7)
        XCTAssertEqual([45, 24, 35, 31, 40, 38, 11].getBestProfitWhenBuyOnceSellOnce(), 16)
    }
    
    func testGetBestProfitWhenMultipleBuySell() {
        XCTAssertEqual([Int]().getBestProfitWhenMultipleBuySell(), -1)
        XCTAssertEqual([1].getBestProfitWhenMultipleBuySell(), -1)
        XCTAssertEqual([1, 1].getBestProfitWhenMultipleBuySell(), 0)
        XCTAssertEqual([10, 7, 5, 8, 11, 9].getBestProfitWhenMultipleBuySell(), 6)
        XCTAssertEqual([10, 7, 5, 8, 4, 11, 9].getBestProfitWhenMultipleBuySell(), 10)
        XCTAssertEqual([100, 180, 260, 310, 40, 535, 695].getBestProfitWhenMultipleBuySell(), 865)
    }
}
