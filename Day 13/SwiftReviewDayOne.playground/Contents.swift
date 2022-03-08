import UIKit

// (1) Variables and Constants
var name = "Martin Kabat"
name = "Tony Stark"


// (2) Types of data
var jmeno: String
jmeno = "Indiana Jones"

var age: Int
age = 25

var latitude: Double
latitude = 36.166667

var longitude: Float
longitude = -213.783333

// Double has much more accuracy than Float

var stayOutTooLate: Bool
stayOutTooLate = true

var nothingInBrain: Bool
nothingInBrain = true

var missABeat = false

// Type inference - Swift understands what data type do we mean


// (3) Operators
var a = 10
a = a + 1
a = a - 1
a = a * a

var b = 10
b += 10
b -= 10

var c = 1.1
var d = 2.2
var e = c + d

var name1 = "Juliet"
var name2 = "Romeo"
var both = name2 + " and " + name1

var f = 1.1
var g = 2.2
var h = f + g

h > 3
h >= 3
c > 4
c < 4

var nome = "Cristiano Ronaldo"
name == "Cristiano Ronaldo"
name != "Cristiano Ronaldo"

var stayOutLate = true
stayOutLate
!stayOutLate


// (4) String interpolation
var nejm = "Bil Gejts"
"Your name is \(nejm)"
"Your name is " + nejm // not as efficient
"Your name is \(nejm), your age is \(age) and your latitude is \(latitude)"
"Your age is \(age), in two years you will be \(age + 2)"


// (5) Arrays
var evenNumbers = [2, 4, 6, 8]
var songs: [String] = ["Shake it off", "You belong with me", "Back to December"]
var songs2 = ["Paint it Black", "Slow Ride"]

songs[0]
songs[1]
songs[2]

type(of: songs) //prints type of array

var songy = songs + songs2
print(songy)


// (6) Dictionaries
var person = [
    "first": "Martin",
    "last": "Kabat",
    "language": "Swift",
    "month": "January",
    "website": "martinkabat.cz"
]
person["first"]
person["website"]


// (7) Conditional statements
var akce: String
var osoba = "hejtr"

if osoba == "hejtr" {
    akce = "hejt"
} else if osoba == "hrac" {
    akce = "hrej"
} else {
    akce = "pluj"
}

var actn: String
var stOutTooLate = true
var nthngInBrain = true

if stOutTooLate && nthngInBrain {
    actn = "cruise"
}

if !stOutTooLate && !nthngInBrain {
    actn = "cruise"
}


// (8) Loops
print("1 x 10 is \(1 * 10)")
print("2 x 10 is \(2 * 10)")
print("3 x 10 is \(3 * 10)")
print("4 x 10 is \(4 * 10)")
print("5 x 10 is \(5 * 10)")
print("6 x 10 is \(6 * 10)")
print("7 x 10 is \(7 * 10)")
print("8 x 10 is \(8 * 10)")
print("9 x 10 is \(9 * 10)")
print("10 x 10 is \(10 * 10)")

for i in 1...10 {
    print("\(i) x 10 is \(i * 10)")
}

var str = "Fakers gonna"
for _ in 1...5 {
    str += " fake"
}
print(str)

for song in songs2 {
    print("My favorite song is \(song)")
}

var lidi = ["players", "haters", "heart-breakers", "fakers"]
var aktse = ["play", "hate", "break", "fake"]
for i in 0...3 {
    print("\(lidi[i]) gonna \(aktse[i])")
}

for i in 0..<lidi.count {
    var str = "\(lidi[i]) gonna"
    
    for _ in 1...5 {
        str += " \(aktse[i])"
    }
    print(str)
}


var counter = 0
while true {
    print("Counter is now \(counter)")
    counter += 1
    
    if counter == 556 {
        break
    }
}

for song in songs {
    if song == "You belong with me" {
        continue
    }
    
    print("My favorite song is \(song)")
}


// (9) Switch case
let liveAlbums = 2

switch liveAlbums {
    case 0:
        print("You're just starting out")
    case 1:
        print("You just released iTunes Live From SoHo")
    case 2:
        print("You just released Speak Now World Tour")
    default:
        print("Have you done something new?")
}
