import Foundation

public protocol DispatchQueueInterface {
    func async_(_ block: @escaping () -> Void)
}

extension DispatchQueue: DispatchQueueInterface {
    public func async_(_ block: @escaping () -> Void) {
        self.async {
            block()
        }
    }
}
