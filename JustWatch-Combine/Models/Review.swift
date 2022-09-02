//
//  Revie.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 31/08/22.
//

import Foundation

struct Review: Codable {
    var ID: Int?
    var author: String?
    var authorDetails: Author?
    var content: String?
    var createdAt: String?
    var url: String?
    var mediaID: Int?
    var mediaTitle: String?
    var mediaType: String?
    
    private enum CodingKeys: String, CodingKey {
        case ID = "id"
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case url
        case mediaID = "media_id"
        case mediaTitle = "media_title"
        case mediaType = "mediaType"
    }
}
