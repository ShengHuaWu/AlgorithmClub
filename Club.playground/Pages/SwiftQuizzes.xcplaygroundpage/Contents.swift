//: [Previous](@previous)

import XCTest

// MARK: - Rate Limit

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

// MARK: - Parse Accept Languages
//
// The accept language headers is comma-separated list and it could contain spaces, for example, `"en-US, fr-CA"`.
// In addition, it could also contain non-region form, such as, `"en, fr-CA"`,
// and there could also be a wildcard tag `"*"` inside the accept language headers.
// The order of the accept language headers matters.

final class ParseAcceptLanguagesTests: XCTestCase {
    func testParseAcceptLanguagesWithFullNames() {
        let headers = "en-US, fr-CA"
        let supported = ["en-US"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US"])
    }
    
    func testParseAcceptLanguagesWithFullNamesAndTwoSupportedLanguages() {
        let headers = "en-US, fr-CA"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "fr-CA"])
    }
    
    func testParseAcceptLanguagesWithFullNamesAndTwoSupportedLanguagesButDifferentOrder() {
        let headers = "fr-CA, en-US"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["fr-CA", "en-US"])
    }
    
    func testParseAcceptLanguagesWithShortName() {
        let headers = "en, fr-CA"
        let supported = ["en-US"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US"])
    }
    
    func testParseAcceptLanguagesWithShortNameAndFullNameAndTwoSupportedLanguages() {
        let headers = "en, fr-CA"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "fr-CA"])
    }
    
    func testParseAcceptLanguagesWithFullNameAndShortNameAndTwoSupportedLanguages() {
        let headers = "en-US, fr"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "fr-CA"])
    }
    
    func testParseAcceptLanguagesWithShortNamesAndTwoSupportedLanguages() {
        let headers = "en, fr"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "fr-CA"])
    }
    
    func testParseAcceptLanguagesWithShortNamesAndTwoSupportedLanguagesButDifferentOrder() {
        let headers = "fr, en"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["fr-CA", "en-US"])
    }
    
    func testParseAcceptLanguagesWithShortNameAndTwoSupportedLanguagesOfDifferentRegions() {
        let headers = "en, fr-CA"
        let supported = ["en-US", "en-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "en-CA"])
    }
    
    func testParseAcceptLanguagesWithFullNameAndWildcard() {
        let headers = "en-US, *"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "fr-CA"])
    }
    
    func testParseAcceptLanguagesWithWildcardAndFullName() {
        let headers = "*, en-US"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "fr-CA"])
    }
    
    func testParseAcceptLanguagesWithShortNameAndFullNameAndWildcard() {
        let headers = "en, fr-CA, *"
        let supported = ["en-US", "fr-CA", "de-DE"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "fr-CA", "de-DE"])
    }
    
    func testParseAcceptLanguagesWithShortNameAndFullNameAndWildcardButDifferentOrder() {
        let headers = "fr-CA, en, *"
        let supported = ["en-US", "fr-CA", "de-DE"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["fr-CA", "en-US", "de-DE"])
    }
    
    func testParseAcceptLanguagesWithShortNameAndFullNameAndWildcardTwoSupportedLanguagesOfDifferentRegions() {
        let headers = "en, fr-CA, *"
        let supported = ["en-US", "en-UK", "fr-CA", "de-DE"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "en-UK", "fr-CA", "de-DE"])
    }
}

ParseAcceptLanguagesTests.defaultTestSuite.run()

// MARK: - Notification Center

final class MockObserver: MyObserver {
    private(set) var receiveCallCount = 0
    private(set) var receivedNotification: String!
    
    func receive(_ notification: String) {
        receiveCallCount += 1
        receivedNotification = notification
    }
}

final class MockObserverForRetainCycle: MyObserver {
    private(set) var receiveCallCount = 0
    private(set) var receivedNotification: String!
    
    private let notificationCenter: MyNotificationCenter
    private let deinitExpectation: XCTestExpectation
    
    init(
        notificationCenter: MyNotificationCenter,
        deinitExpectation: XCTestExpectation
    ) {
        self.notificationCenter = notificationCenter
        self.deinitExpectation = deinitExpectation
    }
    
    func receive(_ notification: String) {
        receiveCallCount += 1
        receivedNotification = notification
    }
    
