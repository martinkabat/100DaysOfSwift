//
//  ViewController.swift
//  Project1-3
//
//  Created by Martin Kabát on 29.03.2022.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Fun with Flags"
        
        countries += ["estonia", "france", "germany",
                                     "ireland", "italy", "monaco",
                                     "nigeria", "poland", "russia",
                                     "spain", "uk", "us"]
        
        countries = countries.sorted()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].uppercased()
        cell.imageView?.image = UIImage(named: countries[indexPath.row])
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}

