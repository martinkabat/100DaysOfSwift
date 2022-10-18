//
//  ViewController.swift
//  Project1
//
//  Created by Martin Kabát on 21.03.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    var dict = [String: Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendApp))
        
        let fm = FileManager.default // load file manager
        let path = Bundle.main.resourcePath! // force unwrap main resource path of the main bundle (it always exists)
        let items = try! fm.contentsOfDirectory(atPath: path) // get all the items from this paths
        
        // loop through the items keeping only the ones with the "nssl" prefix
        for item in items {
            if item.hasPrefix("nssl") {
                // this is the picture to load!
                pictures.append(item)
            }
        }
        
        // Sort pictures by name
        pictures = pictures.sorted()
        
        let defaults = UserDefaults.standard
        dict = defaults.object(forKey: "pictures") as? [String: Int] ?? [String: Int]()
        
        
        print(pictures) // show me the name of the pictures
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) //?? UITableViewCell(style: .subtitle, reuseIdentifier: "Picture")
        cell.textLabel?.text = pictures[indexPath.row]
        let timesViewed = dict[pictures[indexPath.row]]
        if let timesViewed {
            cell.detailTextLabel?.text = "Viewed \(timesViewed) times."
        } else {
            cell.detailTextLabel?.text = "Viewed 0 times."
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.pictureXofY = "Picture \(indexPath.row+1) of \(pictures.count)"
            
            let picture = pictures[indexPath.row]
            let timesViewed = dict[picture] ?? 0
            dict[picture] = timesViewed + 1
            
            let defaults = UserDefaults.standard
            defaults.setValue(dict, forKey: "pictures")
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @objc func recommendApp() {
        let vc = UIActivityViewController(activityItems: ["Recommend this app to your friends!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

