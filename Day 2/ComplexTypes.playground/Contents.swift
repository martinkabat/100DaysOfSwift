import UIKit

var greeting = "Hello, playground"

// Arrays
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]

let secondBeatle = beatles[1]

// Sets
// like arrays but unordered and with only unique values
let colors = Set(["red", "green", "blue"])
let colorsTwo = Set([["red", "green", "blue", "green", "red"]])

// Tuples
// fixed in size, a tuple cannot be removed or added
// item type cannot be changed
// cannot read unexisting names
var name = (first: "Taylor", last: "Swift")
name.0 // gets first item
name.last // gets specific item

// Arrays vs sets vs tuples
// Tuple - keeping the order, specific and fixed collection of values
let address = (house: 250, street: "Vladislavova", city: "Pisek")
// Set - for quick search, order not important, unique values
let set = Set(["Aaron", "Abdul", "Arkham"])
// Array - order important, addig/removing important, could contain duplicate values
let pythons = ["Ted", "Tim", "Oli", "Martin"]

// Dictionaries
// Similar to arrays but we can access the value by naming the values any way we want using key
let heights = [
    "Fabrizio": 182.5,
    "Francesca": 178
]

// Dictionary default value
let favoriteIceCream = [
    "Paul": "chocolate",
    "Sophie": "vanilla",
]

favoriteIceCream["Paul"]
favoriteIceCream["Shrek", default: "Unknown"]

// Collections (arrays, sets and dictionaries are all collections because they store collections of values)

var teams = [String: String]() // creation of empty dictionary
teams["Paul"] = "red" // adding value later

var restuts = [Int]() // creation of empty erray

var words = Set<String>() // creation of empty set of strings
var numbers = Set<Int>() // creation of empty set of integers

//arrays and dictionaries can be created in the same way as sets
var scores = Dictionary<String, Int>() // empty dictionary
var restults = Array<Int>() // empty array

// Enumerations (enums)
// group of related values that makes them easier to use
let result1 = "failure"
let result2 = "failed"
let result3 = "fail"

enum Result {
    case success
    case failure
}

let result4 = Result.failure

// Enum associated values
// helps us add additional details to enums
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
    case paying(what: String, amount: Double)
}

let conversation = Activity.talking(topic: "football")

// Enum raw values
// assigning values to enums for meaning
enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
    case jupiter
}

let earth = Planet(rawValue: 2) //If not specified, cases are numbered from zero, hence earth has value of 2
//every case can have specific raw value set manually
//this would set the earth case value to 3
enum Planets: Int {
    case mercury = 1
    case venus
    case earth
    case mars
    case jupiter
}
