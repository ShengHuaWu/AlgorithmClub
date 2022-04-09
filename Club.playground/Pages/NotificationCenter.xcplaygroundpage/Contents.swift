//: [Previous](@previous)

import XCTest

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
    private var subject: MyNotificationCenter!
    
    private let notification = "Notification"
    
    override func setUp() {
        super.setUp()
        
        queue = ImmediateQueue()
        subject = MyNotificationCenter(queue: queue)
    }
    
    func testPostThenObserverReceiveNotification() {
        let observer = MockObserver()
        subject.addObserver(observer, for: notification)
        
        subject.post(notification)
        
        XCTAssertEqual(observer.receiveCallCount, 1)
        XCTAssertEqual(observer.receivedNotification, notification)
        XCTAssertEqual(queue.asyncCallCount, 2)
    }
    
    func testRemoveThenObserverNotReceiveNotification() {
        let observer = MockObserver()
        subject.addObserver(observer, for: notification)
        subject.remove(observer, for: notification)
        
        subject.post(notification)
        
        XCTAssertEqual(observer.receiveCallCount, 0)
        XCTAssertNil(observer.receivedNotification)
        XCTAssertEqual(queue.asyncCallCount, 3)
    }
    
    func testAddTheSameObserverTwice() {
        let observer = MockObserver()
        subject.addObserver(observer, for: notification)
        subject.addObserver(observer, for: notification)
        
        subject.post(notification)
        
        XCTAssertEqual(observer.receiveCallCount, 1)
        XCTAssertEqual(observer.receivedNotification, notification)
        XCTAssertEqual(queue.asyncCallCount, 3)
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
        
        observer = nil
        
        wait(for: [`deinit`], timeout: 0.5)
    }
}

MyNotificationCenterTests.defaultTestSuite.run()

//: [Next](@next)
