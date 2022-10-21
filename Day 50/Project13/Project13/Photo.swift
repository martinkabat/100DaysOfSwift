//
//  Photo.swift
//  Project13
//
//  Created by Martin Kabát on 20.10.2022.
//

import UIKit

class Photo: NSObject, Codable {
    var imageName: String
    var caption: String
    
    init(imageName: String, caption: String) {
        self.imageName = imageName
        self.caption = caption
    }
}
