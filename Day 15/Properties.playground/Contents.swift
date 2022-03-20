import UIKit

struct Person {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }
        
        didSet {
            updateUI(msg: "I just change from \(oldValue) to \(clothes)")
        }
    }
}

func updateUI(msg: String) {
    print(msg)
}

var taylor = Person(clothes: "T-shirts")
taylor.clothes = "whatever"



struct Osoba {
    var vek: Int
    
    var vekVPsichLeteh: Int {
        get {
            return vek*7
        }
    }
}

var fan = Osoba(vek: 25)
print(fan.vekVPsichLeteh)

