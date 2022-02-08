import UIKit

// (1) Creating your own classes
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")
// How are classes different from structs?
// 1. Classes don't have memberwise initializer (I always have to write my own initializer)
// 2. A class can inherit properties and methods of another class
// 3. Copies of structs are unique. Copies of classes point to the same data.
// 4. Classes have methods that are called upon the end of the instance of the class. Structs don't have that.
// 5. Variable properties are free to be modified in constant classes. Not in constant structs.


// (2) Class inheritance
class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

// (3) Overriding methods
class Pes {
    func zastekej() {
        print("Haf!")
    }
}
    
class Pudl: Pes {
    override func zastekej() {
        print("Pisk!")
    }
}

let alik = Pudl()
alik.zastekej()
    

// (4) Final classes
// Disallowing to inherit from this class
final class Civava {
}


// (5) Copying objects
class Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "Justin Bieber"

print(singer.name)

// By changing property value of class instance copy it changes the value of the original property as well.
// If the Singer class is struct rather than class, the singer variable name would stay Taylor Swift.


// (6) Deinitializers
// deinit is called once the last instance of the class is destroyed.
class Person {
    var name = "John Doe"
    
    init(){
        print("\(name) is alive!")
    }
    
    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    
    deinit {
        print("\(name) is no more.")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}


// (7) Mutability
class Zpevak {
    var jmeno = "Krejci Svist" // It is possible to forbid properties of the class to change simply by changing property type from variable to constant.
}

let krejci = Zpevak()
krejci.jmeno = "Eda Silenej"
print(krejci.jmeno)
