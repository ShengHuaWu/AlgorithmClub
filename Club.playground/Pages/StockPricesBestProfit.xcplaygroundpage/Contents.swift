//: [Previous](@previous)

import XCTest

final class StockPricesBestProfitTests: XCTestCase {
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

StockPricesBestProfitTests.defaultTestSuite.run()

//: [Next](@next)
