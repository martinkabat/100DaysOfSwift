//
//  ViewController.swift
//  Milestone19-21
//
//  Created by Martin Kabát on 06.02.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var notes: [Note] = {
        do {
            let fileURL = try FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                        .appendingPathComponent("notes.json")
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let items = try decoder.decode([Note].self, from: data)
            
            return items
        } catch {
            print(error.localizedDescription)
            print(String(describing: error))
            return []
        }
    }()
    
    static let notificationName = Notification.Name("SniffForNotification")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Notes"
        
        let symbol = UIImage(systemName: "square.and.pencil")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: symbol, style: .plain, target: self, action: #selector(compose))
        
        // show what's out there already on disk
        print(notes.map({ $0.name }))
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notification:)), name: ViewController.notificationName, object: nil)
    }
    
    // Received notification handling
    @objc func onNotification(notification:Notification) {
        print("Notification sniffed!")
        let poznamka = notification.object
        let action = notification.userInfo?["action"] as! String
        
        switch action {
        case "save":
            save(note: poznamka as! Note)
        case "saveAtIndex":
            let index = notification.userInfo!["index"] as? IndexPath
            save(note: poznamka as! Note, atIndexPath: index!)
        case "delete":
            deleteNote(at: poznamka as! IndexPath)
        default:
            break
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.name
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Detail = Storyboard ID @ DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailVC {
            vc.note = notes[indexPath.row]
            vc.index = indexPath
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let editAction = UIContextualAction(style: .normal, title: "Edit name", handler: {_,_,_ in
                let ac = UIAlertController(title: "Rename note", message: nil, preferredStyle: .alert)
                ac.addTextField()
                ac.textFields?.first?.text =  self.notes[indexPath.item].name
                ac.addAction(UIAlertAction(title: "Rename", style: .default) {_ in
                    self.notes[indexPath.item].name = ac.textFields?[0].text ?? ""
                    self.writeJSON()
                    tableView.reloadData()
                })
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
                self.present(ac, animated: true)
            })
            
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {_,_,_ in
                self.deleteNote(at: indexPath)
            })
            
            let swipeActionsConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
            
            return swipeActionsConfiguration
        }
    
    func writeJSON() {
        do {
            
        let fileURL = try FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                   .appendingPathComponent("notes.json")

               let encoder = JSONEncoder()
               try encoder.encode(notes).write(to: fileURL)

        } catch {
            print(error.localizedDescription)
        }
    }
    
    func save(note: Note) {
        notes.append(note)
        writeJSON()
        tableView.reloadData()
        print(notes.map({ $0.name }))
    }
    
    func save(note: Note, atIndexPath indexPath: IndexPath) {
        deleteNote(at: indexPath)
        notes.insert(note, at: indexPath.item)
        writeJSON()
        tableView.reloadData()
        print(notes.map({ $0.name }))
    }
    
    func deleteNote(at index: IndexPath) {
        notes.remove(at: index.item)
        writeJSON()
        tableView.reloadData()
        print(notes.map({ $0.name }))
    }
    
    
    @objc func compose() {
        // Detail = Storyboard ID at DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

