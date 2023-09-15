//
//  Transformer.swift
//  TransformersApp
//
//  Created by capregsoft on 14/09/2023.
//
//   let transformer = try? JSONDecoder().decode(Transformer.self, from: jsonData)

import Foundation

// MARK: - Transformer
struct Transformer: Codable {
    var id, name: String
    var strength, intelligence, speed, endurance: Int
    var rank, courage, firepower, skill: Int
    var team: String
    var teamIcon: String
    var overallRating: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, strength, intelligence, speed, endurance, rank, courage, firepower, skill, team, overallRating
        case teamIcon = "team_icon"
    }
}

