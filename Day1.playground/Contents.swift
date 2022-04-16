import Cocoa

var example = "red"
example = "blue"

let character = "Daphne"

var playerName = "Roy"
print(playerName)

playerName = "Danny"
print(playerName)

playerName = "Sam"
print(playerName)

let managerName = "Micheal Scott"
let dogBreed = "Samoyed"
let meaningOfLife = "How many roads must a man walk down"

let quotesInString = "\"quotes\""

let movie = """
Multiple lines
strings work
works
"""

// prints the number characters
print(movie.count)

// uppercased all the characters
print(dogBreed.uppercased())

// hasPrefix returns true if "How many" is at the beginning of meaningOfLife variable
print(meaningOfLife.hasPrefix("How many"))

let score = 10

// _ break up a number to make it easier to read
let reallyBig = 100_000_000
let lowerScore = score - 2
let higherScore = score + 10
let doubleScore = score * 2

var counter = 10
counter += 5
counter -= 10
counter *= 2

let number = 120
print(number.isMultiple(of: 3))

print(120.isMultiple(of: 3))

let decimal = 0.2 + 0.1

print(decimal)

let a = 1
let b = 2.0
let c = a + Int(b)

