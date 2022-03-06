// TODO: Thread safety, avoid deadlock and retain cycle
public final class MyNotificationCenter {
    private var observers: [String: [MyObserver]] = [:]
    
    public init() {}
    
    public func addObserver(_ observer: MyObserver, for notification: String) {
        let observersForNotification = self.observers[notification, default: []]
        self.observers[notification] = observersForNotification + [observer]
    }
    
    public func remove(_ observer: MyObserver, for notification: String) {
        var observersForNotification = self.observers[notification, default: []]
        if let indexToRemove = observersForNotification.firstIndex(where: { $0 === observer }) {
            observersForNotification.remove(at: indexToRemove)
            self.observers[notification] = observersForNotification
        }
    }
    
    public func post(_ notification: String) {
        self.observers[notification]?.forEach { $0.receive(notification) }
    }
}
