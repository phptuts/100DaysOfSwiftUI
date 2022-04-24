import Cocoa

func greetUser() {
    print("Hi There")
}


var greetCopy: () -> Void = greetUser

greetCopy()

let sayHello = {
    print("Hi there!")
}

sayHello()

let sayHelloTo = { ( name: String) -> String in
    return "Hi \(name)"
}

sayHelloTo("John")

func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzaane" {
        return true
    } else if name2 == "Suzaane" {
        return false
    }
    
    return name1 < name2
}
let team = ["Glorai", "Suzaane", "Piper", "Tasha"]

//let captainFirstTeam = team.sorted(by: captainFirstSorted)
//print(captainFirstTeam)

let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzaane" {
        return true
    } else if name2 == "Suzaane" {
        return false
    }
    
    return name1 < name2

})

// you don't need the types
let captainFirstTeam1 = team.sorted(by: { name1, name2 in
    if name1 == "Suzaane" {
        return true
    } else if name2 == "Suzaane" {
        return false
    }
    
    return name1 < name2

})
    
// trailing closure syntax
let captainFirstTeam2 = team.sorted{ name1, name2 in
    if name1 == "Suzaane" {
        return true
    } else if name2 == "Suzaane" {
        return false
    }
    
    return name1 < name2

}

// you can use $0 and $1 in place of parameters
let captainFirstTeam3 = team.sorted{
    if $0 == "Suzaane" {
        return true
    } else if $1 == "Suzaane" {
        return false
    }
    
    return $0 < $1

}

let sortedTeam = team.sorted()
print(sortedTeam)

let reverseTeam = team.sorted { $0 > $1 }

let tOnly = team.filter { $0.hasPrefix("T")}
print(tOnly)

let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)

func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()
    
    for _ in 0..<size {
        numbers.append(generator())
    }
    
    return numbers
}

let examples = makeArray(size: 30) { Int.random(in: 0...100_000)}
print(examples)

func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("Start First")
    first()
    print("Start Second")
    second()
    print("Start Third")
    third()
    print("End")
}

doImportantWork {
    print("This is the first work")
} second: {
    print("This is second work")
} third: {
    print("This is third work")
}

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

let finalNumbers = luckyNumbers.filter { $0 % 2 == 1 }.sorted { $0 < $1}.map{ "\($0) is a lucky number"}

finalNumbers.forEach { print($0)}

