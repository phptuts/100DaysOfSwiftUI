import Cocoa

func printTimesTable(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTable(for: 5, end: 20)
printTimesTable(for: 8)

var characters = ["Lana", "Pam", "Ray"]
print(characters.count)
characters.removeAll(keepingCapacity: true)
print(characters.count)


enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }
    if password == "12345" {
        throw PasswordError.obvious
        
    }
    
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

let string = "12345"

do {
    let result = try checkPassword(string)
    print("Password Result: \(result)")
} catch PasswordError.short {
    print("Password too short")
} catch PasswordError.obvious {
    print("Password obvious")
} catch {
    print("There was an error.", error)
}


enum SquareRootErrors: Error {
    case outOfBounds, noRoot
}

func squareRoot(_ num: Int) throws -> Int {
    if num < 1 || num > 1000 {
        throw SquareRootErrors.outOfBounds
    }
    
    for i in 1...10000 {
        if i * i == num {
            return i
        } else if i * i > num {
            break
        }
    }
    
    throw SquareRootErrors.noRoot
}

do {
    let squareRoot9 = try squareRoot(9)

    print("square root of 9 = \(squareRoot9)")

    let squareRoot81 = try squareRoot(81)

    print("square root of 81 = \(squareRoot81)")

} catch {
    print("not working")
}

do {
     try squareRoot(0)
} catch {
    print(error)
}

do {
     try squareRoot(10001)
} catch {
    print(error)
}


do {
     try squareRoot(50)
} catch {
    print(error)
}
