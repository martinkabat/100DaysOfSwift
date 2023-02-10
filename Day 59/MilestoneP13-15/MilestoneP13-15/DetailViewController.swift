//
//  DetailViewController.swift
//  MilestoneP13-15
//
//  Created by Martin Kabát on 12.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var country: Country?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = country?.name
    }
}
