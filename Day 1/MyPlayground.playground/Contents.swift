import UIKit

var greeting = "Hello, playground" // String variable
var age = 38 // Integer variable
var population = 8_000_000 // Integer variable
var saying = "Two went and the middle one fell." // <- Type inference (type to variable is assigned automatically based on what we put in it.)

// Multiline string variable
var multiline = """
This
is
SPARTA!!!
"""

// Multiline string variable without line breaks
var multilineNeat = """
This \
is \
SPARTA!
"""

// Variable of type Double
var pi = 3.1415

// Variable of type Boolean
var awesome = true

// String interpolation
var score = 87
var str = "The score was \(score)"
var results = "The results were following: \(str)"

// Constants
let taylor = "swift"
//taylor = "lautner" <- this would cause an error

// Type annotations
var name: String = "Martin" // <- explicit type (the opposite of the type inference)
var size: Int = 24
var height: Double = 182.5
var married: Bool = true
