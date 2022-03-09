import Foundation

// TODO: Different ways to store observers
public final class MyNotificationCenter {
    private var observers: [String: [WeakWrapper]] = [:]
    private let queue: DispatchQueueInterface
    
    public init(queue: DispatchQueueInterface = DispatchQueue(label: "MyNotificationCenter")) {
        self.queue = queue
    }
    
    public func addObserver(_ observer: MyObserver, for notification: String) {
        self.queue.sync_ {
            let observersForNotification = self.observers[notification, default: []]
            
            // In order to use `===`, `MyObserver` must conform to `AnyObject`
            if !observersForNotification.contains(where: { $0.value === observer }) {
                let newWrapper = WeakWrapper(value: observer)
                self.observers[notification] = observersForNotification + [newWrapper]
            }
        }
    }
    
    public func remove(_ observer: MyObserver, for notification: String) {
        self.queue.sync_ {
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
            self.observers[notification]?.forEach { $0.value?.receive(notification) }
        }
    }
}