    deinit {
        deinitExpectation.fulfill()
    }
}

final class ImmediateQueue: DispatchQueueInterface {
    private(set) var asyncCallCount = 0
    
    func async_(_ block: @escaping () -> Void) {
        asyncCallCount += 1
        block()
    }
}

final class MyNotificationCenterTests: XCTestCase {
    private var queue: ImmediateQueue!
    private var receiveQueue: ImmediateQueue!
    private var subject: MyNotificationCenter!
    
    private let notification = "Notification"
    
    override func setUp() {
        super.setUp()
        
        queue = ImmediateQueue()
        receiveQueue = ImmediateQueue()
        subject = MyNotificationCenter(queue: queue, receiveQueue: receiveQueue)
    }
    
    func testPostThenObserverReceiveNotification() {
        let observer = MockObserver()
        subject.addObserver(observer, for: notification)
        
        subject.post(notification)
        
        XCTAssertEqual(observer.receiveCallCount, 1)
        XCTAssertEqual(observer.receivedNotification, notification)
        XCTAssertEqual(queue.asyncCallCount, 2)
        XCTAssertEqual(receiveQueue.asyncCallCount, 1)
    }
    
    func testRemoveThenObserverNotReceiveNotification() {
        let observer = MockObserver()
        subject.addObserver(observer, for: notification)
        subject.remove(observer, for: notification)
        
        subject.post(notification)
        
        XCTAssertEqual(observer.receiveCallCount, 0)
        XCTAssertNil(observer.receivedNotification)
        XCTAssertEqual(queue.asyncCallCount, 3)
        XCTAssertEqual(receiveQueue.asyncCallCount, 0)
    }
    
    func testAddTheSameObserverTwice() {
        let observer = MockObserver()
        subject.addObserver(observer, for: notification)
        subject.addObserver(observer, for: notification)
        
        subject.post(notification)
        
        XCTAssertEqual(observer.receiveCallCount, 1)
        XCTAssertEqual(observer.receivedNotification, notification)
        XCTAssertEqual(queue.asyncCallCount, 3)
        XCTAssertEqual(receiveQueue.asyncCallCount, 1)
    }
    
    func testAddTwoObservers() {
        let observer1 = MockObserver()
        subject.addObserver(observer1, for: notification)
        
        let observer2 = MockObserver()
        subject.addObserver(observer2, for: notification)
        
        subject.post(notification)
        
        XCTAssertEqual(observer1.receiveCallCount, 1)
        XCTAssertEqual(observer1.receivedNotification, notification)
        XCTAssertEqual(observer2.receiveCallCount, 1)
        XCTAssertEqual(observer2.receivedNotification, notification)
        XCTAssertEqual(queue.asyncCallCount, 3)
        XCTAssertEqual(receiveQueue.asyncCallCount, 2)
    }
    
    func testRetainCycle() {
        let `deinit` = expectation(description: #function)
        
        var observer: MockObserverForRetainCycle? = MockObserverForRetainCycle(
            notificationCenter: subject,
            deinitExpectation: `deinit`
        )
        subject.addObserver(observer!, for: notification)
        
        subject.post(notification)
        
        XCTAssertEqual(observer?.receiveCallCount, 1)
        XCTAssertEqual(observer?.receivedNotification, notification)
        XCTAssertEqual(queue.asyncCallCount, 2)
        XCTAssertEqual(receiveQueue.asyncCallCount, 1)
        
        observer = nil
        
        wait(for: [`deinit`], timeout: 0.5)
    }
}

MyNotificationCenterTests.defaultTestSuite.run()

// MARK: - Hash Collision

struct MyHash: Hashable {
    let value1: Int
    let value2: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value1 + value2)
    }
}

final class HashCollisionTests: XCTestCase {
    func testHashCollision() {
        let h1 = MyHash(value1: 2, value2: 3)
        let h2 = MyHash(value1: 3, value2: 2)
        
        XCTAssertEqual(h1.hashValue, h2.hashValue)
        XCTAssertFalse(h1 == h2)
        
        let dictionary = [
            h1: 1,
            h2: 2
        ]
        
        // `Dictionary` uses `Equtable` to determine the key
        XCTAssertFalse(dictionary[h1] == dictionary[h2])
    }
}

HashCollisionTests.defaultTestSuite.run()

//: [Next](@next)
