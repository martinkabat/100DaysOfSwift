//
//  ViewController.swift
//  Project18
//
//  Created by Martin Kabát on 19.11.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("I am inside the viewDidLoad() method")
        print(1, 2, 3, 4, 5, separator: "-")
        print("Some message", terminator: "")
        
        assert(1 == 1, "Math failure")
//        assert(1 == 2, "Math failure")
        assert(myVerySlowMethod() == true, "My very slow method returned false which is very bad thing.")
        
        for i in 1...100 {
            print("Got number \(i)")
        }
    }

    func myVerySlowMethod() -> Bool {
        return true
    }
}

