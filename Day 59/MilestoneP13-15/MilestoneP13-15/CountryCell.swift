//
//  CountryCell.swift
//  MilestoneP13-15
//
//  Created by Martin Kabát on 11.11.2022.
//

import UIKit

class CountryCell: UITableViewCell {
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var visitedLabel: UILabel!
    @IBOutlet var flag: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

      //  contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }

}
