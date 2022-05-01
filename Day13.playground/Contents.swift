import Cocoa

protocol Vehicle {
    var name: String { get }
    var currentPassenger: Int { get set }
    func estimatedTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct Car: Vehicle {
    
    var currentPassenger = 1
    
    let name = "Car"
    
    func estimatedTime(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distance: Int) {
        print("I'm driving \(distance)km")
    }
    
    func openSunroof() {
        print("It's a nice day")
    }
}

protocol CanBeElectric {
    
}

struct Bicycle: Vehicle, CanBeElectric {
    
    let name = "bike"
    
    var currentPassenger = 1
    
    func estimatedTime(for distance: Int) -> Int {
        distance / 10
    }
    
    func travel(distance: Int) {
        print("I am cycling \(distance)km.")
    }
}

func commute(distance: Int,  using vehicle: Vehicle) {
    if vehicle.estimatedTime(for: distance) > 100 {
        print("That's too slow, I will try another vehicle")
    } else {
        vehicle.travel(distance: distance)
    }
}

func getTravellerEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimatedTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}

let car = Car()
commute(distance: 100, using: car)

let bike = Bicycle()
commute(distance: 100, using: bike)

getTravellerEstimates(using: [car, bike], distance: 150)


func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

extension String {
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    mutating func trim() {
        self = self.trimmed()
    }
    
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}

print(getRandomNumber() == getRandomNumber())

let num = getRandomNumber()

var quote = "  The truth is rarely pure and never simple"

let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)
let trimmed2 = quote.trimmed()

let lyrics = """
But I keep crusing
Can't stop, won't stop moving
It's like I got thsi music
"""
lyrics.lines.count

struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int

    
}

extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

let lotr = Book(title: "Lord of the right", pageCount: 30, readingHours: 25)
extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

let guests = ["Mario", "Luigi", "Peach"]

if guests.isNotEmpty {
    print("Guest Count: \(guests.count)")
}

protocol Person {
    var name: String { get}
    func sayHello()
}

extension Person {
    func sayHello() {
        print("Hi, I am \(name)")
    }
}

struct Employee: Person {
    
    let name: String
}

let taylor = Employee(name: "Rob")
taylor.sayHello()

protocol Building {
    var rooms: Int { get }
    var cost: Int { get set}
    var agent: String { get set}
    
    func summary() -> String
}

struct House: Building {
    let rooms: Int
    
    var cost: Int
    
    var agent: String
    
    func summary() -> String {
     return   """
Home cost $\(cost)
Rooms: \(rooms)
Agent: \(agent)
"""
    }
}

struct Office: Building {
    let rooms: Int
    
    var cost: Int
    
    var agent: String
    
    func summary() -> String {
return """
Office Costs: $\(cost)
Rooms: \(rooms)
Agent: \(agent)
"""
    }
}


let office = Office(rooms: 4, cost: 30000, agent: "Adams")
let house = House(rooms: 4, cost: 300200, agent: "Sarah")

let buildings: [Building] = [office, house]

buildings.forEach {
    print($0.summary())
}

