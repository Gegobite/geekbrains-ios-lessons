import UIKit

// Part 1

let a: Double = 3.0
let b: Double = -14.0
let c: Double = -5.0

print(getQuadraticEquationResult(a: a, b: b, c: c))

// Part 2

let legA: Double = 3.0
let legB: Double = 4.0
print("Площадь:")
print(getArea(a: legA, b: legB))
let hypotenuse = getHypotenuse(a: legA, b: legB)
print("Гипотенуза:")
print(hypotenuse)
print("Периметр:")
print(getPerimeter(a: legA, b: legB, c: hypotenuse))

// Part 3

let startDeposit: Int = 30000
let rate: Int = 10
let term: Int = 2
print("Сумма вклада составит:")
print(getDepositAmount(startDeposit: startDeposit, rate: rate, term: term))


func getQuadraticEquationResult(a: Double, b: Double, c: Double) -> [Double]{
    var result = [Double]()
    
    let d = pow(b, 2) - 4 * a * c
    
    if (d == 0){
        result.append((-b + sqrt(d)) / (2 * a))
    }
    else if (d > 0){
        result.append((-b + sqrt(d)) / (2 * a))
        result.append((-b - sqrt(d)) / (2 * a))
    }
    
    return result
}

func getArea(a: Double, b: Double) -> Double{
    return a * b / 2
}

func getHypotenuse(a: Double, b: Double) -> Double{
    return sqrt(pow(a, 2) + pow(b, 2))
}

func getPerimeter(a: Double, b: Double, c: Double) -> Double{
    return a + b + c
}

func getDepositAmount(startDeposit: Int, rate: Int, term: Int) -> Double{
    var total = Double(startDeposit)
    
    for _ in 1...term{
        total = total + total * (Double(rate) / 100)
    }
    
    return total
}
