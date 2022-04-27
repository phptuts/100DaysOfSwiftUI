import Cocoa
import Foundation

var greeting = "Hello, playground"

class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()

newGame.score += 10

class Employee {
    let hours: Int
    
    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("I work \(hours) a day.")
    }
}

final class Developer: Employee {
    func work() {
        print("I'm writing for \(hours) hours.")
    }
    
    override func printSummary() {
        print("I'm a developer who will sometimes work hours a day, but other times will spend hours arguing wether code will use tabs or spaces.")
    }
}

final class Manager: Employee {
    func work() {
        print("I'm going to meetinsgs for \(hours) hours")
    }
}

let robert = Developer(hours: 8)
let joseph = Developer(hours: 10)
robert.work()
joseph.work()

let novall = Developer(hours: 8)
novall.printSummary()

class Vehicle {
    let isElectric: Bool
    
    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool
    
    init(isConvertible: Bool, isElectric: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

let telsaX = Car(isConvertible: false, isElectric: true)

class User {
    var username = "Anonymous"
    
    func copy() -> User {
        let user = User()
        user.username = self.username
        return user
    }
}

var user1 = User()
var user3 = user1.copy()
var user2 = user1
user1.username = "Taylor"
print(user2.username)
print(user3.username)

class UserD {
    let id: Int
    
    init(id: Int) {
        self.id = id
        print("User \(id): I am alive")
    }
    
    deinit {
        print("Usre \(id): I am dead")
    }
}

var users = [UserD]()

for i in 1...3 {
    let user = UserD(id: i)
    print("User \(user.id): I am in control")
    users.append(user)
}

print("Loop is Finish")
users.removeAll()
print("Array is cleared")

class UserE {
    var name = "Paul"
}

let user = UserE()
user.name = "Talyor"
print(user.name)


class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    
    init() {
        super.init(legs: 4)
    }
    
    func speak() {
        print("woof")
    }
}

class Cat: Animal {
    let isTame: Bool
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
    
    func speak() {
        print("meow")
    }
}

class Lion: Cat {
    
    init() {
        super.init(isTame: false)
    }
    
    
    override func speak() {
        print("ROAR!!")
    }
}


class Persian: Cat {
    
    init() {
        super.init(isTame: true)
    }
    
    override func speak() {
        print("meow meow")
    }
}


class Corgi: Dog {
    override func speak() {
        print("woofy")
    }
}

class Poodle: Dog {
    override func speak() {
        print("mr woof")
    }
}

let poodle = Poodle()
poodle.speak()
let corgi = Corgi()
corgi.speak()
let lion = Lion()
lion.speak()
let persian = Persian()
persian.speak()
