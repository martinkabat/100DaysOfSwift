//
//  DetailViewController.swift
//  Project13
//
//  Created by Martin Kabát on 21.10.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var imageName: String?
    var caption: String?
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = caption
        
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName!)
        let data = NSData(contentsOf: imagePath)
        imageView.image = UIImage(data: data! as Data)
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
