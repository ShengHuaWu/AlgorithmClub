//: [Previous](@previous)

import Foundation

let group = DispatchGroup() // Use this to wait all possible prints finishes
let operationQueue = OperationQueue() // Use this to print in paralell

var success = true
let queue = DispatchQueue(label: "AsyncProgramming") // Use this to make modify `success` thread safe

for number in 1...10 {
    group.enter()
    operationQueue.addOperation {
        queue.async {
            if success {
                print("Task \(number)")
            }
            
            if number > 3 {
                success = false
            }
        }
        
        group.leave()
    }
}

// Must pass `queue` to keep accessing `success` thread safe,
// because we call `group.leave()` outside of `queue.async`
// In addition, `group.notify` will be called
// even though there is no `group.enter()` and `group.leave()`
group.notify(queue: queue) {
    if success {
        print("All tasks are finished")
    } else {
        print("Some task failed")
    }
}

//: [Next](@next)
