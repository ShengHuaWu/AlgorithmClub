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
        .flatMap { supportedLanguages.filter(for: $0) }
        .removeDuplicates()
}

extension Array where Element == String {
    func filter(for acceptLanguage: String) -> Self {
        return filter { language in
            language.hasPrefix(acceptLanguage) || acceptLanguage == "*" // `*` means wildcard
        }
    }
    
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
