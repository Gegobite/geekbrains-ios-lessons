import UIKit

// Part 1
print(isEven(3))

// Part 2
print(isEvenlyDivisibleByThree(9))

// Part 3
var list = makeList(100)
print(list)

// Part 4
list = list.filter(){ !isEven($0) && isEvenlyDivisibleByThree($0) }
print(list)

// Part 5
var fibonacciList = getFibonacciList(100)
print(fibonacciList)

// Part 6
var primeNumbersList = getPrimeNumbersList(arrayPassed: Array(1...100))
print(primeNumbersList)

// проверка на четность
func isEven(_ number: Int) -> Bool{
   // return number % 2 == 0
    return isEvenlyDivisibleByValue(number: number, value: 2)
}

// проверка на деление на 3 без остатка
func isEvenlyDivisibleByThree(_ number: Int) -> Bool{
    return isEvenlyDivisibleByValue(number: number, value: 3)
}

// проверка на деление без оставка
func isEvenlyDivisibleByValue(number: Int, value: Int) -> Bool{
    return number % value == 0
}

// генерация массива
func makeList(_ n: Int) -> [Int] {
    let list = (0..<n).map{ _ in Int(arc4random_uniform(100)) }
    return list.sorted()
}

// Генерация массива чисел фибоначчи
func getFibonacciList(_ n: Int) -> [Double] {
    var list: [Double] = [1, 1]
    (2...n).forEach{ i in
        list.append(list[i - 1] + list[i - 2])
    }
    return list
}

// Генерация массива простых чисел
func getPrimeNumbersList(arrayPassed: [Int]) -> [Int] {
    var primes: [Int] = []
    var newArr = arrayPassed
    while let newP = newArr.first {
        primes.append(newP)
        newArr = newArr.filter { $0 % newP != 0 }
    }
    return primes
}
 
