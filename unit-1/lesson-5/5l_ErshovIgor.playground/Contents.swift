import UIKit

enum WindowState: String{
    case open = "Открыто"
    case close = "Закрыто"
}
enum EngineState: String{
    case on = "Запущен"
    case off = "Заглушен"
}
enum Transmission: String{
    case sport = "Спортивная"
    case comfort = "Комфорт"
}
enum TrunkState: String{
    case full = "Заполнен"
    case empty = "Пустой"
}
protocol CarProtocol {
    var model: String { get }
    var year: Int { get }
    var engineState: EngineState { get set }
    var windowsState: WindowState { get set }
}
extension CarProtocol {
    mutating func changeEngineState(engineState: EngineState){
        self.engineState = engineState
    }
    mutating func chageWindowsState(windowsState: WindowState){
        self.windowsState = windowsState
    }
}
class Car: CarProtocol{
    var model: String
    var year: Int
    var engineState: EngineState = .off
    var windowsState: WindowState = .close
    init(model: String, year: Int) {
        self.model = model
        self.year = year
    }
}
class SportCar: Car, CustomStringConvertible{
    var transmission: Transmission = .sport
    var description: String{
        return "Спортивный автомобиль \(model) \(year) года выпуска. Коробка передач \(self.transmission.rawValue)"
    }
}
class TrunkCar: Car, CustomStringConvertible{
    var trunkState: TrunkState = .empty
    var description: String{
        return "Грузовик \(model) \(year) года выпуска. Грузовой отсек \(self.trunkState.rawValue)"
    }
}
var sportCar = SportCar(model: "Toyota", year: 2019)
var trunkCar = TrunkCar(model: "Volvo", year: 2003)
sportCar.changeEngineState(engineState: .on)
sportCar.transmission = .comfort
trunkCar.chageWindowsState(windowsState: .open)
trunkCar.trunkState = .full
print(sportCar)
print(trunkCar)
