import UIKit

// (1) Protocols
protocol Identifiable {
    var id: String { get set }
}

struct User: Identifiable {
    var id: String
}

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}


// (2) Protocol inheritance
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation {
}


// (3) Extensions
extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number = 8
number.squared()

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}


// (4) Protocol extensions
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = ["John", "Paul", "George", "Ringo"]

extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        
        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()



// (5) Protocol-oriented programming
protocol Ydentifiable {
    var id: String { get set }
    func ydentify()
}

extension Ydentifiable {
    func ydentify() {
        print("My ID is \(id)")
    }
}

struct Uzivatel: Ydentifiable {
    var id: String
}

let martin = Uzivatel(id: "martin")
martin.ydentify()
