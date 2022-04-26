import Cocoa

struct BankAccount {
    private(set) var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var ajAccount = BankAccount()

ajAccount.deposit(amount: 100)
ajAccount.withdraw(amount: 20)
print(ajAccount.funds)

struct School {
    static var studentCount = 0
    
    static func add(student: String) {
        print("\(student) join the school")
        studentCount += 1
    }
}

School.add(student: "Talyor Swift")
print(School.studentCount)

struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}

AppData.version

struct Employee {
    let username: String
    let password: String
    
    static let example = Employee(username: "cfederighi", password: "secret")
}

struct Car {
    let model: String
    let seats: Int
    private(set) var gears: Int
    
    mutating func changeGear(gear: Int) -> Bool {
        if gear > 0 || gear <= 10 {
            self.gears = gear
            return true
        }
        
        return false
    }
}

var honda = Car(model: "Honda", seats: 4, gears: 3)
print("\(honda.model) is in \(honda.gears)")
print(honda.changeGear(gear: 100))
print("\(honda.model) is in \(honda.gears)")
print(honda.changeGear(gear: 9))
print("\(honda.model) is in \(honda.gears)")
