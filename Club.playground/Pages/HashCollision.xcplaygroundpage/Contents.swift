//: [Previous](@previous)

import XCTest

struct MyHash: Hashable {
    let value1: Int
    let value2: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value1 + value2)
    }
}

final class HashCollisionTests: XCTestCase {
    func testHashCollision() {
        let h1 = MyHash(value1: 2, value2: 3)
        let h2 = MyHash(value1: 3, value2: 2)
        
        XCTAssertEqual(h1.hashValue, h2.hashValue)
        XCTAssertFalse(h1 == h2)
        
        let dictionary = [
            h1: 1,
            h2: 2
        ]
        
        // `Dictionary` uses `Equtable` to determine the key
        XCTAssertFalse(dictionary[h1] == dictionary[h2])
    }
}

HashCollisionTests.defaultTestSuite.run()

//: [Next](@next)
