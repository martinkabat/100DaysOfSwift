//
//  DetailVC.swift
//  Milestone19-21
//
//  Created by Martin Kabát on 06.02.2023.
//

import UIKit

class DetailVC: UIViewController {
    
    var name: String?
    var index: IndexPath?
    
    var note = Note(name: "", text: "")
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = note.name
        textView.text = note.text

        let trash = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(trash))
        
        let save = UIBarButtonItem(image: UIImage(systemName: "tray.and.arrow.down"), style: .plain, target: self, action: #selector(save))
        
        let share = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareTapped))
        
        self.navigationItem.rightBarButtonItems = [save, trash, share]
    }
    
    @objc func trash() {
        let ac = UIAlertController(title: "Delete the note", message: "Do you wish to delete the note?", preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "Delete note", style: .default) {_ in
            if self.index != nil {
                NotificationCenter.default.post(name: ViewController.notificationName, object: self.index, userInfo: ["action": "delete"])
            }
            self.navigationController?.popViewController(animated: true)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(ac, animated: true)
    }

    @objc func save() {
        let ac = UIAlertController(title: "Name the note", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.textFields?.first?.text = self.title ?? "" // show name from title if there is one
        
        ac.addAction(UIAlertAction(title: "Save note", style: .default) {_ in
            let poznamka = Note(name: ac.textFields?[0].text ?? "Test name", text: self.textView.text)
            
            var userInfo = Dictionary<String, Any>() // Dictionary of various value types
            
            if self.index != nil {
                userInfo["action"] = "saveAtIndex"
                userInfo["index"] = self.index
            } else {
                userInfo["action"] = "save"
                userInfo["index"] = nil
            }
            
            NotificationCenter.default.post(name: ViewController.notificationName, object: poznamka, userInfo: userInfo)
            self.navigationController?.popViewController(animated: true)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(ac, animated: true)
    }
    
    @objc func shareTapped() {
       guard let text = self.textView.text else {
           print("No text found.")
           return
       }
       
       let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
       vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // Without this line, the app would crash on iPad as it has to show up on the screen.
       present(vc, animated: true)
   }
}
