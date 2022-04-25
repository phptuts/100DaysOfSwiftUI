import Cocoa

struct Album {
    let title: String
    let artist: String
    let year: Int
    
    func printSummary() {
        print("\(title) (\(year) by \(artist))")
    }
}

let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)
print(red.title)
red.printSummary()

print(wings.title)
wings.printSummary()

struct Employee {
    let name: String
    var vacationRemaining = 14
    
    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There are aren't enough days remaining.")
        }
    }
}



var archer = Employee(name: "Sterling Archer", vacationRemaining: 14)
archer.takeVacation(days: 5)
print(archer.vacationRemaining)


struct Employee2 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    var vactionRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }
        
        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}


var archer2 = Employee2(name: "Archer Sterling")

archer2.vacationTaken += 4
print(archer2.vactionRemaining)
archer2.vacationTaken += 4
print(archer2.vactionRemaining)
archer2.vactionRemaining = 5
print(archer2.vacationAllocated)

struct Game {
    var score = 0 {
        didSet {
            print("Score did change: \(score)")
        }
    }
}

struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is \(contacts)")
            print("New avlue will be: \(newValue)")
        }
        
        didSet {
            print("Ther are now \(contacts.count) contacts")
            print("Old value was: \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Joe")

struct Player {
    let name: String
    let number: Int
    
    init(name: String) {
        self.number = Int.random(in: 1...99)
        self.name = name
    }
}

let player = Player(name: "Megan")
print(player.number)
