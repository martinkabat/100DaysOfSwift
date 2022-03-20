import UIKit
import Foundation

struct TaylorFan {
    static var favoriteSong = "Look what you made me do"
    
    var name: String
    var age: Int
}

let fan = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)
