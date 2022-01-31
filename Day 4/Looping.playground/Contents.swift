import UIKit

var greeting = "Hello, playground"

// (1) For loops
let count = 1...10

for number in count {
    print("Number is \(number)")
}

let albums = ["Red", "1989", "Reputation"]

for album in albums {
    print("\(album) is on Apple Music")
}

print("Players gonna ")

for _ in 1...5 {
    print("play")
}

// (2) While loops
var number = 1

while number <= 20 {
    print(number)
    number += 1
}

print("Ready or not, here I come.")

var cats: Int = 0
while cats < 10 {
    cats += 1
    print("I'm getting another cat.")
    
    if cats == 4 {
        print("Enough cats!")
        cats = 10
    }
}

var numero: Int = 10
while numero > 0 {
    numero -= 2
    if numero % 2 == 0 {
        print("\(numero) is an even number.")
    }
}

// (3) Repeat loops
repeat {
    print(number)
    number += 1
} while number <= 20

print("Ready or not, here I come!")

while false {
    print("This is false")
}

repeat {
    print("This is false")
} while false

// (4) Exiting loops
var countDown = 10

while countDown >= 0 {
    print(countDown)
    countDown -= 1
    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }
}

// (5) Exiting multiple loops
// it is possible to add label to the loop like this 'whateverName:' before loop and then break the multiple loop from the inner loop by naming what we are breaking from
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}

// (6) Skipping items
for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    print(i)
}

// (7) Infinite loops
var counter = 0

while true {
    print(" ")
    counter += 1
    
    if counter == 273 {
        break
    }
}
