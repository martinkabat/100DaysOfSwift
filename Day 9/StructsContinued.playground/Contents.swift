import UIKit

var greeting = "Hello, playground"

// (1) Intializers
struct User {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
user.username = "Sherlock"
print(user.username)


struct Employee {
    var name: String
    var yearsActive = 0
}

extension Employee {
    init() {
        self.name = "Anonymous"
        print("Creating an anonymous employee...")
    }
}

// Creating a named employee now works
let roslin = Employee(name: "Bob Dylan")

// So does creating an anonymous employee
let anonymous = Employee()



// (2) Referring to the current instance
struct Person {
    var name: String
    
    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}


// (3) Lazy properties
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct Osoba {
    var name: String
    lazy var familyTree = FamilyTree()  // 'lazy' creates instance of the FamilyTree() struct only when it is firstly accessed in Osoba
    
    init(name: String) {
        self.name = name
    }
}

var ed = Osoba(name: "Ed")
ed.familyTree


// (4) Static properties and methods
struct Student {
    static var classSize = 0
    var name: String
    
    init(name:String) {
        self.name = name
        Student.classSize += 1
    }
}

let ned = Student(name: "Ned")
let sansa = Student(name: "Sansa")
print(Student.classSize)

struct Unwrap {
    static let appURL = "https://www.appurl.com"
    static var entropy = Int.random(in: 1...1000)

    static func getEntropy() -> Int {
        entropy += 1
        return entropy
    }
}


// (5) Access control
struct Clovek {
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My social security number is \(id)."
    }
}

let matt = Clovek(id: "12345")
print(matt.identify())
