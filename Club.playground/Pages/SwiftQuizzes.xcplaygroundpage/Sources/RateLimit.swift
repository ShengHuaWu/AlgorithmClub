import Foundation

// Rate Limit
//
// Implement a rate limit of 5 requests in 2 seconds for the `invokeEndpoint` method

public final class TDD_API {
    private typealias CustomerId = String
    
    private struct Condition {
        var count = 0
        var lastCallTime = Date()
    }
    
    private var conditionOfCustomers: [CustomerId: Condition] = [:]
    private let queue = DispatchQueue(label: "API")
    
    public init() {}
    
    public func invokeEndpoint(_ customerId: String) -> String? {
        self.queue.sync {
            let now = Date()
            var condition = conditionOfCustomers[customerId, default: Condition()]
            
            if now.timeIntervalSince(condition.lastCallTime) > 2 {
                condition.lastCallTime = now
                condition.count = 1
                
                conditionOfCustomers[customerId] = condition
                
                return customerId
            } else {
                condition.count += 1
                conditionOfCustomers[customerId] = condition
                
                guard condition.count < 6 else {
                    return nil
                }
                
                return customerId
            }
        }
    }
}

// MARK: - Tests

import XCTest

public final class TDD_RateLimitTests: XCTestCase {
    func testInvokeEndpointFiveTimes() {
        let customerId = "ABC"
        
        let api = TDD_API()
        
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
    }
    
    func testInvokeEndpointSixTimes() {
        let customerId = "ABC"
        
        let api = TDD_API()
        
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNil(api.invokeEndpoint(customerId))
    }
    
    func testInvokeEndpointSixTimesButExceedingTwoSeconds() {
        let delayTwoSeconds = expectation(description: #function)
        
        let customerId = "ABC"
        
        let api = TDD_API()
        
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        
        DispatchQueue(label: #function).asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(api.invokeEndpoint(customerId))
            delayTwoSeconds.fulfill()
        }
        
        wait(for: [delayTwoSeconds], timeout: 5.0)
    }
    
    func testInvokeEndpointSixTimesButExceedingTwoSecondsAndAnotherFiveTimes() {
        let delayTwoSeconds = expectation(description: #function)
        
        let customerId = "ABC"
        
        let api = TDD_API()
        
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        
        DispatchQueue(label: #function).asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(api.invokeEndpoint(customerId))
            
            XCTAssertNotNil(api.invokeEndpoint(customerId))
            XCTAssertNotNil(api.invokeEndpoint(customerId))
            XCTAssertNotNil(api.invokeEndpoint(customerId))
            XCTAssertNotNil(api.invokeEndpoint(customerId))
            XCTAssertNil(api.invokeEndpoint(customerId))
            
            delayTwoSeconds.fulfill()
        }
        
        wait(for: [delayTwoSeconds], timeout: 5.0)
    }
    
    func testInvokeEndpointFiveTimesWithTwoCustomers() {
        let customer1 = "ABC"
        let customer2 = "XYZ"
        
        let api = TDD_API()
        
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
    }
    
    func testInvokeEndpointFiveTimesForFirstCustomerButSixTimesForSecondCustomer() {
        let customer1 = "ABC"
        let customer2 = "XYZ"
        
        let api = TDD_API()
        
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNil(api.invokeEndpoint(customer2))
    }
    
    func testInvokeEndpointSixTimesWithTwoCustomers() {
        let customer1 = "ABC"
        let customer2 = "XYZ"
        
        let api = TDD_API()
        
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNil(api.invokeEndpoint(customer1))
        
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNil(api.invokeEndpoint(customer2))
    }
    
    func testInvokeEndpointSixTimesWithTwoCustomersButExceedingTwoSeconds() {
        let customer1 = "ABC"
        let customer2 = "XYZ"
        
        let api = TDD_API()
        
        let delayTwoSeconds = expectation(description: #function)
        
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: #function)
        
        group.enter()
        queue.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(api.invokeEndpoint(customer1))
            group.leave()
        }
        
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        
        group.enter()
        queue.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(api.invokeEndpoint(customer2))
            group.leave()
        }
        
        group.notify(queue: .main) {
            delayTwoSeconds.fulfill()
        }
        
        wait(for: [delayTwoSeconds], timeout: 5.0)
    }
}
