//: [Previous](@previous)

import XCTest

final class TDD_RateLimitTests: XCTestCase {
    func testInvokeEndpointFiveTimes() {
        let customerId = "ABC"
        
        let api = TDD_API()
        
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
    }
    
    func testInvokeEndpointSixTimes() {
        let customerId = "ABC"
        
        let api = TDD_API()
        
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNil(api.invokeEndpoint(customerId))
    }
    
    func testInvokeEndpointSixTimesButExceedingTwoSeconds() {
        let delayTwoSeconds = expectation(description: #function)
        
        let customerId = "ABC"
        
        let api = TDD_API()
        
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        
        DispatchQueue(label: #function).asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(api.invokeEndpoint(customerId))
            delayTwoSeconds.fulfill()
        }
        
        wait(for: [delayTwoSeconds], timeout: 5.0)
    }
    
    func testInvokeEndpointSixTimesButExceedingTwoSecondsAndAnotherFiveTimes() {
        let delayTwoSeconds = expectation(description: #function)
        
        let customerId = "ABC"
        
        let api = TDD_API()
        
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        XCTAssertNotNil(api.invokeEndpoint(customerId))
        
        DispatchQueue(label: #function).asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(api.invokeEndpoint(customerId))
            
            XCTAssertNotNil(api.invokeEndpoint(customerId))
            XCTAssertNotNil(api.invokeEndpoint(customerId))
            XCTAssertNotNil(api.invokeEndpoint(customerId))
            XCTAssertNotNil(api.invokeEndpoint(customerId))
            XCTAssertNil(api.invokeEndpoint(customerId))
            
            delayTwoSeconds.fulfill()
        }
        
        wait(for: [delayTwoSeconds], timeout: 5.0)
    }
    
    func testInvokeEndpointFiveTimesWithTwoCustomers() {
        let customer1 = "ABC"
        let customer2 = "XYZ"
        
        let api = TDD_API()
        
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
    }
    
    func testInvokeEndpointFiveTimesForFirstCustomerButSixTimesForSecondCustomer() {
        let customer1 = "ABC"
        let customer2 = "XYZ"
        
        let api = TDD_API()
        
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNil(api.invokeEndpoint(customer2))
    }
    
    func testInvokeEndpointSixTimesWithTwoCustomers() {
        let customer1 = "ABC"
        let customer2 = "XYZ"
        
        let api = TDD_API()
        
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNil(api.invokeEndpoint(customer1))
        
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNil(api.invokeEndpoint(customer2))
    }
    
    func testInvokeEndpointSixTimesWithTwoCustomersButExceedingTwoSeconds() {
        let customer1 = "ABC"
        let customer2 = "XYZ"
        
        let api = TDD_API()
        
        let delayTwoSeconds = expectation(description: #function)
        
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        XCTAssertNotNil(api.invokeEndpoint(customer1))
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: #function)
        
        group.enter()
        queue.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(api.invokeEndpoint(customer1))
            group.leave()
        }
        
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        XCTAssertNotNil(api.invokeEndpoint(customer2))
        
        group.enter()
        queue.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(api.invokeEndpoint(customer2))
            group.leave()
        }
        
        group.notify(queue: .main) {
            delayTwoSeconds.fulfill()
        }
        
        wait(for: [delayTwoSeconds], timeout: 5.0)
    }
}

TDD_RateLimitTests.defaultTestSuite.run()

// The accept language headers is comma-separated list and it could contain spaces, for example, `"en-US, fr-CA"`.
// In addition, it could also contain non-region form, such as, `"en, fr-CA"`,
// and there could also be a wildcard tag `"*"` inside the accept language headers.
// The order of the accept language headers matters.

final class ParseAcceptLanguagesTests: XCTestCase {
    func testParseAcceptLanguagesWithFullNames() {
        let headers = "en-US, fr-CA"
        let supported = ["en-US"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US"])
    }
    
    func testParseAcceptLanguagesWithFullNamesAndTwoSupportedLanguages() {
        let headers = "en-US, fr-CA"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "fr-CA"])
    }
    
    func testParseAcceptLanguagesWithFullNamesAndTwoSupportedLanguagesButDifferentOrder() {
        let headers = "fr-CA, en-US"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["fr-CA", "en-US"])
    }
    
    func testParseAcceptLanguagesWithShortName() {
        let headers = "en, fr-CA"
        let supported = ["en-US"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US"])
    }
    
    func testParseAcceptLanguagesWithShortNameAndFullNameAndTwoSupportedLanguages() {
        let headers = "en, fr-CA"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "fr-CA"])
    }
    
    func testParseAcceptLanguagesWithFullNameAndShortNameAndTwoSupportedLanguages() {
        let headers = "en-US, fr"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "fr-CA"])
    }
    
    func testParseAcceptLanguagesWithShortNamesAndTwoSupportedLanguages() {
        let headers = "en, fr"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "fr-CA"])
    }
    
    func testParseAcceptLanguagesWithShortNamesAndTwoSupportedLanguagesButDifferentOrder() {
        let headers = "fr, en"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["fr-CA", "en-US"])
    }
    
    func testParseAcceptLanguagesWithShortNameAndTwoSupportedLanguagesOfDifferentRegions() {
        let headers = "en, fr-CA"
        let supported = ["en-US", "en-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "en-CA"])
    }
    
    func testParseAcceptLanguagesWithFullNameAndWildcard() {
        let headers = "en-US, *"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "fr-CA"])
    }
    
    func testParseAcceptLanguagesWithWildcardAndFullName() {
        let headers = "*, en-US"
        let supported = ["en-US", "fr-CA"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "fr-CA"])
    }
    
    func testParseAcceptLanguagesWithShortNameAndFullNameAndWildcard() {
        let headers = "en, fr-CA, *"
        let supported = ["en-US", "fr-CA", "de-DE"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "fr-CA", "de-DE"])
    }
    
    func testParseAcceptLanguagesWithShortNameAndFullNameAndWildcardButDifferentOrder() {
        let headers = "fr-CA, en, *"
        let supported = ["en-US", "fr-CA", "de-DE"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["fr-CA", "en-US", "de-DE"])
    }
    
    func testParseAcceptLanguagesWithShortNameAndFullNameAndWildcardTwoSupportedLanguagesOfDifferentRegions() {
        let headers = "en, fr-CA, *"
        let supported = ["en-US", "en-UK", "fr-CA", "de-DE"]
        
        let languages = parseAcceptLanguage(headers, supported)
        
        XCTAssertEqual(languages, ["en-US", "en-UK", "fr-CA", "de-DE"])
    }
}

ParseAcceptLanguagesTests.defaultTestSuite.run()

//: [Next](@next)
