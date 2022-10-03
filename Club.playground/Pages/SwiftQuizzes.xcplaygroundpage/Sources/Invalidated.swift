import XCTest

struct Invalidated<Origin, Reason>: Error {
    let origin: Origin
    let reasons: [Reason]
}

extension Invalidated: Equatable where Origin: Equatable, Reason: Equatable {}

extension Invalidated {
    func makeNew(with newReason: Reason) -> Self {
        .init(origin: origin, reasons: reasons + [newReason])
    }
}

enum Reason: Error, Equatable {
    case notMultipleOfTwo(Int)
}

func sum(of nums: [Int]) -> Result<Int, Invalidated<[Int], Reason>> {
    var invalidated = Invalidated<[Int], Reason>(origin: nums, reasons: [])
    var result = 0
    
    for num in nums {
        if !num.isMultiple(of: 2) {
            invalidated = invalidated.makeNew(with: .notMultipleOfTwo(num))
        }
        
        result += num
    }
    
    return invalidated.reasons.isEmpty ? .success(result) : .failure(invalidated)
}

public final class InvalidatedTests: XCTestCase {
    func testSum() throws {
        var nums = [1, 3, 5]
        var result = sum(of: nums)
        XCTAssertThrowsError(try result.get()) { error in
            XCTAssertEqual(
                error as? Invalidated<[Int], Reason>,
                .init(
                    origin: nums,
                    reasons: [
                        .notMultipleOfTwo(1),
                        .notMultipleOfTwo(3),
                        .notMultipleOfTwo(5)
                    ]
                )
            )
        }
        
        nums = [2, 4, 8]
        result = sum(of: nums)
        XCTAssertEqual(try result.get(), 14)
        
        nums = [2, 1, 5, 8]
        result = sum(of: nums)
        XCTAssertThrowsError(try result.get()) { error in
            XCTAssertEqual(
                error as? Invalidated<[Int], Reason>,
                .init(
                    origin: nums,
                    reasons: [
                        .notMultipleOfTwo(1),
                        .notMultipleOfTwo(5)
                    ]
                )
            )
        }
    }
}
