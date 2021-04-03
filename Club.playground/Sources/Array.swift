import Foundation

// The array must be sorted before binary searching. The time complexity is O(log n).
extension Array where Element: Comparable {
    public func binarySearch(for key: Element) -> Index? {
        var start = startIndex
        var end = endIndex
        
        while start < end {
            let mid = start + (end - start) / 2
            if self[mid] == key {
                return mid
            } else if self[mid] > key {
                end = mid
            } else {
                start = mid + 1
            }
        }
        
        return nil
    }
    
    public func recursiveBinarySearch(for key: Element) -> Index? {
        return recursiveBinarySearch(for: key, with: startIndex ..< endIndex)
    }
    
    private func recursiveBinarySearch(for key: Element, with range: Range<Index>) -> Index? {
        guard range.lowerBound < range.upperBound else { return nil }
        
        let mid = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        if self[mid] == key {
            return mid
        } else if self[mid] > key {
            return recursiveBinarySearch(for: key, with: range.lowerBound ..< mid)
        } else {
            return recursiveBinarySearch(for: key, with: mid + 1 ..< range.upperBound)
        }
    }
}

// Sort the array at first. 
// Then, use two binary search to find out the left boundary and the right boundary.
extension Array where Element: Comparable {
    public func occurrence(of key: Element) -> Index {
        return rightBoundary(of: key) - leftBoundary(of: key)
    }
    
    private func rightBoundary(of key: Element) -> Index {
        var start = startIndex
        var end = endIndex
        
        while start < end {
            let mid = start + (end - start) / 2
            if self[mid] > key {
                end = mid
            } else {
                start = mid + 1
            }
        }
        
        return start
    }
    
    private func leftBoundary(of key: Element) -> Index {
        var start = startIndex
        var end = endIndex
        
        while start < end {
            let mid = start + (end - start) / 2
            if self[mid] < key {
                start = mid + 1
            } else {
                end = mid
            }
        }
        
        return start
    }
}

// Find both the maximum and minimum values contained in array 
// while minimizing the number of comparisons we can compare the items in pairs.
extension Array where Element: Comparable {
    public func minAndMax() -> (Element, Element)? {
        guard var min = first else {
            return nil
        }
        
        var copy = self
        var max = min
        
        if copy.count % 2 != 0 {
            copy.removeFirst()
        }
        
        while !copy.isEmpty {
            let pair = (copy.removeFirst(), copy.removeFirst())
            if pair.0 > pair.1 {
                max = pair.0 > max ? pair.0 : max
                min = pair.1 < min ? pair.1 : min
            } else {
                max = pair.1 > max ? pair.1 : max
                min = pair.0 < min ? pair.0 : min
            }
        }
        
        return (min, max)
    }
}

// Given an integer array, separate the non-zero elements and the zeros. 
// There are two solutions:
// 1. Use another array to store the non-zero elements and then add the zeros back.
// 2. Use a variable to record the count of the non-zero elements. 
//  If encounter an non-zero element, replace the element at index "count" with the elements.
//  Finally, all non-zero elements are shifted to the front, so "count" is the index of the first zero.
extension Array where Element == Int {
    public func shiftingZeros() -> [Element] {
        var result = [Element]()
        for element in self {
            if element != 0 {
                result.append(element)
            }
        }
        
        while result.count < count {
            result.append(0)
        }
        
        return result
    }
    
    public mutating func shiftZeros() {
        var nonZeroCount = 0
        
        for index in indices {
            if self[index] != 0 {
                self[nonZeroCount] = self[index]
                nonZeroCount += 1
            }
        }
        
        while nonZeroCount < count {
            self[nonZeroCount] = 0
            nonZeroCount += 1
        }
    }
}

// Find Sum of Two Elements in Array
// 1. Use a dictionary to store the following:
// - Key: difference between each element in the array and the sum k
// - Value: the index of each element
// - Time and space complexity are both O(n).
// 2. Sort the array at first and use two variables to track the sum of the first and the last element.
// - Time complexity depends on the sorting method. It's usually O(n log n).
extension Array where Element == Int {
    public func indices(for sum: Element) -> (Index, Index)? {
        guard !isEmpty else { return nil }
        
        var dictionary = [Element : Index]()
        for index in indices {
            if let previousIndex = dictionary[self[index]] {
                return (previousIndex, index)
            } else {
                dictionary[sum - self[index]] = index
            }
        }
        
        return nil
    }
    
