//
//  ViewController.swift
//  Project21
//
//  Created by Martin Kabát on 27.01.2023.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal(in:)))
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
    
    @objc func scheduleLocal(in noOfSeconds: Double) {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: noOfSeconds != 86400 ? 5 : noOfSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        
        let authenticate = UNNotificationAction(identifier: "authenticate", title: "Authenticate, then this is visible.", options: .authenticationRequired)
        
        let destroy = UNNotificationAction(identifier: "destroy", title: "Action with destructive task", options: .destructive)
        
        let later = UNNotificationAction(identifier: "later", title: "Remind me later", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, authenticate, destroy, later], intentIdentifiers: [], options: [])
        
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
            case "authenticate":
                print("Authenticate kind of action fired.")
            case "destroy":
                print("Destructive kind of acition fired.")
            case "later":
                print("Remind me later fired.")
                scheduleLocal(in: 86400) // one day
            default:
                break
            }
        }
        completionHandler()
    }

}

