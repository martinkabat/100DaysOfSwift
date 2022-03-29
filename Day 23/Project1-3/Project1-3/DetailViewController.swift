//
//  DetailViewController.swift
//  Project1-3
//
//  Created by Martin Kabát on 29.03.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        
//        imageView.layer.borderWidth = 1
//        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        if let imageToLoad = selectedImage {
            title = imageToLoad.uppercased()
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    @objc func share() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found.")
            return
        }
                
        let vc = UIActivityViewController(activityItems: [image, selectedImage], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
