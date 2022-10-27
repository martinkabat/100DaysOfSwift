//
//  ViewController.swift
//  Project13
//
//  Created by Martin Kabát on 20.10.2022.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var photos = [Photo]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photos"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(takeAPhoto))
        
        let defaults = UserDefaults.standard
        
        if let savedPhotos = defaults.object(forKey: "photos") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                photos = try jsonDecoder.decode([Photo].self, from: savedPhotos)
            } catch {
                print("Failed to load photos array.")
            }
        }
        
        tableView.allowsMultipleSelectionDuringEditing = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Photo")
        cell.textLabel?.text = photos[indexPath.row].caption
        cell.imageView?.image = UIImage(named:photos[indexPath.row].imageName)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: {_,_,_ in
            let ac = UIAlertController(title: "Rename photo", message: nil, preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "Rename", style: .default) {_ in
                self.photos[indexPath.item].caption = ac.textFields?[0].text ?? ""
                self.save()
                tableView.reloadData()
            })
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            self.present(ac, animated: true)
        })
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {_,_,_ in
            self.deletePhoto(at: indexPath)
        })
        
        let swipeActionsConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        
        return swipeActionsConfiguration
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deletePhoto(at: indexPath)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dvc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            dvc.imageName = photos[indexPath.row].imageName
            dvc.caption = photos[indexPath.row].caption
            
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    @objc func takeAPhoto() {
        let ac = UIAlertController(title: "Take a photo?", message: "Would you like to take a new photo", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .default) {_ in
            self.pickImage()
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func pickImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .camera
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let photo = Photo(imageName: imageName, caption: "Unknown")
        photos.append(photo)
        save()
        tableView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(photos) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "photos")
        } else {
            print("Failed to save photos array.")
        }
    }
    
    func deletePhoto(at index: IndexPath) {
        photos.remove(at: index.item)
        tableView.reloadData()
    }
}

