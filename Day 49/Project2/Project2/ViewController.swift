//
//  ViewController.swift
//  Project2
//
//  Created by TwoStraws on 13/08/2016.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var highScore = Int() {
        didSet {
            navigationItem.rightBarButtonItem?.title = "High score: \(String(highScore))"
        }
    }

	override func viewDidLoad() {
		super.viewDidLoad()

		button1.layer.borderWidth = 1
		button2.layer.borderWidth = 1
		button3.layer.borderWidth = 1

		button1.layer.borderColor = UIColor.lightGray.cgColor
		button2.layer.borderColor = UIColor.lightGray.cgColor
		button3.layer.borderColor = UIColor.lightGray.cgColor
        
        let defaults = UserDefaults.standard
        highScore = defaults.object(forKey: "highScore") as? Int ?? Int()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "High score: \(String(highScore))", style: .plain, target: nil, action: nil)

		countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
		askQuestion()
        
	}

	func askQuestion(action: UIAlertAction! = nil) {
		countries.shuffle()

		button1.setImage(UIImage(named: countries[0]), for: .normal)
		button2.setImage(UIImage(named: countries[1]), for: .normal)
		button3.setImage(UIImage(named: countries[2]), for: .normal)

        correctAnswer = Int.random(in: 0...2)
		title = countries[correctAnswer].uppercased()
	}

	@IBAction func buttonTapped(_ sender: UIButton) {
		var title: String

		if sender.tag == correctAnswer {
			title = "Correct"
			score += 1
            if score > highScore {
                highScore = score
                let defaults = UserDefaults.standard
                defaults.set(highScore, forKey: "highScore")
                
                let ac = UIAlertController(title: "You are the best", message: "You set the new high score of \(String(highScore))!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Go on", style: .default))
                present(ac, animated: true)
            }
		} else {
			title = "Wrong"
			score -= 1
		}

		let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
		present(ac, animated: true)
	}

}
