//
//  Genre.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 31/08/22.
//

import Foundation

struct Genre: Codable, Hashable {
    var ID: Int?
    var name: String?
    
    private enum CodingKeys: String, CodingKey {
        case ID = "id"
        case name
    }
}
