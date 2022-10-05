import XCTest

// MARK: - Invalidated

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

// MARK: - Validated

enum Validated<Valid, Invalid> {
    case valid(Valid)
    case invalid([Invalid])
}

extension Validated: Equatable where Valid: Equatable, Invalid: Equatable {}

extension Validated {
    var isValid: Bool {
        guard case .valid = self else {
            return false
        }
        return true
    }
    
    func appendingInvalid(_ newInvalid: Invalid) -> Self {
        switch self {
        case .valid:
            return .invalid([newInvalid])
        case let .invalid(errors):
            return .invalid(errors + [newInvalid])
        }
    }
    
    mutating func appendInvalid(_ newInvalid: Invalid) {
        self = appendingInvalid(newInvalid)
    }
    
    func mapInvalid<NewInvalid>(_ f: (Invalid) -> NewInvalid) -> Validated<Valid, NewInvalid> {
        switch self {
        case let .valid(valid):
            return .valid(valid)
        case let .invalid(invalids):
            return .invalid(invalids.map(f))
        }
    }
}

extension Validated where Valid: RangeReplaceableCollection {
    func appendingValid(_ newValid: Valid) -> Self {
        switch self {
        case let .valid(valid):
            return .valid(valid + newValid)
        case let .invalid(invalids):
            return .invalid(invalids)
        }
    }
}

enum Invalid: Equatable {
    case notMultipleOfTwo(Int)
}

func newSum(of nums: [Int]) -> Validated<Int, Invalid> {
    var invalids: [Invalid] = []
    var result = 0
    
    for num in nums {
        if !num.isMultiple(of: 2) {
            invalids.append(.notMultipleOfTwo(num))
        }
        
        result += num
    }
    
    return invalids.isEmpty ? .valid(result) : .invalid(invalids)
}

public final class ValidatedTests: XCTestCase {
    func testNewSum() throws {
        var nums = [1, 3, 5]
        var validation = newSum(of: nums)
        XCTAssertEqual(
            validation,
            .invalid([
                .notMultipleOfTwo(1),
                .notMultipleOfTwo(3),
                .notMultipleOfTwo(5)
            ])
        )
        
        nums = [2, 4, 8]
        validation = newSum(of: nums)
        XCTAssertEqual(validation, .valid(14))
        
        nums = [2, 1, 5, 8]
        validation = newSum(of: nums)
        XCTAssertEqual(
            validation,
            .invalid([
                .notMultipleOfTwo(1),
                .notMultipleOfTwo(5)
            ])
        )
    }
}
