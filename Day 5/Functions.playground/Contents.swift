import UIKit

var greeting = "Hello, playground"

// (1) Writing functions
func printHelp() {
    let message = """
Welcome to my app!

Run this app inside a directory of images
and MyApp will resize them all into thumbnails.
"""
    
    print(message)
}

printHelp()


// (2) Accepting parameters
print("Hello, world!")

func square(number: Int) {
    print(number * number)
}

square(number: 8)


// (3) Returning value
func ctverec(number: Int) -> Int {
    return number * number
}

let result = ctverec(number: 8)
print(result)


// (4) Parameter labels
// makes functions more readable by adding a second label to a parameter (internal and external labels)
func sayHello(to name: String) {
    print("Hello, \(name)!")
}

sayHello(to: "Mark")


// (5) Omitting parameter labels
func greeting(_ person: String) {
    print("Hello, \(person)")
}

greeting("Taylor")


// (6) Default parameters
func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet("Taylor")
greet("Taylor", nicely: false)


// (7) Variadic functions
print("Haters", "gonna", "hate")

func quadrado(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

quadrado(numbers: 1, 2, 3, 4, 5)


// (8) Writing throwing functions
enum PasswordError: Error{
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}


// (9) Running throwing functions
do {
    try checkPassword("password")
    print("That password is good")
} catch {
    print("You can't use that password.")
}

// (10) inout parameters
func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)
print(myNum)
