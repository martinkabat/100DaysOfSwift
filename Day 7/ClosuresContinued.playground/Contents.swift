import UIKit

var greeting = "Hello, playground"

// (1) Using closures as parameters when they accept parameters
func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travel{
    (place: String) in
    print("I'm going to \(place) in my car.")
}

// (2) Using closures as parameters when they return value
func trevl(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

trevl{ (place: String) -> String in
    return "I'm going to \(place) in my car."
}

// When would you use closures with return values as parameters to a function?
func reduce(_ values: [Int], using closure: (Int, Int) -> Int) -> Int {
    // start with a total equal to the first value
    var current = values[0]
    
    // loop over all the values in the array, counting from index 1 onwards
    for value in values[1...] {
        // call our closure with the current value and the array element
        current = closure(current, value)
    }
    
    // send back the final current value
    return current
}

let numbers = [10, 20, 30]
 
let sum = reduce(numbers) {
    (runningTotal: Int, next: Int) in
    runningTotal + next
}

print(sum)

let suma = reduce(numbers, using: +)


// (3) Shorthand parameter names

// This must be addressed.
func trvl(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}
// How did this:
trvl { (place: String) -> String in
    return "I'm going to \(place) in my car."
}

// Become this:
// (Swift knows that closure parameter must be String so we can ommit that.)
trvl { place -> String in
    return "I'm going to \(place) in my car."
}

// Become this:
// (Swift knows that closure return must be String so we can ommit that.)
trvl { place in
    return "I'm going to \(place) in my car."
}

// Become this:
// (Only one line of code must be the return line of the code.)
trvl { place in
    "I'm going to \(place) in my car."
}

// Become this:
// (Switchin 'place in' for the automatic name in Swift.)
trvl {
    "I'm going to \($0) in my car."
}