    public func indicesAfterSorting(for sum: Element) -> (Index, Index)? {
        guard !isEmpty else { return nil }
        
        var min = startIndex
        var max = endIndex - 1
        while min < max {
            let temp = self[min] + self[max]
            if temp > sum {
                max -= 1
            } else if temp < sum {
                min += 1
            } else {
                return (min, max)
            }
        }
        
        return nil
    }
}

// Find Sum of Three Elements in Array
// Given an array of integers and a value,
// determine if there are any three integers in the array whose sum equals the given value.
extension Array where Element == Int {
    // Sort the array before calling this method
    private func recusivelyFindTwoElements(having sum: Int, startIndex: Int, endIndex: Int) -> (Int, Int)? {
        guard startIndex < endIndex else {
            return nil
        }
        
        let start = self[startIndex]
        let end = self[endIndex]
        
        if start + end < sum {
            return recusivelyFindTwoElements(having: sum, startIndex: startIndex + 1, endIndex: endIndex)
        } else if start + end > sum {
            return recusivelyFindTwoElements(having: sum, startIndex: startIndex, endIndex: endIndex - 1)
        } else {
            return (start, end)
        }
    }
    
    private func recusivelyFindTwoElements(having sum: Int) -> (Int, Int)? {
        sorted().recusivelyFindTwoElements(having: sum, startIndex: startIndex, endIndex: endIndex - 1)
    }
    
    private func findTwoElements(having sum: Int) -> (Int, Int)? {
        guard !isEmpty, count > 1 else {
            return nil
        }
        
        let sorted = self.sorted()
        var startIndex = sorted.startIndex
        var endIndex = sorted.endIndex - 1
        
        while startIndex < endIndex {
            let first = sorted[startIndex]
            let second = sorted[endIndex]
            if first + second < sum {
                startIndex += 1
            } else if first + second > sum {
                endIndex -= 1
            } else {
                return (first, second)
            }
        }
        
        return nil
    }
    
    public func findThreeElements(having sum: Int) -> (Int, Int, Int)? {
        guard !isEmpty, count > 2 else {
            return nil
        }
        
        for (index, first) in zip(indices, self) {
            var copy = self
            copy.remove(at: index)
            if let (second, thrid) = copy.sorted().recusivelyFindTwoElements(having: sum - first)/*.findTwoElements(having: sum - first)*/ {
                return (first, second, thrid)
            }
        }
        
        return nil
    }
}

// Find Maximum Perimeter
// Given a batch of edges, find the maximum triangle perimeter of those edges.
// 1. Sort the edges at first.
// 2. Get the largest three edges and check whether these three edges can construct a triangle or not.
// 3. If they can form a triangle, their sum is the maximum perimeter.
// 4. If they cannot form a triangle, drop the largest edge and grab the fourth large edge.
extension Array where Element == Int {
    public func maxPerimeters() -> (Element, Element, Element)? {
        guard !isEmpty else { return nil }
        
        let sortedEdges = sorted()
        var index = endIndex - 1
        while index > startIndex {
            if sortedEdges[index - 2] + sortedEdges[index - 1] > sortedEdges[index] {
                return (sortedEdges[index - 2], sortedEdges[index - 1], sortedEdges[index])
            }
            
            index += 1
        }
        
        return nil
    }
    
    public func findLargestPerimetersSum() -> Int? {
        let sortedSelf = sorted(by: >)
        var index = startIndex
        
        while index + 2 < endIndex {
            let p1 = sortedSelf[index]
            let p2 = sortedSelf[index + 1]
            let p3 = sortedSelf[index + 2]
            if p1 < p2 + p3 {
                return p1 + p2 + p3
            } else {
                index += 1
            }
        }
        
        return nil
    }
    
    public func recursiveFindLargestPerimetersSum() -> Int? {
        return sorted(by: >).recursiveFindLargestPerimetersSum(start: startIndex)
    }
    
