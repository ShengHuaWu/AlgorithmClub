import Foundation

// Power of a Number
//
// Given a double, ‘x’, and an integer, ‘n’, write a function to calculate ‘x’ raised to the power ‘n’. For example:
func power(_ x: Double, _ n: Int) -> Double {
    if n == 0 {
        return 1
    }
    
    if n == 1 {
        return x
    }
    
    let temp = power(x, n / 2)
    if n % 2 == 0 {
        return temp * temp // For instance, 2^8 = 2^4 * 2^4
    } else {
        return x * temp * temp // For instance, 2^9 = 2 * 2^4 * 2^4
    }
}
