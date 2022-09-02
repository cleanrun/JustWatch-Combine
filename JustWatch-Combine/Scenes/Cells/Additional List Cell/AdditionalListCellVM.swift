//
//  AdditionalListCellVM.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 02/09/22.
//

import UIKit

struct AdditionalListCellVM {
    var type: AdditionalListModalVM.ListType
    var productionCompany: ProductionCompany?
    var network: ProductionCompany?
    var season: Season?
    var episode: Episode?
    
    init(productionCompany: ProductionCompany) {
        type = .productionCompany
        self.productionCompany = productionCompany
    }
    
    init(network: ProductionCompany) {
        type = .network
        self.network = network
    }
    
    init(season: Season) {
        type = .season
        self.season = season
    }
    
    init(episode: Episode) {
        type = .episode
        self.episode = episode
    }
    
    func getTitle() -> String {
        switch type {
        case .episode:
            return "\(episode?.episodeNumber ?? 0). \(episode?.name ?? "")"
        case .network:
            return network?.name ?? ""
        case .productionCompany:
            return productionCompany?.name ?? ""
        case .season:
            return "Season \(season?.seasonNumber ?? 0)"
        }
    }
    
    func getSubtitle() -> String {
        switch type {
        case .episode:
            return "Air date: \(episode?.airDate ?? "")"
        case .network:
            return "Country of origin: \(network?.originCountry ?? "")"
        case .productionCompany:
            return "Country of origin: \(productionCompany?.originCountry ?? "")"
        case .season:
            return "\(season?.episodeCount ?? 0) episodes"
        }
    }
    
    func getLogoOrPosterImage() async -> UIImage? {
        guard type != .episode else {
            return nil
        }
        
        let path: String
        switch type {
        case .episode:
            path = ""
        case .network:
            path = network?.logoPath ?? ""
        case .productionCompany:
            path = productionCompany?.logoPath ?? ""
        case .season:
            path = season?.posterPath ?? ""
        }
        
        if let data = await Webservice.current.requestImage(path: path) {
            if let image = UIImage(data: data) {
                return image
            } else {
                return UIImage(systemName: "questionmark.square")
            }
        } else {
            return UIImage(systemName: "questionmark.square")
        }
    }
}
