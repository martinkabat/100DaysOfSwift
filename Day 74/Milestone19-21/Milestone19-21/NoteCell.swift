//
//  NoteCell.swift
//  Milestone19-21
//
//  Created by Martin Kabát on 06.02.2023.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet var noteTitle: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
