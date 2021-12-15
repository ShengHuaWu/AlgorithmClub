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
    // 2. Sort and remove duplicates for each small piece
    // 3. Store each small piece
    // 4. Load the first element of the two pieces A and B:
    //    If they are the same,
    //    then only store one into the result,
    //    and move to the next elements of both A and B
    //
    //    If thet are NOT the same,
    //    then only store the acending (small) one into the result,
    //    and move to the next element only of the acending one
    //
    //    If there are reminding elements of A or B, store them into the result
    // 5. Repeat above the comparison between the result and the reminding pieces.
}
