//
//  Country.swift
//  MilestoneP13-15
//
//  Created by Martin Kabát on 11.11.2022.
//

import Foundation

class Country: Codable {
    var name: String
    var capital: String
    var size: Float
    var population: Int
    var language: [String]
    var visited: Bool
    var flag: String
}
