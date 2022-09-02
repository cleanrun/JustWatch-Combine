//
//  ProdctionCompany.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 31/08/22.
//

import Foundation

struct ProductionCompany: Codable, Hashable {
    var ID: Int?
    var name: String?
    var logoPath: String?
    var originCountry: String?
    
    private enum CodingKeys: String, CodingKey {
        case ID = "id"
        case name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}
