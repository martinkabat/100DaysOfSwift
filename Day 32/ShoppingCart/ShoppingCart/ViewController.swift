//
//  ViewController.swift
//  ShoppingCart
//
//  Created by Martin Kabát on 05.06.2022.
//

import UIKit

class ViewController: UITableViewController {
    @IBOutlet var tableview: UITableView!
    
    var shoppingCart: [String] = ["mustard", "honey", "milk"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Shopping Cart"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeAllItems))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingCart.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopItem", for: indexPath)
        cell.textLabel?.text = shoppingCart[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            
            // Removing item from array
            self.shoppingCart.remove(at: indexPath.row)
            
            // Removing item in the tableView
            let indexPath = IndexPath(row: indexPath.row, section: indexPath.section)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }
    
    // Handles when user touches the (+) button on the right side of the navigation bar
    @objc func addNewItem() {
        // Creates alert controller with title
        let alertController = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        // Adds text field to the alert controller
        alertController.addTextField()
        
        // Adds submit button (alert action) to the alert controller
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alertController] action in
            guard let answer = alertController?.textFields?[0].text else { return }
            
            self?.submit(answer)
        }
        
        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }
    
    func submit(_ answer: String) {
        // Saving item to array
        shoppingCart.insert(answer, at: 0)
        
        // Displaying item in the tableView
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func removeAllItems(){
        shoppingCart.removeAll()
        tableView.reloadData()
    }
}

