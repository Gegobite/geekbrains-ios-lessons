import UIKit

extension String: Error {}

enum EngineState {
    case start, stop
}

enum WindowState {
    case open, close
}

enum TrunkState {
    case load, unload
}

struct SportCar {
    let model : String
    let year : Int
    private var _volume : Int = 0
    var volume : Int {
        get { return _volume }
    }
    private let maxVolume : Int = 100
    var engineState : EngineState {
        willSet {
            print(newValue == .start ? "Engine starts" : "Engine stops")
        }
    }
    var windowState : WindowState {
        willSet {
            print(newValue == .open ? "Windows are opening" : "Windows are closing")
        }
    }
    
    init(model : String, year : Int){
        self.model = model
        self.year = year
        self.engineState = .stop
        self.windowState = .close
    }
    
    public var description: String {
        return "Автомобиль: \(self.model)\n" +
        "Год выпуска: \(self.year)\n" +
        "Объем багажника: \(self.volume)"
    }
    
    mutating func SetTrunkState(_ newVolume : Int, _ state : TrunkState) throws {
        switch state {
        case .load:
            if (self._volume + newVolume > maxVolume){
                throw "Значение больше допустимого"
            }
            print("Загружаем багажник")
            self._volume = self._volume + newVolume
        default:
            if (self._volume - newVolume < 0){
                throw "Значение больше допустимого"
            }
            print("Разгружаем багажник")
            self._volume = self._volume - newVolume
        }
        print("Объем: \(self.volume)")
    }
}

struct Truck {
    let model : String
    let year : Int
    private var _volume : Int = 0
    var volume : Int {
        get { return _volume }
    }
    private let maxVolume : Int = 1000
    var engineState : EngineState {
        willSet {
            print(newValue == .start ? "Engine starts" : "Engine stops")
        }
    }
    var windowState : WindowState {
        willSet {
            print(newValue == .open ? "Windows are opening" : "Windows are closing")
        }
    }
    
    init(model : String, year : Int){
        self.model = model
        self.year = year
        self.engineState = .stop
        self.windowState = .close
    }
    
    public var description: String {
        return "Грузовик: \(self.model)\n" +
        "Год выпуска: \(self.year)\n" +
        "Объем кузова: \(self.volume)"
    }
    
    mutating func SetTrunkState(_ newVolume : Int, _ state : TrunkState) throws {
        switch state {
        case .load:
            if (self._volume + newVolume > maxVolume){
                throw "Значение больше допустимого"
            }
            print("Загружаем кузов")
            self._volume = self._volume + newVolume
        default:
            if (self._volume - newVolume < 0){
                throw "Значение больше допустимого"
            }
            print("Разгружаем кузов")
            self._volume = self._volume - newVolume
        }
        
        print("Объем: \(self.volume)")
    }
}

var car = SportCar(model: "Toyota", year: 2015)
car.engineState = .start
car.windowState = .open
try car.SetTrunkState(20, .load)
try car.SetTrunkState(40, .load)
try car.SetTrunkState(15, .unload)

print(car.description)

var truck = Truck(model: "Volvo", year: 2010)
truck.engineState = .start
truck.windowState = .open
try truck.SetTrunkState(200, .load)
try truck.SetTrunkState(400, .load)
try truck.SetTrunkState(150, .unload)

print(truck.description)
