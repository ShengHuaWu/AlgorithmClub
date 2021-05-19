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
private var rateLimit: [String: (Date, Int)] = [:] // This represents a storage

public struct Storage {
    public let cleanUp: () -> Void
    let get: (String) -> (Date, Int)?
    let update: (String, Date, Int) -> Void
}

extension Storage {
    static let live = Self(
        cleanUp: {
            rateLimit = [:]
        },
        get: { key in
            rateLimit[key]
        },
        update: { key, time, count in
            rateLimit[key] = (time, count)
        }
    )
}

public struct Environment {
    public let now: () -> Date
    public let storage: Storage
}

public var global = Environment(
    now: Date.init,
    storage: .live
)

struct RateLimitValidator {
    let run: (inout Date, inout Int) -> Bool // (previous, count) -> Bool
}

extension RateLimitValidator {
    static let fiveRequestsInTwoSecons = Self { previous, count in
        let current = global.now()
        guard current.timeIntervalSince(previous) <= 2 else {
            count = 1
            previous = current
            return true
        }
        
        previous = current
                
        if count < 5 {
            count += 1
            return true
        } else {
            return false
        }
    }
}

public func invokeEndpoint(_ customerId: String) -> String? {
    guard let previous = global.storage.get(customerId) else {
        global.storage.update(customerId, global.now(), 1)
        
        return customerId
    }
    
    var time = previous.0
    var count = previous.1
    let success = RateLimitValidator.fiveRequestsInTwoSecons.run(&time, &count)
    global.storage.update(customerId, time, count)
    
    return success ? customerId : nil
}
