import Foundation

// LRU Cache
//
// Least Recently Used (LRU) is a common caching strategy.
// It defines the policy to evict elements from the cache to make room for new elements when the cache is full,
// meaning it discards the least recently used items first.
public final class LRUCache<Key: Hashable, Value> {
    private let capacity: Int
    private var order: [Key] = []
    private var cache: [Key: Value] = [:]
    
    public init(capacity: Int) {
        self.capacity = capacity
    }
    
    public func set(key: Key, value: Value) {
        if !order.contains(key) {
            order.append(key)
            
            if order.count > capacity {
                let evitedKey = order.removeFirst()
                cache[evitedKey] = nil
            }
        }
        
        cache[key] = value
    }
    
    public func get(key: Key) -> Value? {
        order.removeAll { $0 == key }
        order.append(key)
        
        return cache[key]
    }
}

extension LRUCache: CustomStringConvertible where Key: CustomStringConvertible, Value: CustomStringConvertible {
    public var description: String {
        cache.description
    }
}

// MARK: - Tests

import XCTest

public final class LRUCacheTests: XCTestCase {
    func testBasics() {
        let cache = LRUCache<String, Int>(capacity: 1)
        let key = "key"
        let value = 99
        
        XCTAssertNil(cache.get(key: key))
        
        cache.set(key: key, value: value)
        
        XCTAssertEqual(cache.get(key: key), value)
        
        let anotherKey = "anotherKey"
        let anotherValue = 88
        
        cache.set(key: anotherKey, value: anotherValue)
        
        XCTAssertNil(cache.get(key: key))
        XCTAssertEqual(cache.get(key: anotherKey), anotherValue)
    }
}
