import Foundation

// Rate Limit
//
// Implement a rate limit of 5 requests in 2 seconds for the `invokeEndpoint` method
struct RateLimit: Hashable {
    let customerId: String
    var count: Int
    var time: Date
}

public final class API {
    private enum Constants {
        static let maxCount = 5
        static let timeIntervalLimit: TimeInterval = 2
        
        static func fakeResponse(with customerId: String) -> String {
            "Response for \(customerId)"
        }
    }
    
    private var rateLimits: Set<RateLimit> = []
    
    public init() {}
    
    public func invokeEndpoint(_ customerId: String) -> String? {
        let current = Date()
        
        guard let rateLimitForCustomer = rateLimits.first(where: { $0.customerId == customerId }) else {
            let newRateLimitForCustomer = RateLimit(customerId: customerId, count: 1, time: current)
            rateLimits.update(with: newRateLimitForCustomer)
            
            return Constants.fakeResponse(with: customerId)
        }
        
        
        if current.timeIntervalSince(rateLimitForCustomer.time) > Constants.timeIntervalLimit {
            rateLimits.remove(rateLimitForCustomer)
            let newRateLimitForCustomer = RateLimit(customerId: customerId, count: 1, time: current)
            rateLimits.update(with: newRateLimitForCustomer)
            
            return Constants.fakeResponse(with: customerId)
        } else {
            if rateLimitForCustomer.count == Constants.maxCount {
                return nil
            } else {
                rateLimits.remove(rateLimitForCustomer)
                let newRateLimitForCustomer = RateLimit(customerId: customerId, count: rateLimitForCustomer.count + 1, time: rateLimitForCustomer.time)
                rateLimits.update(with: newRateLimitForCustomer)
                
                return Constants.fakeResponse(with: customerId)
            }
        }
    }
}
