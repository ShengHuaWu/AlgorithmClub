import Foundation

public protocol DispatchQueueInterface {
    func sync_(_ block: () -> Void)
    func async_(_ block: @escaping () -> Void)
}

extension DispatchQueue: DispatchQueueInterface {
    public func sync_(_ block: () -> Void) {
        self.sync {
            block()
        }
    }
    
    public func async_(_ block: @escaping () -> Void) {
        self.async {
            block()
        }
    }
}
