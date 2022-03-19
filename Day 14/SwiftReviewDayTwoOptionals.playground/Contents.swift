import UIKit

// Optionals

func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}

var status = getHaterStatus(weather: "rainy")

// Optional unwrapping
if let unwrappedStatus = status {
    // unwrappedStatus contains a non-optional string
} else {
    // in case you want an else block, here you go...
}

func takeHaterAction(status: String) {
    if status == "Hate" {
        print("Hating")
    }
}

if let haterStatus = getHaterStatus(weather: "rainy") {
    takeHaterAction(status: haterStatus)
}


func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008}
    return nil
}


var items = ["James", "John", "Sally"]

func position(of string: String, in array: [String]) -> Int? {
    for i in 0..<array.count {
        if array[i] == string {
            return i
        }
     }
    
    return nil
}

let jamesPosition = position(of: "James", in: items)
let johnPosition = position(of: "John", in: items)
let sallyPosition = position(of: "Sally", in: items)
let bobPosition = position(of: "Bob", in: items)


// Force unwrapping
func yearAlbumRel(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008}
    return nil
}

var year = yearAlbumRel(name: "Taylor Swift")

if year == nil {
    print("There was an error")
} else {
    print("It was released in \(year!)")
}


// Implicitly unwrapping
var name: String = "Paul"
var name2: String? = "Bob"
var name3: String! = "Sophie" // implicitly unwrapping
