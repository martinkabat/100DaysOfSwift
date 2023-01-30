//
//  ViewController.swift
//  Project2
//
//  Created by TwoStraws on 13/08/2016.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
	@IBOutlet var button1: UIButton!
	@IBOutlet var button2: UIButton!
	@IBOutlet var button3: UIButton!

	var countries = [String]()
	var correctAnswer = 0
	var score = 0

	override func viewDidLoad() {
		super.viewDidLoad()
        
        registerLocal()
        scheduleLocal()

		button1.layer.borderWidth = 1
		button2.layer.borderWidth = 1
		button3.layer.borderWidth = 1

		button1.layer.borderColor = UIColor.lightGray.cgColor
		button2.layer.borderColor = UIColor.lightGray.cgColor
		button3.layer.borderColor = UIColor.lightGray.cgColor

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
		} else {
			title = "Wrong"
			score -= 1
		}

		let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
		present(ac, animated: true)
	}
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Yay!")
            } else {
                print("D'oh!")
            }
            
        }
    }
    
    @objc func scheduleLocal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Seven days of notifications"
        content.body = "You'll get a notification at this time every day for the next seven days."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 7
        dateComponents.minute = 24
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let trigger0 = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // right away
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: false) // 1 day
        let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: 172800, repeats: false) // 2 days
        let trigger3 = UNTimeIntervalNotificationTrigger(timeInterval: 259200, repeats: false) // 3 days
        let trigger4 = UNTimeIntervalNotificationTrigger(timeInterval: 345600, repeats: false) // 4 days
        let trigger5 = UNTimeIntervalNotificationTrigger(timeInterval: 432000, repeats: false) // 5 days
        let trigger6 = UNTimeIntervalNotificationTrigger(timeInterval: 518400, repeats: false) // 6 days
        let trigger7 = UNTimeIntervalNotificationTrigger(timeInterval: 604800, repeats: false) // 7 days

        let request0 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger0)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        let request2 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger2)
        let request3 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger3)
        let request4 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger4)
        let request5 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger5)
        let request6 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger6)
        let request7 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger7)

        center.add(request0)
        center.add(request)
        center.add(request2)
        center.add(request3)
        center.add(request4)
        center.add(request5)
        center.add(request6)
        center.add(request7)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                print("Default identifier")
            case "show":
                print("Show more information...")
                center.removeAllPendingNotificationRequests()
                scheduleLocal()
            default:
                break
            }
        }
        completionHandler()
    }
    
    
}
