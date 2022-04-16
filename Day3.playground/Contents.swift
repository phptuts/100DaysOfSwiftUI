import Cocoa

var beatles = ["John", "Paul", "George", "Ringo"]
var numbers = [4, 8, 16, 23, 42]
var temperatures = [25.3, 28.2, 26.2]

beatles.append("Adrian")

print(beatles)

var scores = Array<Int>()
var altScores = [Int]()

var albums = Array<String>()
albums.append("Folklore")
albums.append("Fearless")
albums.append("Red")

print(albums.count)

albums.remove(at: 2)

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)
characters.remove(at: 3)

print(characters.contains("Lana"))
print(characters)
characters.removeAll()
print(characters)

let cities = ["London", "Tokyo", "Rome", "Budapest"]
print(cities.sorted())

let presidents = ["Bush", "Obama", "Trump", "Biden"]
let reversedPresidents = presidents.reversed()
print(reversedPresidents)

// Dictionaries
let employees = [
    "name": "Taylor Swift",
    "job" : "Singer",
    "location": "Nashville"
]

print(employees["name", default: "Unknown"])
print(employees["status", default: "Unknown"])

let hasGraduated = [
    "Eric": false,
    "Maave": true,
    "Otis": false
]

let olympics = [
    2012: "London",
    2016: "Rio de Janeiro"
]

print(olympics[2012, default: "Somewhere"])

var heights = [String: Int]()
heights["Yao Ming"] = 229
heights["Shquille O'Neal"] = 216
heights["Lebron James"] = 206

var archEnemies = [String: String]()
archEnemies["Batman"] = "Joker"
archEnemies["Superman"] = "Lex Luthor"
archEnemies["Batman"] = "Penguin"

// order does not matter
let actors = Set([
    "Denzel Washington",
    "Tom Cruise",
    "Nicholas Cage",
    "Samuel L Jackson"
])

print(actors)

var peeps = Set<String>()
peeps.insert("Ham")
peeps.insert("Sam")

print(peeps)

// Enums

enum Weekday {
//    case monday
//    case tuesday
//    case wednesday
//    case thursday
//    case friday
    case monday, tuesday, wednesday, thursday, friday
}

var day = Weekday.monday
day = .tuesday

print(day)
day = .thursday
