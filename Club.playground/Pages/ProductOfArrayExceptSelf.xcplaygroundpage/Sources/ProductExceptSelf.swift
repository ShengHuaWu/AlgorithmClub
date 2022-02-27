import Foundation

// Given an integer array `nums`,
// return an array `answer`
// such that `answer[i]` is equal to the product of all the elements of nums except `nums[i]`.
// The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
// Must write an algorithm that runs in O(n) time and without using the division operation.

extension Array where Element == Int {
    public func productExceptSelf() -> [Element] {
        guard self.count > 1 else {
            return []
        }
        
        let productOfAll = self.reduce(1, *)
        
        guard productOfAll == 0 else {
            return self.map { productOfAll / $0 }
        }
        
        guard self.containOnceOnly(0) else {
            return Array(repeating: 0, count: self.count)
        }
        
        let productExceptZero = self.reduce(1) { result, element in
            return element == 0 ? result : result * element
        }
        
        return self.map { $0 == 0 ? productExceptZero : 0 }
    }
}

extension Array where Element == Int {
    private func containOnceOnly(_ element: Element) -> Bool {
        var count = 0
        
        for index in self.indices {
            if self[index] == element {
                count += 1
            }
        }
        
        return count == 1
    }
}
