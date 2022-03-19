import UIKit

// Optional chaining
func albumReleased(year: Int) -> String? {
    switch year {
    case 2006: return "Taylor Swift"
    case 2008: return "Fearless"
    default: return nil
    }
}

let album = albumReleased(year: 2006)?.uppercased()
print("The album is\(album)")


// Nil coalescing operator
let alb = albumReleased(year: 2006) ?? "Unknown"
print("The album is \(alb)")