    private func recursiveFindLargestPerimetersSum(start: Index) -> Int? {
        guard start + 2 < endIndex else { return nil }
        
        let p1 = self[start]
        let p2 = self[start + 1]
        let p3 = self[start + 2]
        if p1 < p2 + p3 {
            return p1 + p2 + p3
        } else {
            return recursiveFindLargestPerimetersSum(start: start + 1)
        }
    }
}

// Print Compression
// The array should be sorted at first.
extension Array where Element == Int {
    public func printCompressionNumbers() {
        guard !isEmpty else { return }
        
        var start = first!
        var end = start
        for number in self[1 ..< endIndex] {
            if number != end + 1 {
                printElement(from: start, to: end)
                start = number
            }
            end = number
        }
        printElement(from: start, to: end)
    }
    
    private func printElement(from start: Element, to end: Element) {
        if start == end {
            print("\(start)")
        } else {
            print("\(start) - \(end)")
        }
    }
    
    public func compress() -> [String] {
        var results = [String]()
        var start = startIndex
        var index = startIndex + 1
        
        while index < endIndex {
            if self[index] != self[index - 1] + 1 {
                let output = compressNumber(start: start, end: index)
                results.append(output)
                start = index
            }
            
            index += 1
        }
        
        if start == index {
            results.append("\(self[index])")
        } else {
            let output = compressNumber(start: start, end: index)
            results.append(output)
        }
        
        return results
    }
    
    public func recursiveCompress() -> [String] {
        return recursiveCompress(start: startIndex, end: startIndex + 1, result: [])
    }
    
    private func recursiveCompress(start: Index, end: Index, result: [String]) -> [String] {
        guard end < endIndex else {
            return result + [compressNumber(start: start, end: end)]
        }
        
        if self[end] - self[end - 1] > 1 {
            return [compressNumber(start: start, end: end)] + recursiveCompress(start: end, end: end + 1, result: result)
        } else {
            return recursiveCompress(start: start, end: end + 1, result: result)
        }
    }
    
    private func compressNumber(start: Index, end: Index) -> String {
        return self[start] == self[end - 1] ? "\(self[start])" : "\(self[start])-\(self[end - 1])"
    }
}

// Quick Sort
// The time complexity is O(n log n).
// 1. Split the array into three parts based on a pivot variable.
// 2. All the elements less than the pivot go into a new array called less. 
//  All the elements equal to the pivot go into the equal array. 
//  All elements greater than the pivot go into the greater array.
// 3. Once we have these three arrays, quick sort recursively sorts the less array 
//  and the greater array, then glues those sorted subarrays back together 
//  with the equal array to get the final result.
extension Array where Element: Comparable {
    public func quickSorting() -> [Element] {
        guard count > 1 else { return self }
        
        let pivot = self[count / 2]
        let less = filter { $0 < pivot }
        let equal = filter { $0 == pivot }
        let greater = filter { $0 > pivot }
        
        return less.quickSorting() + equal + greater.quickSorting()
    }
}

// Merge Sort
// Divide and conquer. This is NOT an in-place sort. The time complexity is O(n log n).
// 1. Split the array into two unsorted piles.
// 2. Keep splitting the resulting piles until you cannot split anymore. 
//  In the end, you will have n piles with one number in each pile.
// 3. Begin to merge the piles together by pairing them sequentially. 
//  During each merge, put the contents in sorted order.
extension Array where Element: Comparable {
    public func mergeSorting() -> [Element] {
        guard count > 1 else { return self }
        
        let mid = count / 2
        let left = Array(self[0 ..< mid]).mergeSorting()
        let right = Array(self[mid ..< count]).mergeSorting()
        
        return left.merging(with: right)
    }
    
    private func merging(with pile: [Element]) -> [Element] {
        var selfIndex = startIndex
        var pileIndex = pile.startIndex
        var results = [Element]()
        
        while selfIndex < count && pileIndex < pile.count {
            let selfElement = self[selfIndex]
            let pileElement = pile[pileIndex]
            if selfElement < pileElement {
                results.append(selfElement)
                selfIndex += 1
            } else if selfElement > pileElement {
                results.append(pileElement)
                pileIndex += 1
            } else {
                results.append(selfElement)
                selfIndex += 1
                results.append(pileElement)
                pileIndex += 1
            }
        }
        
        while selfIndex < count {
            results.append(self[selfIndex])
            selfIndex += 1
        }
        
        while pileIndex < pile.count {
            results.append(pile[pileIndex])
            pileIndex += 1
        }
        
        return results
    }
}

