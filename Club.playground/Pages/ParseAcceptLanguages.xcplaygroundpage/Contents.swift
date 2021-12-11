//: [Previous](@previous)

import XCTest

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

//ParseAcceptLanguagesTests.defaultTestSuite.run()

//: [Next](@next)
