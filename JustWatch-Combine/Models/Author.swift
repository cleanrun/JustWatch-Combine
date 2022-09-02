//
//  Author.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 31/08/22.
//

import Foundation

struct Author: Codable {
    var name: String?
    var username: String?
    var avatarPath: String?
    var rating: Int?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
    }
}
