import Foundation

// Remove duplication
//
// Given an list of hashables, remove duplications but keep the order
extension Array where Element: Hashable {
    public func removeDuplicates() -> [Element] {
        var uniques: Set<Element> = []
        
        return filter { element in
            if uniques.contains(element) {
                return false
            } else {
                uniques.insert(element)
                
                return true
            }
        }
    }
    
    // What if the list is stored on the disk and it's huge (< 10 TB),
    // remove duplications with any new order
    //
    // 1. Divide the list into small pieces which can be loaded into the memory.
    // 2. Store every pieces
    // 3. Load the first lines of the two pieces.
    //    If they are the same, then only store one into the result.
    //    If thet are NOT the same, then store both into the result.
    // 4. Repeat above the comparison between the result and the reminding pieces.
}
