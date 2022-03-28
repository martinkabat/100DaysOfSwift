//
//  DetailViewController.swift
//  Project1
//
//  Created by Martin Kabát on 22.03.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var pictureXofY: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = pictureXofY
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        // Check whether the selectedImage has some values inside
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found.")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, selectedImage ?? "Image.jpg"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // Without this line, the app would crash on iPad as it has to show up on the screen.
        present(vc, animated: true)
    }

}