// Array Intersection
// Sort two arrays at first and then use the logic of merge sort to generate the intersection.
extension Array where Element: Comparable {
    public func intersecting(with pile: [Element]) -> [Element] {
        guard !isEmpty, !pile.isEmpty else { return [] }
        
        let sortedSelf = sorted()
        let sortedPile = pile.sorted()
        
        var result = [Element]()
        var index = sortedSelf.startIndex
        var pileIndex = sortedPile.startIndex
        
        while index < sortedSelf.endIndex && pileIndex < sortedPile.endIndex {
            let element = sortedSelf[index]
            let pileElement = sortedPile[pileIndex]
            
            if element == pileElement {
                result.append(element)
                index += 1
                pileIndex += 1
            } else if element < pileElement {
                index += 1
            } else {
                pileIndex += 1
            }
        }
        
        return result
    }
}

// Counting Sort
// 1. The first step is to count the total number of occurrences for each item in the array.
// 2. Tries to determine the number of elements that are placed before each element.
//  The way it works is to sum up the previous counts and store them at each index.
// 3. Each element in the original array is placed at the position defined by the output of step 2.
extension Array where Element == Int {
    public func countingSorting() -> [Element] {
        guard !isEmpty else { return [] }
        
        let maxElement = self.max() ?? 0
        
        var countArray = [Index](repeating: 0, count: Int(maxElement + 1))
        for element in self {
            countArray[element] += 1
        }
        
        for index in 1 ..< countArray.count {
            let sum = countArray[index - 1] + countArray[index]
            countArray[index] = sum
        }
        
        var sortedArray = [Element](repeating: 0, count: count)
        for element in self {
            countArray[element] -= 1
            sortedArray[countArray[element]] = element
        }
        
        return sortedArray
    }
}

// Find subset from an array of integers
//
// Split the original array into two subsets A and B:
// The intersection of A and B is empty.
// The union of A and B is the original array.
// The number of element in A should be as less as possible.
// The sum of A is greater than the sum of B.
// A should be increasing order.
// Write a function to find the subset A.
extension Array where Element == Int {
    public func findSubset() -> [Int] {
        guard let (indexOfMax, max) = findMaxAndIndex() else {
            return []
        }
        
        var reminders = self
        reminders.remove(at: indexOfMax)
        var sumOfReminders = reminders.reduce(0, +)
        var resultOfA = [max]
        var sumOfA = max
        while sumOfA < sumOfReminders {
            if let (index, maxOfReminders) = reminders.findMaxAndIndex() {
                resultOfA = [maxOfReminders] + resultOfA
                sumOfA += maxOfReminders
                sumOfReminders -= maxOfReminders
                reminders.remove(at: index)
            } else {
                break
            }
        }
        
        return resultOfA
    }
    
    private func findMaxAndIndex() -> (index: Int, max: Int)? {
        guard let first = first else {
            return nil
        }
        
        var indexOfMax = 0
        var max = first
        zip(indices, self).forEach { index, number in
            if number > max {
                indexOfMax = index
                max = number
            }
        }
        
        return (indexOfMax, max)
    }
}

// Find largest size after removal
//
// There is a n x m mesh storage and each cell is 1 x 1 size.
// We are going to remove h number of the horizontal lines and v number of the vertical lines.
// For instance, n = 3, m = 3, h = [1] and v = [2], then the result is 2.
// Write a function to find the largest size after removal.
public func findLargestSizeAfterRemoval(n: Int, m: Int, h: [Int], v: [Int]) -> Int {
    /* first thought:
     Find the largest lengh of the adjacent elements of h and v,
     and the multiplication should be the result ???
    */
    fatalError()
}

extension Array where Element == Int {
    // The array has to be sorted first
    public func findLargestLengthOfAdjacent() -> Int {
        guard var temp = first else {
            return 0
        }
        
        var largest = 1
        var count = 1
        forEach { number in
            if number - 1 == temp {
                count += 1
            } else {
                count = 1
            }
            
            largest = Swift.max(count, largest)
            temp = number
        }
        
        return largest
    }
}

