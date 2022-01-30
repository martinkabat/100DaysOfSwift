import UIKit

var greeting = "Hello, playground"

// (1) Arithmetic operators
let firstScore = 13
let secondScore = 4

let total = firstScore + secondScore
let difference = firstScore - secondScore
let product = firstScore * secondScore
let divided = firstScore / secondScore
let remainder = firstScore % secondScore

// remainder (modulo)
let daysUntilEvent = 465
let weeks = daysUntilEvent / 7
let remainingDays = daysUntilEvent % 7
print("There are \(weeks) weeks and \(remainingDays) days until the event.")

// how to check whether the number is divided without a remainder
let isMultiple = daysUntilEvent.isMultiple(of: 7)


// (2) Operator overloading
let meaningOfLife = 42
let doubleMeaning = 42 + 42

let fakers = "Fakers gonna "
let action = fakers + "fake"

let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

// (3) Compound assignment operators
var score = 95
score -= 5

var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"

// (4) Comparison operators
firstScore == secondScore
firstScore != secondScore
firstScore > secondScore
firstScore < secondScore

// (5) Conditions
let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}

// (6) Combining conditions
let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18.")
}

if age1 > 18 || age2 > 18{
    print("One of them is over 18.")
}

// (7) Ternary operator
let firstCard = 11
let secondCard = 10

print(firstCard == secondCard ? "Cards are the same" : "Cards are different")

if firstCard == secondCard {
    "Cards are the same"
} else {
    "Cards are different"
}

// (8) Switch statements
let weather = "sunny"

switch weather {
    case "rain":
        print("Bring an umbrella")
    case "snow":
        print("Wrap up warm")
    case "sunny":
        print("Wear sunscreen")
        fallthrough // in case we want to code to continue executing in the following case
    default:
        print("Enjoy your day!")
}

// (9) Range operators

let points = 85
switch points {
    case 0..<50:
        print("You failed badly.")
    case 50..<85:
        print("You did OK.")
    default:
        print("You did great!")
}
