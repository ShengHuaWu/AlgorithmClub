import Foundation

// MARK: - Static dispatch
// Methods which cannot be overriden
// This has better performance

/*
protocol People {}

extension People {
    func greeting() {
        print("Hello World")
    }
}

struct American: People {
    func greeting() {
        print("Hello!!!")
    }
}

func staticDispatch() {
    let p1: People = American()
    let p2 = American()

    p1.greeting() // Hello World
    p2.greeting() // Hello!!!
}
*/

// MARK: - Virtual-Table dispatch
// Methods which can be overriden
// This is the default way in Swift
// Maintain the table at compile time

protocol People {
    func greeting()
}

extension People {
    func greeting() {
        print("Hello World")
    }
}

struct American: People {
    func greeting() {
        print("Hello!!!")
    }
}
    
func virtualTableDispatch() {
    let p1: People = American()
    let p2 = American()

    p1.greeting() // Hello!!!
    p2.greeting() // Hello!!!
}

// MARK: - Dynamic dispatch
// `@dynamic` in Swift
// 1. Dynamic dispatch is the default way in ObjC (e.g. method swizzling)
// 2. Maintain the table at runtime
// 3. Only use `@objc` could cause different result in ObjC and Swift
