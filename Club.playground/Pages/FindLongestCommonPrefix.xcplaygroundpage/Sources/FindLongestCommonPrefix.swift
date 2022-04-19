import Foundation

// Write a function to find the longest common prefix string amongst an array of strings.
// If there is no common prefix, return an empty string "".

extension Array where Element == String {
    // The time complexity of this solution might be O(N log N + M),
    // where N is the number of strings and M is the max length of a string
    public func getLongestCommonPrefix() -> String {
        guard !self.isEmpty else {
            return ""
        }
        
        guard self.count > 1 else {
            return self.first!
        }
        
        // Use a dictionary to store the strings having the same first character
        var alphabets: [Character: [String]] = [
            "a": [],
            "b": [],
            "c": []
            // TODO: d-z
        ]
        
        for str in self {
            if str.hasPrefix("a") {
                let list = alphabets["a", default: []]
                alphabets["a"] = list + [str]
            } else if str.hasPrefix("b") {
                let list = alphabets["b", default: []]
                alphabets["b"] = list + [str]
            } else if str.hasPrefix("c") {
                let list = alphabets["c", default: []]
                alphabets["c"] = list + [str]
            } else {
                // TODO: d-z
            }
        }
        
        var result = ""
        
        for (_, list) in alphabets {
            let sorted = list.sorted()
            // After sorting, we just need to check the first and the last strings
            guard sorted.count > 1 else {
                continue
            }
            
            let first = sorted.first!
            let last = sorted.last!
            var temp = ""
            
            for index in first.indices {
                guard first[index] == last[index] else {
                    break
                }
                
                let char = first[index]
                temp.append(char)
            }
            
            if temp.count > result.count {
                result = temp
            }            
        }
        
        return result
    }
}
