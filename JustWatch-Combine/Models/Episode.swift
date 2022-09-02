//
//  Episode.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 31/08/22.
//

import Foundation

struct Episode: Codable, Hashable {
    var ID: Int?
    var name: String?
    var airDate: String?
    var episodeNumber: Int?
    var seasonNumber: Int?
    var productionCode: String?
    var overview: String?
    var voteAverage: Double?
    var voteCount: Int?
    
    private enum CodingKeys: String, CodingKey {
        case ID = "id"
        case name
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case seasonNumber = "season_number"
        case productionCode = "production_code"
        case overview
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
