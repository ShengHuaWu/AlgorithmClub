import Foundation

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
