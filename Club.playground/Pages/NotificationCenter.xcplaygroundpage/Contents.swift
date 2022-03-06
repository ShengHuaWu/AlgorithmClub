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

final class MyNotificationCenterTests: XCTestCase {
    private var subject: MyNotificationCenter!
    
    override func setUp() {
        super.setUp()
        
        subject = MyNotificationCenter()
    }
    
    func testPostThenObserverReceiveNotification() {
        let notification = "Notification"
        let observer = MockObserver()
        subject.addObserver(observer, for: notification)
        
        subject.post(notification)
        
        XCTAssertEqual(observer.receiveCallCount, 1)
        XCTAssertEqual(observer.receivedNotification, notification)
    }
    
    func testRemoveThenObserverNotReceiveNotification() {
        let notification = "Notification"
        let observer = MockObserver()
        subject.addObserver(observer, for: notification)
        subject.remove(observer, for: notification)
        
        subject.post(notification)
        
        XCTAssertEqual(observer.receiveCallCount, 0)
        XCTAssertNil(observer.receivedNotification)
    }
}

MyNotificationCenterTests.defaultTestSuite.run()

//: [Next](@next)
