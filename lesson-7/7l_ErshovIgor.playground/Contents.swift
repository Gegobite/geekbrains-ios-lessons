import UIKit

enum CashMashineError : Error {
    case noCardInserted
    case insufficientFunds
    case incorrectPin
    case notActiveCard
}

extension Date {
    static func from(_ year: Int, _ month: Int, _ day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
}

class Card {
    let expirationDate: Date
    var balance: Decimal
    var cardHolder: String
    var isActive: Bool
    var pin: String
    
    init(cardHolder: String, balance: Decimal, expirationDate: Date, pin: String){
        self.cardHolder = cardHolder
        self.balance = balance
        self.expirationDate = expirationDate
        self.pin = pin
        self.isActive = true
    }
}

class CashMachine {
    private var card: Card?
    private var isPinPassed: Bool = false
    
    public func insertCard(_ card: Card){
        self.card = card;
        print("Card inserted")
    }
    
    public func passPinCode(_ pin: String) throws{
        try checkCardInserting()
        guard card?.pin == pin else {
            card = nil
            print("Card removed")
            throw CashMashineError.incorrectPin
        }
        self.isPinPassed = true
        print("Pin passed")
    }
    
    public func printBalance() throws {
        try checkCardInserting()
        try checkCardFields()
        print("Your Balance: \(card!.balance)")
    }
    
    public func getMoney(_ amount: Decimal) throws{
        try checkCardInserting()
        try checkCardFields()
        let expBalance = card!.balance - amount
        guard expBalance >= 0 else {
            throw CashMashineError.insufficientFunds
        }
        
        card!.balance = expBalance
        print("Getted \(amount)")
    }
    
    public func insertMoney(_ amount: Decimal) throws {
        try checkCardInserting()
        try checkCardFields()
        
        card!.balance += amount
        print("Inserted \(amount)")
    }
    
    private func checkCardInserting() throws {
        guard card != nil else {
            throw CashMashineError.noCardInserted
        }
    }
    
    private func checkCardFields() throws {
        guard self.isPinPassed else {
            throw CashMashineError.incorrectPin
        }
        
        guard card!.isActive && card!.expirationDate > Date() else{
            throw CashMashineError.notActiveCard
        }
    }
}

func safeRun(_ throwsFunc: () throws -> ()){
    do{
        try throwsFunc()
    }
    catch CashMashineError.noCardInserted {
        print ("Не вставлена карта")
    }
    catch CashMashineError.incorrectPin {
        print ("Некорректный пин-код")
    }
    catch CashMashineError.insufficientFunds {
        print ("Недостаточно средств")
    }
    catch CashMashineError.notActiveCard {
        print ("Карта заблокирована")
    }
    catch let error {
        print(error.localizedDescription)
    }
}

var card = Card(cardHolder: "Ivanov Ivan", balance: 250000, expirationDate: Date.from(2020, 09, 19)!, pin: "6666")
var cashMachine = CashMachine()
safeRun { try cashMachine.printBalance() }
cashMachine.insertCard(card)
safeRun { try cashMachine.printBalance() }
safeRun { try cashMachine.getMoney(2456) }
safeRun { try cashMachine.passPinCode("6666") }

safeRun { try cashMachine.printBalance() }
safeRun { try cashMachine.getMoney(2456) }
safeRun { try cashMachine.getMoney(300000) }
safeRun { try cashMachine.insertMoney(500000) }
