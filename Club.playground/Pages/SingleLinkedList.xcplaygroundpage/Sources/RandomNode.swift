import Foundation

// Grab Random Node
//
// Given a linked list, write a function to get a random node within it.
// Let's assume you're given a random node generator.
// The linked list will have at least 2 nodes, and may look something like this: 1 -> 2 -> 3 -> 4
// The odds of getting any number between 1 and 4 inclusive should be the exactly the same.
extension SingleLinkedList where T == Int {
    private var count: Int {
        var next = head
        var count = 0
        while next != nil {
            count += 1
            next = next?.next
        }
        
        return count
    }
    
    public func getRandomNode(_ randomGenerator: (Int) -> Bool = { _ in Bool.random() }) -> Int? {
        let count = self.count
        guard count > 1 else {
            return nil
        }
        
        var number = getRandomNumber(startFromZeroAndLessThan: count, randomGenerator)
        var node = head
        while number > 0 {
            number -= 1
            node = node?.next
        }
        
        return node?.value
    }
    
    private func getRandomNumber(startFromZeroAndLessThan upper: Int, _ randomGenerator: (Int) -> Bool) -> Int {
//        Int.random(in: 0 ..< upper)
        recursivelyGetRandomNumber(in: Set(0 ..< upper), randomGenerator)
    }
    
    // Can use a threshold to escape from the recursive calls for better performance
    private func recursivelyGetRandomNumber(in numbers: Set<Int>, _ randomGenerator: (Int) -> Bool) -> Int {
        if numbers.count == 1, let first = numbers.first {
            return first
        }
        
        let next: Set<Int> = numbers.reduce([]) { result, number in
            randomGenerator(number) ? result.union([number]) : result
        }
        
        return next.count == 0
            ? recursivelyGetRandomNumber(in: numbers, randomGenerator)
            : recursivelyGetRandomNumber(in: next, randomGenerator)
    }
}
