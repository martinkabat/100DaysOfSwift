import UIKit

// Challenge! (Day 81)
// 1. Create a String extension that adds a withPrefix() method. If the string already contains the prefix it should return itself; if it doesn’t contain the prefix, it should return itself with the prefix added. For example: "pet".withPrefix("car") should return “carpet”.

extension String {
    func withPrefix(_ prefix: String) -> String {
        return self.hasPrefix(prefix) ? self : String("\(prefix)\(self)")
    }
}
let testString = "test"
print(testString.withPrefix("pre"))

let pretestString = "pretest"
print(pretestString.withPrefix("pre"))


// 2. Create a String extension that adds an isNumeric property that returns true if the string holds any sort of number. Tip: creating a Double from a String is a failable initializer.
extension String {
    var isNumeric: Bool {
        let characterSet = CharacterSet.decimalDigits
        return self.rangeOfCharacter(from: characterSet) != nil
    }
}

let text4 = "text4"
print(text4.isNumeric)

let plainText = "plaintext"
print(plainText.isNumeric)


// 3. Create a String extension that adds a lines property that returns an array of all the lines in a string. So, “this\nis\na\ntest” should return an array with four elements.

extension String {
    var lines: [String] {
        return self.components(separatedBy: "\n")
    }
}

let linedText = "this\nis\na\ntest"
print(linedText.lines)



