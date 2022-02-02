import UIKit

var greeting = "Hello, playground"

// (1) Creating basic closures
let driving = {
    print("I'm driving in my car.")
}

driving()


// (2) Accepting parameters in a closure
let rizeni = {
    (place: String) in
    print("I'm going to \(place) in my car.")
}

rizeni("London")


// (3) Returning values from a closure
let drivingWithReturn = {
    (place: String) -> String in
    return "I'm going to \(place) in my car"
}

let message = drivingWithReturn("London")


// (4) Closures as parameters
func travel(action:() -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel(action: driving)


// (5) Trailing closure syntax
travel {
    print("I'm driving in my car.")
}
