import Cocoa

var gameOver = true
print(gameOver)
gameOver.toggle()
print(gameOver)
gameOver = !gameOver
print(gameOver)

let firstPart = "Hello, "
let secondPart = "World"

let total = firstPart + secondPart

let people = "Haters"
let action = "hate"

// this makes a temp strings
// Haters gonna
// Haters gonna hate
let lyric = people + " gonna " + action

// string interpolation aka putting variables in strings

//let name = "Taylor"
//let age = 26
//let message = "Hello, my name is \(name) and I am \(age) years old."
//print(message)

// you write swift code in the ()
print("5 x 5 = \(5 * 5)")

// Checkpoint 1
let celcius = 23.0
let fahrenheit = celcius * (9 / 5) + 32

print("Celcius = \(celcius) and Fahrenheit = \(fahrenheit)")

let age = 36
let name = "Noah G"
let message = "Hi, my name \(name) and I am \(age) and \(age * 7) in dog years"
print(message)
