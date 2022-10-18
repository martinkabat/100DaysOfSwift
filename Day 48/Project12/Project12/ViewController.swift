//
//  ViewController.swift
//  Project12
//
//  Created by Martin Kabát on 17.10.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        // Writing to UserDefauts
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseFaceID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        defaults.set("Paul Hudson", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["Name": "Martin", "Country": "CZ"]
        defaults.set(dict, forKey: "SavedDictionary")
        
        
        // Reading from UserDefaults
        let savedInteger = defaults.integer(forKey: "Age")
        let savedBoolean = defaults.bool(forKey: "UseFaceID")
        
        let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        let savedDictionary = defaults.object(forKey: "SavedDictionary") as? [String: String] ?? [String: String]()
        
        let savedArray2 = defaults.stringArray(forKey: "SavedArray")
        let savedDictionary2 = defaults.dictionary(forKey: "SavedDictionary")
    }


}

