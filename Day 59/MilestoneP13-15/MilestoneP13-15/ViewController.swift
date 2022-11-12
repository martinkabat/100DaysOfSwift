//
//  ViewController.swift
//  MilestoneP13-15
//
//  Created by Martin Kabát on 11.11.2022.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()
    var imageLoader = ImageLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Countries"
        
        let countriesData = readLocalJSONFile(forName: "countries")
        countries = parse(jsonData: countriesData!)
    }
    
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }

    func parse(jsonData: Data) -> [Country] {
        do {
            let decodedData = try JSONDecoder().decode(Countries.self, from: jsonData)
            return decodedData.countries
        } catch {
            print("error: \(error)")
        }
        return []
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        
        let country = countries[indexPath.row]
        cell.countryLabel?.text = country.name
        cell.countryLabel?.font = UIFont(name: "Roboto", size: 40)
        cell.visitedLabel?.text = country.visited ? "You visited this country." : "You still have to visit this country."
        
        imageLoader.obtainImageWithPath(imagePath: country.flag) { (image) in
                cell.flag!.image = image
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc  = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.country = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

