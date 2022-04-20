import Cocoa

var greeting = "Hello, playground"

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for os in platforms {
    print("Swift works great on \(os).")
}

for i in 1...12 {
    print("5 x \(i) = \(5 * i)")
}

for i in 1...12 {
    print("The \(i) times table")
    
    for j in 1...12 {
        print("   \(j) x \(i) = \(j * i)")
    }
    print()
}

for i in 1...5 {
    print("Counting from 1 to 5: \(i)")
}

for i in 1..<5 {
    print("Counting from 1 up to 5: \(i)")
}

var lyric = "Haters gonna"
for _ in 1...5 {
    lyric += " hate"
}

print(lyric)

var countdown = 10

while countdown > 0 {
    print("\(countdown)")
    countdown -= 1
}

print("Blastoff")

let id = Int.random(in: 1...1000)

let amount = Double.random(in: 0...1)

var roll = 0

while roll != 20 {
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}
print("hit")

var counter = 2
while counter < 64 {
    print("\(counter) is a power of 2.")
    counter *= 2
}

let filenames = ["me.jpg", "food.txt", "blue.jpg"]

for file in filenames {
    if !file.hasSuffix(file) {
        continue
    }
    
    print("Found picture \(file)")
}


var number1 = 4
var number2 = 14
var multiples = [Int]()

for i in 1...100_000 {
    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiples.append(i)
        if multiples.count == 10 {
            break
        }
    }
}

print(multiples)

// Challenge

for i in 1...100 {
    if i.isMultiple(of: 3) && i.isMultiple(of: 5) {
        print("FizzBuzz")
    } else if i.isMultiple(of: 3) {
        print("Fizz")
    } else if i.isMultiple(of: 5) {
        print("Buzz")
    } else {
        print(i)
    }
}
