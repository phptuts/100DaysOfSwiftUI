import Cocoa

var greeting = "Hello, playground"

let surname: String = "Lasso"

let score: Double = 0

let luckyNumber: Int = 13

let isAuthenticated: Bool = true

let albums: [String] = ["Red", "Fearless"]

let user: [String: String] = ["id": "user_id"]

let books: Set<String> = Set([
    "red",
    "blue"
])

var teams: [String] = [String]()

enum UIStyle {
    case light, dark, system
}

var style = UIStyle.light

style = .dark

let username: String

// lots of code

username = "codingwithnoah"

print(username)

// Challenge

let colors = ["red", "green", "red", "blue", "yellow", "purple", "blue"]

var colorsIn = [String]()

for color in colors {
    if !colorsIn.contains(color) {
        colorsIn.append(color)
    }
}

print("Number of items: \(colors.count) and unique items: \(colorsIn.count)")


// Easier way to get unique count
let setColor = Set(colors)

print("Number of items: \(colors.count) and unique items: \(setColor.count)")
