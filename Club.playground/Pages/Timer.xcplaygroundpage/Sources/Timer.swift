import Foundation

// MARK: - Protocol Approach

protocol TimerWrapperProtocol {
    func schedule(with timeInterval: TimeInterval, _ block: @escaping () -> Void)
    func invalidate()
}

final class TimerWrapper: TimerWrapperProtocol {
    private var timer: Timer?
    
    func schedule(with timeInterval: TimeInterval, _ block: @escaping () -> Void) {
        self.timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { _ in block() })
    }
    
    func invalidate() {
        self.timer?.invalidate()
        self.timer = nil
    }
}

final class ImmediateTimerWrapper: TimerWrapperProtocol {
    func schedule(with timeInterval: TimeInterval, _ block: @escaping () -> Void) {
        block()
    }
    
    func invalidate() {
        // TODO: Call count
    }
}

// MARK: - Functional Approach

public struct TimerContainer {
    public var schedule: (TimeInterval, @escaping () -> Void) -> Void
    public var invalidate: () -> Void
}

extension TimerContainer {
    public static var live: Self {
        var timer: Timer? = nil
        
        return .init(
            schedule: { interval, block in
                timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { _ in block() })
            },
            invalidate: {
                timer?.invalidate()
                timer = nil
            }
        )
    }
}

extension TimerContainer {
    public static let immediate: Self = .init(
        schedule: { _, block in block() },
        invalidate: { /* TODO: Call count */ }
    )
    
    public static func repeating(times: Int) -> Self {
        .init(
            schedule: { _, block in
                (1...times).forEach { _ in
                    block()
                }
            },
            invalidate: { }
        )
    }
}
