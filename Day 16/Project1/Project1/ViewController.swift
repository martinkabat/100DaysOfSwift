//
//  ViewController.swift
//  Project1
//
//  Created by Martin Kabát on 21.03.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        print(pictures) // show me the name of the pictures
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        
        return cell
    }
}

