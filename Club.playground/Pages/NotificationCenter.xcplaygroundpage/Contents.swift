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

final class ImmediateQueue: DispatchQueueInterface {
    private(set) var syncCallCount = 0
    private(set) var asyncCallCount = 0
    
    func sync_(_ block: () -> Void) {
        syncCallCount += 1
        block()
    }
    
    func async_(_ block: @escaping () -> Void) {
        asyncCallCount += 1
        block()
    }
}

final class MyNotificationCenterTests: XCTestCase {
    private var queue: ImmediateQueue!
    private var subject: MyNotificationCenter!
    
    override func setUp() {
        super.setUp()
        
        queue = ImmediateQueue()
        subject = MyNotificationCenter(queue: queue)
    }
    
    func testPostThenObserverReceiveNotification() {
        let notification = "Notification"
        let observer = MockObserver()
        subject.addObserver(observer, for: notification)
        
        subject.post(notification)
        
        XCTAssertEqual(observer.receiveCallCount, 1)
        XCTAssertEqual(observer.receivedNotification, notification)
        XCTAssertEqual(queue.syncCallCount, 1)
        XCTAssertEqual(queue.asyncCallCount, 1)
    }
    
    func testRemoveThenObserverNotReceiveNotification() {
        let notification = "Notification"
        let observer = MockObserver()
        subject.addObserver(observer, for: notification)
        subject.remove(observer, for: notification)
        
        subject.post(notification)
        
        XCTAssertEqual(observer.receiveCallCount, 0)
        XCTAssertNil(observer.receivedNotification)
        XCTAssertEqual(queue.syncCallCount, 2)
        XCTAssertEqual(queue.asyncCallCount, 1)
    }
}

MyNotificationCenterTests.defaultTestSuite.run()

//: [Next](@next)
