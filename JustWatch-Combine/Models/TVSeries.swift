//
//  TVSeries.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 28/08/22.
//

import Foundation

struct TVSeries: Codable, Hashable {
    var ID: Int?
    var name: String?
    var inProduction: Bool?
    var originalName: String?
    var originalLanguage: String?
    var firstAirDate: String?
    var overview: String?
    var status: String?
    var tagline: String?
    var type: String?
    var popularity: Double?
    var voteAverage: Double?
    var voteCount: Int?
    var numberOfSeasons: Int?
    var numberOfEpisodes: Int?
    var posterPath: String?
    var backdropPath: String?
    var genreIDs: [Int]?
    var genres: [Genre]?
    var networks: [ProductionCompany]?
    var productionCompanies: [ProductionCompany]?
    var seasons: [Season]?
    var createdBy: [People]?
    
    private enum CodingKeys: String, CodingKey {
        case ID = "id"
        case name
        case inProduction = "in_production"
        case originalName = "original_name"
        case originalLanguage = "original_language"
        case firstAirDate = "first_air_date"
        case overview
        case status
        case tagline
        case type
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case numberOfSeasons = "number_of_seasons"
        case numberOfEpisodes = "number_of_episodes"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case genres
        case networks
        case productionCompanies = "production_companies"
        case seasons
        case createdBy = "created_by"
    }
}

struct TVSeriesList: Codable, Hashable {
    var results: [TVSeries]?
    var totalPages: Int?
    var totalResults: Int?
    var page: Int?
    
    private enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page
    }
}
