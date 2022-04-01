import Foundation

// Detect Typo
//
// Given a domain string `domain`, detect whether there is a typo in the input string
// 1. Only one character different, for example, `domein` or `donain` but not `donein`
// 2. Only one character different with keyboard layout,
//    for example, `domsin` but not `domein` because `s` is closed to `a`
// 3. One character more or less, for example, `doqmain` or `doman`

private let domain = "domain"
private let domainKeyboardLayout: [Character: Set<Character>] = [
    "d": ["s", "e", "f", "c"],
    "o": ["i", "l", "p"],
    "m": ["n", "k", ","],
    "a": ["q", "s", "z"],
    "i": ["u", "k", "o"],
    "n": ["b", "j", "m"]
]

public enum TypoError: Error {
    case lengthMismatch
    case oneCharDiff
    case moreCharsDiff
    case notEqual
}

extension String {
    public func detectOneCharDiff() -> Result<String, TypoError> {
        guard self.count == domain.count else {
            return .failure(.lengthMismatch)
        }
        
        var index = self.startIndex
        var difference = 0
        
        while index < self.endIndex {
            if domain[index] != self[index] {
                difference += 1
            }
            
            index = self.index(after: index)
        }
        
        if difference == 0 {
            return .success(self)
        } else {
            return difference == 1 ? .failure(.oneCharDiff) : .failure(.moreCharsDiff)
        }
    }
    
    public func detectOneCharDiffAtKeyboard() -> Result<String, TypoError> {
        guard self.count == domain.count else {
            return .failure(.lengthMismatch)
        }
        
        var index = self.startIndex
        var layoutDifference = 0
        var difference = 0
        
        while index < self.endIndex {
            defer { index = self.index(after: index) }
            
            let char = self[index]
            let domainChar = domain[index]
            if char == domainChar {
                continue
            }
            
            guard let keyboardLayout = domainKeyboardLayout[domainChar] else {
                assertionFailure("Unable to obtain domain keyboard layout")
                break
            }
            
            if keyboardLayout.contains(char) {
                layoutDifference += 1
            } else {
                difference += 1
            }
        }
        
        if layoutDifference == 0 && difference == 0 {
            return .success(self)
        } else if difference == 0 {
            return layoutDifference == 1 ? .failure(.oneCharDiff) : .failure(.moreCharsDiff)
        } else {
            return .failure(.notEqual)
        }
    }
}
