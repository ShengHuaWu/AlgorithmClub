import Foundation

// Rate Limit
//
// Implement a rate limit of 5 requests in 2 seconds for the `invokeEndpoint` method

public final class TDD_API {
    private typealias CustomerId = String
    
    private struct Condition {
        var count = 0
        var lastCallTime = Date()
    }
    
    private var conditionOfCustomers: [CustomerId: Condition] = [:]
    private let queue = DispatchQueue(label: "API")
    
    public init() {}
    
    public func invokeEndpoint(_ customerId: String) -> String? {
        self.queue.sync {
            let now = Date()
            var condition = conditionOfCustomers[customerId, default: Condition()]
            
            if now.timeIntervalSince(condition.lastCallTime) > 2 {
                condition.lastCallTime = now
                condition.count = 1
                
                conditionOfCustomers[customerId] = condition
                
                return customerId
            } else {
                condition.count += 1
                conditionOfCustomers[customerId] = condition
                
                guard condition.count < 6 else {
                    return nil
                }
                
                return customerId
            }
        }
    }
}
