import Foundation
import XCTest

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

// MARK: - Tests

public final class MaximumWaitingTimeTests: XCTestCase {
    func testFindMaximumWaitingTime() {
        XCTAssertEqual([2, 8, 4, 3, 2].findMaximumWaitingTime(xRemainingGas: 7, yRemainingGas: 11, zRemainingGas: 3), 8)
    }
}
