import UIKit

// Structs
struct Person {
    var clothes: String
    var shoes: String
    
    // Functions inside structs are called methods
    func describe() {
        print("I like wearing \(clothes) and \(shoes)")
    }
}

// memberwise initializer
let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")

print(taylor.clothes)
print(other.shoes)

var taylorCopy = taylor
taylorCopy.shoes = "flip flops"

print(taylor)
print(taylorCopy)

