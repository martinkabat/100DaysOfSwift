//
//  Note.swift
//  Milestone19-21
//
//  Created by Martin Kabát on 06.02.2023.
//

import Foundation

class Note: Codable {
    var name: String
    var text: String
    
    init(name: String, text: String) {
        self.name = name
        self.text = text
    }
}
