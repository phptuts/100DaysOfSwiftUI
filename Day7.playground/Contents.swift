import Cocoa

func showWelcome() {
    print("Welcome to my app!")
    print("By default This prints out a conversion")
    print("chart from centimeters to inches, but you")
    print("can also set a custom range if you want.")
}

showWelcome()


func printTimesTable(number: Int, end: Int)  {
    for i in 1...end {
        print("\(i) * \(number) = \(number * i)")
    }
}

printTimesTable(number: 3, end: 20)

// returning values

let root = sqrt(169)

print(root)

func rollDice() -> Int {
    return Int.random(in: 1...6)
}

let result = rollDice()
print(result)

// omit return if your function has only one line of code
func compareStrings(a: String, b: String) -> Bool {
    a.sorted() == b.sorted()
}

compareStrings(a: "red", b: "der")
compareStrings(a: "sed", b: "der")


func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

let c = pythagoras(a: 3, b: 4)
print(c)

func sayHello() {
    return
}

func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Talyor", lastName: "Swift")
}

func getUser2() -> (firstName: String, lastName: String) {
    ( "Talyor", "Swift")
}

func getUser3() -> (String, String) {
    ( "Talyor", "Swift")
}

let user2 = getUser2()
let user3 = getUser3()

print("\(user3.0)")
print("\(user2.firstName)")

let (firstName, lastName) = getUser3()
print(firstName, lastName)

//

func hireEmployee(name: String) { }
func hireEmployee(title: String) { }


let lyric = "I see a red door and I want to paint it black"
print(lyric.hasPrefix("I see"))


func isUppperCased(_ string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLD"
let isUp = isUppperCased(string)

print(isUp)

// external name goes first
// internal name goes last
func printTimesTablev2(for number: Int) {
    for i in 1...12 {
        print("\(i) * \(number) is \(number * i)")
    }
}

printTimesTablev2(for: 3)


func randomIntArray() -> [Int] {
  var items = [Int]()
  for _ in 1...Int.random(in: 200...2000) {
    items.append(Int.random(in:1...20000))
  }
  return items
}
func payFor(_ item: String) {
   print("You are paying for \(item)")
}


// creating a tuple
let person = (name: "Red", age: 33)
let (name, age) = person
// returning a tuple
// We can exclude name and age in the return becasue of the return type
func createAnimal() -> (name: String, age: Int) {
   return ("Z", 33)
}
