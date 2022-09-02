//
//  People.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 31/08/22.
//

import Foundation

struct People: Codable, Hashable {
    var ID: Int?
    var imdbID: Int?
    var name: String?
    var alsoKnownAs: String?
    var gender: Int?
    var birthday: String?
    var placeOfBirth: String?
    var adult: Bool?
    var deathday: String?
    var biography: String?
    var profilePath: String?
    
    private enum CodingKeys: String, CodingKey {
        case ID = "id"
        case imdbID = "imdb_id"
        case name
        case alsoKnownAs = "also_known_as"
        case gender
        case birthday
        case placeOfBirth = "place_of_birth"
        case adult
        case deathday
        case biography
        case profilePath = "profile_path"
    }
}
