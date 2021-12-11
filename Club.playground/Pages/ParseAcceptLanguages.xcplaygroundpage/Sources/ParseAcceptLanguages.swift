import Foundation

// Parse Accept Language
//
// The accept language headers is comma-separated list and it could contain spaces, for example, `"en-US, fr-CA"`.
// In addition, it could also contain non-region form, such as, `"en, fr-CA"`,
// and there could also be a wildcard tag `"*"` inside the accept language headers.
// The order of the accept language headers matters.
public func parseAcceptLanguage(_ acceptLanguageHeaders: String, _ supportedLanguages: [String]) -> [String] {
    return acceptLanguageHeaders
        .split(separator: ",")
        .map { $0.replacingOccurrences(of: " ", with: "") }
        .reduce([]) { result, acceptLanguage in
            return result + supportedLanguages.filter { language in
                language.hasPrefix(acceptLanguage) || acceptLanguage == "*" // `*` is wildcard
            }
        }
        .removeDuplicates()
}

extension Array where Element == String {
    func removeDuplicates() -> Self {
        var set = Set<String>()
        
        return filter { element in
            if set.contains(element) {
                return false
            } else {
                set.insert(element)
                return true
            }
        }
    }
}
