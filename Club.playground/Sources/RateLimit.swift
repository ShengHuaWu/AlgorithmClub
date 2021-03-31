import Foundation

// Rate Limit
//
// Implement a rate limit of 5 requests in 2 seconds for the `invokeEndpoint` method
public final class API {
    private enum Constants {
        static let maxCount = 5
        static let timeIntervalLimit: TimeInterval = 2
        
        static func fakeResponse(with customerId: String) -> String {
            "Response for \(customerId)"
        }
    }
    
    private var rateCount: [String: Int] = [:]
    private var rateTimes: [String: [Date]] = [:]
    
    public init() {}
    
    // TODO: Using two dictionaries is error prone. Consider merge count and times in one new type.
    public func invokeEndpoint(_ customerId: String) -> String? {
        let current = Date()
        
        guard let times = rateTimes[customerId], let firstInvokeTime = times.first else {
            rateTimes[customerId] = [current]
            rateCount[customerId] = 1
            
            return Constants.fakeResponse(with: customerId)
        }
        
        if current.timeIntervalSince(firstInvokeTime) > Constants.timeIntervalLimit {
            rateTimes[customerId] = [current]
            rateCount[customerId] = 1
            
            return Constants.fakeResponse(with: customerId)
        } else {
            rateTimes[customerId] = times + [current]
            
            guard let count = rateCount[customerId] else {
                rateCount[customerId] = 1
                
                return Constants.fakeResponse(with: customerId)
            }
                        
            if count == Constants.maxCount {
                return nil
            } else {
                rateCount[customerId] = count + 1
                
                return Constants.fakeResponse(with: customerId)
            }
        }
    }
}
