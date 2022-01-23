//: [Previous](@previous)

import XCTest

// MARK: - Test Target Function
func repeatingFiveTimes(timer: TimerContainer, print: @escaping () -> Void) {
    var count = 0
    timer.schedule(0.5) {
        count += 1
        if count > 5 {
            timer.invalidate()
        } else {
            print()
        }
    }
}

final class TimerTests: XCTestCase {
    func testRepeatingLive() {
        var printCallCount = 0
        let expectFiveCallCounts = self.expectation(description: #function)
        
        repeatingFiveTimes(timer: .live, print: {
            printCallCount += 1
            
            if printCallCount == 5 {
                expectFiveCallCounts.fulfill()
            }
        })
        
        self.wait(for: [expectFiveCallCounts], timeout: 5)
    }
    
    func testRepeatingImmediate() {
        var printCallCount = 0
        
        repeatingFiveTimes(timer: .immediate, print: { printCallCount += 1 })
        
        XCTAssertEqual(printCallCount, 1)
    }

    func testRepeatingSixTimes() {
        var printCallCount = 0
        
        repeatingFiveTimes(timer: .repeating(times: 6), print: { printCallCount += 1 })
        
        XCTAssertEqual(printCallCount, 5)
    }
}

TimerTests.defaultTestSuite.run()

//: [Next](@next)
