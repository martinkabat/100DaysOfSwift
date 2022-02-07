import UIKit

var greeting = "Hello, playground"

// (1) Creating structs

struct Sport {
    var name: String
}

var tennis = Sport(name: "Tennis")
print(tennis)

tennis.name = "Lawn tennis"


// (2) Computed properties
struct SportWithComputedProperty {
    var name: String
    var isOlympicSport: Bool

    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport."
        } else {
            return "\(name) is not an Olympic sport."
        }
    }
}


let chessBoxing = SportWithComputedProperty(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)


// (3) Property observers
struct Progress {
    var task: String
    var amount: Int {
        didSet{
            print("\(task) is now \(amount)% complete.")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100


// (4) Methods
struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()


// (5) Mutating methods
struct Person {
    var name: String
    
    mutating func makeAnonymous(){
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()
print(person.name)


// (6) Properties and methods of strings
let string = "Do or do not, there is no try."
print(string.count)
print(string.hasPrefix("Do"))
print(string.uppercased())
print(string.sorted())
print(string.count)
print(string.hasPrefix("Hello"))
print(string.lowercased())


// (7) Properties and methods of arrays
var toys = ["Woody"]
print(toys.count)

toys.append("Buzz")
toys.firstIndex(of: "Buzz")

print(toys.sorted())
toys.remove(at: 0)

var myEmptyString = ""

if myEmptyString.isEmpty {
    print("It sure is empty.")
}else {
    print("Nope, it's not empty.")
}
