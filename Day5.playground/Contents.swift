import Cocoa

var greeting = "Hello, playground"

let score = 85

if score > 80 {
    print("Great job!")
}

let speed = 88
let percentage = 85
let age = 18

if speed >= 88 {
    print("Where we are going we don't need roads")
}

if percentage < 85 {
    print("Sorry, you failed the test")
}

if age >= 18 {
    print("You're eligible to vote.")
}

let ourName = "Dave Lister"
let friendName = "Arnold Rimmer"

if ourName < friendName {
    print("It's \(ourName) vs \(friendName)")
}

if friendName < ourName {
    print("It's \(friendName) vs \(ourName)")
}

var numbers = [1,2,3]
numbers.append(4)

if numbers.count > 3 {
    numbers.remove(at: 0)
}

print(numbers)

let country =  "Canada"

if country == "Australia" {
    print("G'day")
}

let name = "Taylor Swift"

if name != "Anonymous" {
    print("Welcome, \(name)")
}

var username = "taylorswift13"

if username == "" {
    username = "Anonymous"
}

if username.count == 0 {
    username = "Anonymous"
}

if username.isEmpty {
    username = "Anonymous"
}

print("Welcome, \(username)")

// You have implement the comparable protocol
enum Size: Comparable {
    // smaller ones are at the beginning of the enum
    case tiny, small, medium, large
}

if Size.large > Size.tiny {
    print("True")
}

let userAge = 14
let hasPerentalConsent = true

if userAge  >= 18 || hasPerentalConsent {
    print("You can buy the game")
}

enum TransportOption {
    case airplace, helicopter, bicycle, car, escooter
}

let transport = TransportOption.airplace

if transport == .airplace || transport == .helicopter {
    print("Let's fly")
} else if transport == .bicycle {
    print("Hope there is a bike path")
} else if transport == .car {
    print("Time to get stuck in traffic")
} else {
    print("I am going to hir a scooter now!")
}

enum Forecast {
    case sun, rain, wind, snow, unknown
}

let forecast = Forecast.rain

switch forecast {
case .sun:
    print("It shoudl be a nice day")
case .rain:
    print("Pack an umbrella.")
case .wind :
    print("Wear something warm")
case .snow:
    print("School is cancelled")
case .unknown:
    print("Our forecast is broken")
}

let place = "Metropolis"

switch place {
case "Gotham":
    print("You're Batman")
case "Mega-City One":
    print("You're judge Dredd!!")
case "Wakanda":
    print("Your're Black Panther!")
default:
    print("Who are you?")
}

let hour = 23

print(hour < 12 ? "It's before noon" : "It's after noon")

let names = ["Jayne", "Kaylee", "Mal"]
let crewCount = names.isEmpty ? "No One" : "\(names.count) people"
print(crewCount)


