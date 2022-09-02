//
//  Season.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 31/08/22.
//

import Foundation

struct Season: Codable, Hashable {
    var ID: Int?
    var _ID: String?
    var airDate: String?
    var name: String?
    var overview: String?
    var posterPath: String?
    var seasonNumber: Int?
    var episodeCount: Int?
    var episodes: [Episode]?
    
    private enum CodingKeys: String, CodingKey {
        case ID = "id"
        case _ID = "_id"
        case airDate = "air_date"
        case name
        case overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case episodeCount = "episode_count"
        case episodes
    }
    
    static func == (lhs: Season, rhs: Season) -> Bool {
        lhs.ID == rhs.ID
    }
}
