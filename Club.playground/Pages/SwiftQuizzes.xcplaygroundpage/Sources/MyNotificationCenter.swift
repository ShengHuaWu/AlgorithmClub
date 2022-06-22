import Foundation

// TODO: Different ways to store observers
public final class MyNotificationCenter {
    private var observers: [String: [WeakWrapper]] = [:]
    private let queue: DispatchQueueInterface
    private let receiveQueue: DispatchQueueInterface
    
    public init(
        queue: DispatchQueueInterface = DispatchQueue(label: "MyNotificationCenter"),
        receiveQueue: DispatchQueueInterface = DispatchQueue.main
    ) {
        self.queue = queue
        self.receiveQueue = receiveQueue
    }
    
    public func addObserver(_ observer: MyObserver, for notification: String) {
        self.queue.async_ {
            let observersForNotification = self.observers[notification, default: []]
            
            // In order to use `===`, `MyObserver` must conform to `AnyObject`
            if !observersForNotification.contains(where: { $0.value === observer }) {
                let newWrapper = WeakWrapper(value: observer)
                self.observers[notification] = observersForNotification + [newWrapper]
            }
        }
    }
    
    public func remove(_ observer: MyObserver, for notification: String) {
        self.queue.async_ {
            var observersForNotification = self.observers[notification, default: []]
            if let indexToRemove = observersForNotification.firstIndex(where: { $0.value === observer }) {
                observersForNotification.remove(at: indexToRemove)
                self.observers[notification] = observersForNotification
            }
        }
    }
    
    public func post(_ notification: String) {
        // Cannot use `sync` here because it could cause deadlock,
        // for example, calling `addObserver` inside `receive`
        self.queue.async_ {
            self.observers[notification]?.forEach { observer in
                self.receiveQueue.async_ {
                    observer.value?.receive(notification)
                }
            }
        }
    }
}

// MARK: - Tests

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

public final class MyNotificationCenterTests: XCTestCase {
    private var queue: ImmediateQueue!
    private var receiveQueue: ImmediateQueue!
    private var subject: MyNotificationCenter!
    
    private let notification = "Notification"
    
    public override func setUp() {
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