// Merge Overlapping Intervals
//
// You are given an array (list) of interval pairs as input where each interval has a start and end timestamp.
// The input array is sorted by starting timestamps.
// You are required to merge overlapping intervals and return a new output array.
// Consider the input array below.
// Intervals (1, 5), (3, 7), (4, 6), (6, 8) are overlapping so they should be merged to one big interval (1, 8).
// Similarly, intervals (10, 12) and (12, 15) are also overlapping and should be merged to (10, 15).
extension Array where Element == (Int, Int) {
    public func mergeOverlapping() -> Self {
        guard let firstInterval = first else {
            return []
        }
        
        var result = [firstInterval]
        for interval in self[1...] {
            var lastInResult = result.removeLast()
            if lastInResult.1 >= interval.0 {
                lastInResult.1 = Swift.max(interval.1, lastInResult.1)
                result.append(lastInResult)
            } else {
                result.append(lastInResult)
                result.append(interval)
            }
        }
        
        return result
    }
}

// Largest Sum Subarray
//
// 1. Given an array of numbers, find the largest sum of any contiguous subarray.
// 2. Given an array of positive numbers and a positive number ‘k’, find the maximum sum of any contiguous subarray of size ‘k’.
extension Array where Element == Int {
    public func findLargestSumOfSubarray() -> Int {
        guard !isEmpty else {
            return 0
        }
        
        var currentMax = 0
        var globalMax = 0
        forEach { number in
            if currentMax <= 0 {
                currentMax = number
            } else {
                currentMax += number
            }
            
            if globalMax < currentMax {
                globalMax = currentMax
            }
        }
        
        return globalMax
    }
    
    public func findLargestSumOfSubarray(with size: Int) -> Int {
        guard count >= size else {
            return reduce(0, +)
        }
        
        return Swift.max(
            self[..<size].reduce(0, +),
            Array(dropFirst()).findLargestSumOfSubarray(with: size)
        )
    }
}

// Find All Sum Combinations
//
// Given an array of positive integers and a positive integer `target` print all possible combinations of positive integers that sum up to the `target` number.
// The array is sorted and there is no duplications
extension Array where Element == Int {
    public func findAllSumCombinations(for target: Int) -> [[Int]] {
        var results = [[Int]]()
        var temp = [Int]()
        recursivelyFindAllSumCombinations(for: target, currentSum: 0, start: 0, temp: &temp, results: &results)
        
        return results
    }
    
    private func recursivelyFindAllSumCombinations(for target: Int, currentSum: Int, start: Int, temp: inout [Int], results: inout [[Int]]) {
        guard target != currentSum else {
            results.append(temp)
            return
        }
        
        for index in start ..< count {
            let newCurrentSum = self[index] + currentSum
            if newCurrentSum <= target {
                temp.append(self[index])
                recursivelyFindAllSumCombinations(for: target, currentSum: newCurrentSum, start: index, temp: &temp, results: &results)
                temp.removeLast() // Removing the last element from list (backtracking)
            }
        }
    }
}

// Search Rotated Array
//
// Search for a given number in a sorted array, with unique elements, that has been rotated by some arbitrary number.
// Return -1 if the number does not exist.
// Assume that the array does not contain duplicates.
extension Array where Element == Int {
    public func findInRotated(key: Int) -> Int {
        recursivelyFindInRotated(key: key, start: 0, end: count - 1)
    }
    
    private func recursivelyFindInRotated(key: Int, start: Int, end: Int) -> Int {
        if start == end, self[start] == key {
            return start
        }
        
        guard start < end else {
            return -1
        }
        
        let mid = start + (end - start) / 2
        let startValue = self[start]
        let midValue = self[mid]
        let endValue = self[end]
        
        if midValue == key {
            return mid
        }
        
        if startValue < midValue, midValue > key, key >= startValue {
            return recursivelyFindInRotated(key: key, start: start, end: mid - 1)
        }
        
        if endValue > midValue, key > midValue, key <= endValue {
            return recursivelyFindInRotated(key: key, start: mid + 1, end: end)
        }
        
        if endValue < midValue {
            return recursivelyFindInRotated(key: key, start: mid + 1, end: end)
        }
        
        if startValue > midValue {
            return recursivelyFindInRotated(key: key, start: start, end: mid - 1)
        }
        
        return -1
    }
}

