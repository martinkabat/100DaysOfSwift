import UIKit

// Challenge! (Day 82)
// 1. Extend UIView so that it has a bounceOut(duration:) method that uses animation to scale its size down to 0.0001 over a specified number of seconds.
extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        })
    }
}

let view = UIView()
view.bounceOut(duration: 5)


// 2. Extend Int with a times() method that runs a closure as many times as the number is high. For example, 5.times { print("Hello!") } will print “Hello” five times.

extension Int {
    func times(_ closure: () -> Void) {
        if(self < 1) {
            print("number is less than one")
        }
        for _ in 0..<self {
            closure()
        }
    }
}

5.times {
    print("Hello!")
}


// 3. Extend Array so that it has a mutating remove(item:) method. If the item exists more than once, it should remove only the first instance it finds. Tip: you will need to add the Comparable constraint to make this work!
extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let location = firstIndex(of: item) {
            self.remove(at: location)
        }
    }
}

var items = ["this", "is", "a", "test"]
items.remove(item: "is")
print(items)
