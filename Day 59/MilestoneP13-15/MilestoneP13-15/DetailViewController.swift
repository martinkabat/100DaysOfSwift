//
//  DetailViewController.swift
//  MilestoneP13-15
//
//  Created by Martin Kabát on 12.11.2022.
//

import UIKit

class DetailViewController: UITableViewController {
    var country: Country?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = country?.name
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryFactIdentifier", for: indexPath)
        cell.textLabel?.font = UIFont(name: "Roboto", size: 30)
        cell.detailTextLabel?.font = UIFont(name: "Roboto", size: 25)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Country name"
            cell.detailTextLabel?.text = country?.name
        case 1:
            cell.textLabel?.text = "Capital"
            cell.detailTextLabel?.text = country?.capital
        case 2:
            cell.textLabel?.text = "Size"
            cell.detailTextLabel?.text = "\(country?.size ?? 0) square kilometers"
        case 3:
            cell.textLabel?.text = "Population"
            cell.detailTextLabel?.text = "\(country?.population ?? 0) inhabitants"
        case 4:
            cell.textLabel?.text = "Language"
            cell.detailTextLabel?.text = country?.language.joined(separator: ", ")
        case 5:
            cell.textLabel?.text = "Visited"
            cell.detailTextLabel?.text = country!.visited ? "You have visited this country" : "You still have to visit this country."
            
        default:
            cell.textLabel?.text = "Title \(indexPath.row)"
            cell.detailTextLabel?.text = "Detail \(indexPath.row)"
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
