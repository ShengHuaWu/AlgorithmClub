//: [Previous](@previous)

import XCTest

final class TDD_RateLimitTests: XCTestCase {
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

TDD_RateLimitTests.defaultTestSuite.run()

//: [Next](@next)
