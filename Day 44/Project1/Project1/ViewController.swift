//
//  ViewController.swift
//  Project1
//
//  Created by Martin Kabát on 21.03.2022.
//

import UIKit

class ViewController: UICollectionViewController { 
    
    var pictures = [String]()

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
        
        print(pictures) // show me the name of the pictures
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictures.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Storm", for: indexPath) as? StormCell else {
            fatalError("Unable to deque StormCell")
        }
        
        cell.name.text = pictures[indexPath.item]
        cell.imageView.image =  UIImage(named: pictures[indexPath.item])

        
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.item]
            vc.pictureXofY = "Picture \(indexPath.item+1) of \(pictures.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func recommendApp() {
        let vc = UIActivityViewController(activityItems: ["Recommend this app to your friends!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

