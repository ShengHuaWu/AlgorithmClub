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

// MARK: - Functional Approach
struct Conditions {
    var time: Date
    var count: Int
}

private var rateLimit: [String: Conditions] = [:] // This represents a cache

public struct Cache {
    public let cleanUp: () -> Void
    let get: (String) -> Conditions?
    let update: (String, Conditions) -> Void
}

extension Cache {
    static let live = Self(
        cleanUp: {
            rateLimit = [:]
        },
        get: { key in
            rateLimit[key]
        },
        update: { key, conditions in
            rateLimit[key] = conditions
        }
    )
}

public struct Environment {
    public let now: () -> Date
    public let cache: Cache
}

public var global = Environment(
    now: Date.init,
    cache: .live
)

struct RateLimitValidator {
    let run: (inout Conditions) -> Bool
}

extension RateLimitValidator {
    static let fiveRequestsInTwoSeconds = Self { conditions in
        let current = global.now()
        guard current.timeIntervalSince(conditions.time) <= 2 else {
            conditions = Conditions(time: current, count: 1)
            return true
        }
        
        conditions.time = current
                
        if conditions.count < 5 {
            conditions.count += 1
            return true
        } else {
            return false
        }
    }
}

public func invokeEndpoint(_ customerId: String) -> String? {
    guard var conditions = global.cache.get(customerId) else {
        global.cache.update(customerId, Conditions(time: global.now(), count: 1))
        
        return customerId
    }
    
    let success = RateLimitValidator.fiveRequestsInTwoSeconds.run(&conditions)
    global.cache.update(customerId, conditions)
    
    return success ? customerId : nil
}

// TDD Rate Limit (WIP)

public final class TDD_API {
    private var count = 0
    private var lastCallTime = Date()
    
    public init() {}
    
    public func invokeEndpoint(_ customerId: String) -> String? {
        let now = Date()
        
        if now.timeIntervalSince(lastCallTime) > 2 {
            lastCallTime = now
            count = 1
            return customerId
        } else {
            count += 1
            
            guard count < 6 else {
                return nil
            }
            
            return customerId
        }
    }
}
