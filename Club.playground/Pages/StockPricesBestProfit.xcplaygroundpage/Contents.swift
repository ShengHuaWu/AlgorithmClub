//: [Previous](@previous)

import XCTest

final class StockPricesBestProfitTests: XCTestCase {
    func testGetBestProfitWhenBuyOnceSellOnce() {
        XCTAssertEqual([Int]().getBestProfitWhenBuyOnceSellOnce(), -1)
        XCTAssertEqual([1].getBestProfitWhenBuyOnceSellOnce(), 0)
        XCTAssertEqual([10, 7, 5, 8, 11, 9].getBestProfitWhenBuyOnceSellOnce(), 6)
        XCTAssertEqual([10, 7, 5, 8, 4, 11, 9].getBestProfitWhenBuyOnceSellOnce(), 7)
        XCTAssertEqual([45, 24, 35, 31, 40, 38, 11].getBestProfitWhenBuyOnceSellOnce(), 16)
    }
}

StockPricesBestProfitTests.defaultTestSuite.run()

//: [Next](@next)
