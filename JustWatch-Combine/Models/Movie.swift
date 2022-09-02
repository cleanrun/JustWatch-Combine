//
//  Movie.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 28/08/22.
//

import Foundation

struct Movie: Codable, Hashable {
    var ID: Int?
    var imdbID: String?
    var title: String?
    var originalTitle: String?
    var originalLanguage: String?
    var overview: String?
    var runtime: Int?
    var budget: Int?
    var popularity: Double?
    var posterPath: String?
    var backdropPath: String?
    var releaseDate: String?
    var status: String?
    var voteAverage: Double?
    var voteCount: Int?
    var genreIDs: [Int]?
    var productionCompanies: [ProductionCompany]?
    var genres: [Genre]?
    
    private enum CodingKeys: String, CodingKey {
        case ID = "id"
        case imdbID = "imdb_id"
        case title
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case overview
        case runtime
        case budget
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case status
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genreIDs = "genre_ids"
        case productionCompanies = "production_companies"
        case genres
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.ID! == rhs.ID!
    }
}

struct MovieList: Codable, Hashable {
    var results: [Movie]?
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
