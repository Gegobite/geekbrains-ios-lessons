import UIKit

enum Transmission{
    case drive
    case sport
}
enum luggage{
    case trunkIsFull
    case trunkIsEmpty
}
class Car{
    var model: String
    var year: Int
    init(model: String, year: Int){
        self.model = model
        self.year = year
    }
}
class Truck: Car{
    var trunk: luggage
    init(model: String, year: Int, trunk: luggage){
        self.trunk = trunk
        super.init(model: model, year: year)
    }
    func TrunkState(){
        print(trunk == .trunkIsFull ? "Кузов полон" : "Кузов пуст")
    }
}
class SportCar: Car{
    var transmission: Transmission
    init(model: String, year: Int, transmission: Transmission){
        self.transmission = transmission
        super.init(model: model, year: year)
    }
    func TransmissionState(){
        print(transmission == .drive ? "Едем в обычном режиме" : "Коробку в спорт и погнали")
    }
}
let truck = Truck(model: "Volvo", year: 2015, trunk: .trunkIsFull)
truck.TrunkState()
let car = SportCar(model: "BMW", year: 2019, transmission: .sport)
car.TransmissionState()