// Minimum distance of adjacent
//
// Integer `V` lies strickly between integer `U` and `W` if `U < V < W` or `W < V < U`.
// A non-empty array `A` consisting of `N` integers is given.
// A pair of indices (`P`, `Q`), where `0 <= P < Q < N` is said to have adjacent values if no value in the array lies strickly between values `A[P]` and `A[Q]`.
// For example, in array `A` such as
// ```
// [0, 3, 3, 7, 5, 3, 11, 1]
// ```
// Indices 4 and 5 have adjacent values because there is no value in `A` that lies strickly between `A[4] = 5` and `A[5] = 3`;
// the only such value could be the number 4, and it's not presented in the array.
// Given two indices `P` and `Q`, their distance is defined as `abs(A[P] - A[Q])`.
// Write a function that, given a non-empty array `A` consisting of `N` integers,
// returns the minimum distance between indices of this array that have adjacent values.
// The function should return `-1` if the minimum distance if greater than 100,000,000.
// The function should return `-2` if no adjacent indices exist.
// For instance, given the array `A` as shown above the function should return 0.
extension Array where Element == Int {
    public func findMinimumDistanceBetweenAdjacent() -> Int {
        guard count >= 2 else {
            return -2
        }
        
        let sortedCopy = sorted()
        var minDistance = Int.max
        sortedCopy.indices[1...].forEach { index in
            let distance = sortedCopy[index] - sortedCopy[index - 1]
            minDistance = Swift.min(minDistance, distance)
        }
        
        return minDistance > 100_000_000 ? -1 : minDistance
    }
}

// Maximum waiting time for cars in fuel station
//
// There is a queue of `N` cars waiting at a filling station.
// There are three dispensers at the station, labeled `X`, `Y`, and `Z`, respectively.
// Each dispenser has some finite amount of fuel in it; all times the amount of available fuel is clearly displayed on each dispenser.
// When a car arrives at the front of the queue, the driver can choose to drive to any dispenser not occupied by another car.
// Suppose the fule demand is `D` liters of this car.
// The driver must choose the dispenser which has at least `D` liters of fuel.
// If all unoccupied dispensers have less than `D` liters, the driver must wait for some other car to finish tanking up.
// If all dispensers are unoccupied and none has at least `D` liters, the driver is unable to refuel the car and it blocks the queue indefinitely.
// If more than one unoccupied dispensers have at least `D` liters, the driver chooses the one that labeled with the smallest letter among them.
// Each driver will have to wait some amount of time before he or she starts refueling the car.
// Calculate the maximum waiting time among all drivers.
// Assume that tanking one liter of fuel takes exactly one second, and moving cars is instantaneous.
// Write a function that, given an array `A` consisting of `N` integers (which specify the fuel demands in liters for subsequence cars in the queue),
// and number `X`, `Y`, and `Z` (which specify the initial amount of fuel in the respective dispensers),
// returns the maximum waiting time for a car.
// If any car is unable to refuel, the function should return `-1`.
// For example, given `X = 7`, `Y = 11`, `Z = 3` and the following array `A`
// ```
// [2, 8, 4, 3, 2]
// ```
// The function should return 8.
extension Array where Element == Int {
    public func findMaximumWaitingTime(xRemainingGas: Int, yRemainingGas: Int, zRemainingGas: Int) -> Int {
        var xRemain = xRemainingGas
        var yRemain = yRemainingGas
        var zRemain = zRemainingGas
        
        var waitingTime = 0
        var currentCarIndex = startIndex
        
        var xOccupied = 0
        var yOccupied = 0
        var zOccupied = 0
        
        while currentCarIndex < endIndex {
            let currentCar = self[currentCarIndex]
            let xEnough = xRemain >= currentCar
            let yEnough = yRemain >= currentCar
            let zEnough = zRemain >= currentCar
            
            if !xEnough, !yEnough, !zEnough {
                return -1
            }
            
            let xPossible = xEnough && xOccupied <= 0
            let yPossible = yEnough && yOccupied <= 0
            let zPossible = zEnough && zOccupied <= 0
            
            if xPossible {
                xOccupied = currentCar
                xRemain -= currentCar
                currentCarIndex += 1
            } else if yPossible {
                yOccupied = currentCar
                yRemain -= currentCar
                currentCarIndex += 1
            } else if zPossible {
                zOccupied = currentCar
                zRemain -= currentCar
                currentCarIndex += 1
            } else {
                var minWaitingTime = xOccupied > 0 ? xOccupied : Int.max
                minWaitingTime = yOccupied > 0 ? Swift.min(minWaitingTime, yOccupied) : minWaitingTime
                minWaitingTime = zOccupied > 0 ? Swift.min(minWaitingTime, zOccupied) : minWaitingTime
                
                waitingTime += minWaitingTime
                
                xOccupied -= minWaitingTime
                yOccupied -= minWaitingTime
                zOccupied -= minWaitingTime
                
                // Not increase the current car index because of waiting
            }
        }
        
        return waitingTime
    }
}

