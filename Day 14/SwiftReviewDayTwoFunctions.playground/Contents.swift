import UIKit

func favoriteAlbum(_ name: String) {
    print("My favorite album is \(name)")
}

favoriteAlbum("Sam's Town")


func printAlbumRelease(name: String, year: Int) {
    print("\(name) was released in \(year)")
}


func countLettersInString(in string: String) {
    print("The string \(string) has \(string.count) letters.")
}

countLettersInString(in: "Hello")


func albumIsTaylors(name: String) -> Bool {
    if name == "Taylor Swift" {return true}
    if name == "Fearles" {return true}
    return false
}

if albumIsTaylors(name: "Taylor Swift") {
    print("That's one of hers!")
} else {
    print("Who made that?")
}

if albumIsTaylors(name: "The White Album") {
    print("That's one of hers")
} else {
    print("Who made that?")
}
