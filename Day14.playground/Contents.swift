import Cocoa

let opposites = ["Mario": "Wario", "Luigi": "Waluigi"]

let peachOpposite = opposites["Peach"]

let peachQuestionMark: String? = opposites["Peach"]

if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}

var username: String? = nil

if let unWrappedName = username {
    print("We got a user: \(unWrappedName)")
} else {
    print("The optional was empty.")
}

func square(number: Int) -> Int {
    number * number
}

var number: Int? = nil

if let number = number {
    print(square(number: number))
}

func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing Number")
        return
    }

    print("\(number) x \(number) = \(number * number)")
}

printSquare(of: 33)
var num: Int? = nil
printSquare(of: num)

let captains = [
    "Enterprise" : "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

let new = captains["Serenity"] ?? "N/A"

let tvsShows = ["Archer", "Babylon 5", "Ted Lasso"]

let tvShow = tvsShows.randomElement() ?? "None"

struct Book {
    let title: String
    let author: String?
}

let book = Book(title: "Beowulf", author: nil)
let author = book.author ?? "Anonymous"
print(author)

let input = ""

let numEx = Int(input) ?? 0

print(numEx)

let names = ["Arya", "Bran", "Robb", "Sansa"]

let chosen = names.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)")

struct Book2 {
    let title: String
    let author: String?
}

let book2: Book2? = nil
let author2 = book2?.author?.first?.uppercased() ?? "A"
print(author2)


enum UserError: Error {
    case badId, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("User: \(user)")
}

let user = (try? getUser(id: 23)) ?? "Anonymous"
print(user)


func randomInt(opt: [Int]?) -> Int {
    return opt?.randomElement() ?? Int.random(in: 1...100)
}

print(randomInt(opt: [33,23,434]))
print(randomInt(opt: nil))