// Treats Distribution
//
// Say we are given an integer array of an even length, where different numbers in the array represent certain kinds of snacks or treats.
// Each number represents, one kind of snack.
// So the following array would have two kinds: snack type 3 and type 2: `[3, 3, 2, 2]`.
// You need to distribute these snacks equally in number to a brother and sister.
// Write a function to return the maximum number of unique kinds of snacks the sister could gain.
extension Array where Element == Int {
    public func treatsDistribution() -> Int {
        let uniqueSnacks = Set(self)
        let countDividedBy2 = count / 2
        if uniqueSnacks.count < countDividedBy2 {
            return uniqueSnacks.count
        } else {
            return countDividedBy2
        }
    }
}

// Find Kth Largest Element
//
// Design a function to efficiently find the Kth largest element in an integer array.
extension Array where Element == Int {
    public func findKthLargest(_ k: Int) -> Int? {
        guard !isEmpty else {
            return nil
        }
        
        if k > count {
            return sorted().first
        } else {
            return sorted(by: >)[k - 1]
        }
    }
}

// Find Kth Closest Numbers
//
// Given a sorted number array and two integers ‘K’ and ‘X’, find ‘K’ closest numbers to ‘X’ in the array.
// Return the numbers in the sorted order. ‘X’ is not necessarily present in the array.
extension Array where Element == Int {
    public func findKthClosestAnotherWay(_ k: Int, to key: Int) -> [Int] {
        guard count > k, !isEmpty else {
            return self
        }
                
        // Find the closest index with binary search
        var start = startIndex
        var end = endIndex
        var closestIndex = start
        while start < end {
            closestIndex = start + (end - start) / 2
            let value = self[closestIndex]
            if value == key {
                break
            } else if value > key {
                end = closestIndex
            } else {
                start = closestIndex + 1
            }
        }
        
        // Choose before and after of the closest
        var before = closestIndex
        var after = closestIndex
        while after - before + 1 < k {
            if before == 0 {
                after += 1
                continue
            }
            
            if after == count - 1 {
                before -= 1
                continue
            }
            
            let beforeValue = self[before]
            let afterValue = self[after]
            let beforeDiff = abs(key - beforeValue)
            let afterDiff = abs(key - afterValue)
            if beforeDiff == afterDiff {
                before -= 1
                after += 1
            } else if beforeDiff < afterDiff {
                before -= 1
            } else {
                after += 1
            }
        }
        
        // If the diffs of the last step are the same, excluding after
        if after - before + 1 > k {
            after -= 1
        }
        
        return Array(self[before ... after])
    }
    
    public func findKthClosest(_ k: Int, to key: Int) -> [Int] {
        guard count > k else {
            return self
        }
        
        var differences: [Int: [Int]] = [:]
        for number in self {
            let diff = abs(key - number)
            if let numbersWithDiff = differences[diff] {
                differences[diff] = numbersWithDiff + [number]
            } else {
                differences[diff] = [number]
            }
        }
        
        var diff = 0
        var results: [Int] = []
        while results.count < k {
            if let numbersWithDiff = differences[diff] {
                results.append(contentsOf: numbersWithDiff)
            }
            
            diff += 1
        }
        
        return Array(results[...(k-1)]).sorted()
    }
}
