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
        order.insert(key, at: 0)
        
        return cache[key]
    }
}

extension LRUCache: CustomStringConvertible where Key: CustomStringConvertible, Value: CustomStringConvertible {
    public var description: String {
        cache.description
    }
}
