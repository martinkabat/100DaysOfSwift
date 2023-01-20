//
//  ActionViewController.swift
//  Extension
//
//  Created by Martin Kabát on 15.12.2022.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {

    @IBOutlet var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""
    var host: String {
        let url = URL(string: pageURL)
        return url?.host ?? ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(chooseScript))
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self](dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javascriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    self?.pageTitle = javascriptValues["title"] as? String ?? ""
                    self?.pageURL = javascriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                        //self?.loadScript()
                    }
                }
            }
        }
    }

    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
        
        saveScript()
    }
    
    @objc func chooseScript() {
        let ac = UIAlertController(title: "Choose script", message: "from the options below", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Hello, world!", style: .default, handler: firstScript))
        ac.addAction(UIAlertAction(title: "Website URL", style: .default, handler: secondScript))
        ac.addAction(UIAlertAction(title: "Confirm dialog", style: .default, handler: thirdScript))
        ac.addAction(UIAlertAction(title: "Close", style: .cancel))
        
        present(ac, animated: true)
    }
    
    func firstScript(action: UIAlertAction) {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": "alert('Hello, world!')"]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
    }
    
    func secondScript(action: UIAlertAction) {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": "alert(\"\(pageURL)\")"]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
    }
    
    func thirdScript(action: UIAlertAction) {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": "window.confirm(\"Would you like to know what's going on?\");"]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
    }

    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, to: view.window)
        
        if notification.name == UIResponder.keyboardDidHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
    
    func saveScript() {
        guard !script.text.isEmpty else { return }
        guard !host.isEmpty else { return }
        let defaults = UserDefaults.standard
        defaults.set(script.text, forKey: host)
    }

    func loadScript() {
        let defaults = UserDefaults.standard
        
        guard !host.isEmpty else { return }

        if let savedScript = defaults.string(forKey: host) {
            script.text = savedScript as String
        }
    }
}
