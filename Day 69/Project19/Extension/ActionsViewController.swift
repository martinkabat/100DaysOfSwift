//
//  ActionsView.swift
//  Extension
//
//  Created by Martin Kabát on 17.01.2023.
//

import UIKit

class ActionsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newScript))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "SnippetCell")
        cell.textLabel?.text = "Snippet no. \(indexPath.row)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ActionViewController()
        
        present(vc, animated: true)
    }
    
    @objc func newScript() {
        let vc = ActionViewController()
        
        present(vc, animated: true)
    }
}
