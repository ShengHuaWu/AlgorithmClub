import Foundation

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
