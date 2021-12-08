//: [Previous](@previous)

import Foundation
import XCTest

final class RateLimitTests: XCTestCase {
    override func setUp() {
        super.setUp()
        
        global.cache.cleanUp()
    }
    
    func testInvokeEndpointReturnResponseWithTwoDifferentCustomerIds() {
        let customerId1 = "One"
        let customerId2 = "Two"
        let api = API()
        
        api.invokeEndpoint(customerId1)
        api.invokeEndpoint(customerId2)
        api.invokeEndpoint(customerId1)
        api.invokeEndpoint(customerId1)
        
        XCTAssertEqual(api.invokeEndpoint(customerId1), "Response for One")
        XCTAssertEqual(api.invokeEndpoint(customerId2), "Response for Two")
        
        invokeEndpoint(customerId1)
        invokeEndpoint(customerId2)
        invokeEndpoint(customerId1)
        invokeEndpoint(customerId1)
        
        XCTAssertEqual(invokeEndpoint(customerId1), "One")
        XCTAssertEqual(invokeEndpoint(customerId2), "Two")
    }
    
    func testInvokeEndpointReturnsNilAfterCallingItSixTimesStraight() {
        let customerId = "One"
        let api = API()
        
        api.invokeEndpoint(customerId)
        api.invokeEndpoint(customerId)
        api.invokeEndpoint(customerId)
        api.invokeEndpoint(customerId)
        
        XCTAssertEqual(api.invokeEndpoint(customerId), "Response for One")
        XCTAssertNil(api.invokeEndpoint(customerId))
        
        invokeEndpoint(customerId)
        invokeEndpoint(customerId)
        invokeEndpoint(customerId)
        invokeEndpoint(customerId)
        
        XCTAssertEqual(invokeEndpoint(customerId), "One")
        XCTAssertNil(invokeEndpoint(customerId))
    }
    
    func testInvokeEndpointReturnsResponseAfterCallingItSixTimesStraightButExceedingTwoSeconds() {
        var e = expectation(description: #function)
        let customerId = "One"
        let api = API()
        
        api.invokeEndpoint(customerId)
        api.invokeEndpoint(customerId)
        api.invokeEndpoint(customerId)
        api.invokeEndpoint(customerId)
        
        XCTAssertEqual(api.invokeEndpoint(customerId), "Response for One")
        
        DispatchQueue(label: #function).asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(api.invokeEndpoint(customerId), "Response for One")
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        e = expectation(description: #function)
        
        invokeEndpoint(customerId)
        invokeEndpoint(customerId)
        invokeEndpoint(customerId)
        invokeEndpoint(customerId)
        
        XCTAssertEqual(invokeEndpoint(customerId), "One")
        
        DispatchQueue(label: #function).asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(invokeEndpoint(customerId), "One")
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
}

//RateLimitTests.defaultTestSuite.run()

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

//TDD_RateLimitTests.defaultTestSuite.run()

//: [Next](@next)
