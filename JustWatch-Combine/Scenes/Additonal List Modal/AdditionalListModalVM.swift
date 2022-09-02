//
//  AdditionalListModalVM.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 02/09/22.
//

import Foundation
import Combine

class AdditionalListModalVM: ObservableObject {
    enum ListType {
        case productionCompany
        case network
        case season
        case episode
    }
    
    private(set) var listType: ListType
    private(set) var productionCompanies: [ProductionCompany]?
    private(set) var networks: [ProductionCompany]?
    private(set) var seasons: [Season]?
    
    private var tvId: Int?
    private var seasonNumber: Int?
    @Published private(set) var episodes: [Episode]?
    
    init(productionCompanies: [ProductionCompany]) {
        self.listType = .productionCompany
        self.productionCompanies = productionCompanies
    }
    
    init(networks: [ProductionCompany]) {
        self.listType = .network
        self.networks = networks
    }
    
    init(seasons: [Season]) {
        self.listType = .season
        self.seasons = seasons
    }
    
    init(tvId: Int, seasonNumber: Int) {
        self.listType = .episode
        self.tvId = tvId
        self.seasonNumber = seasonNumber
    }
    
    func getEpisodes() async {
        await Webservice.current.request(endpoint: Config.URL_SEASONS_GET_DETAILS("\(tvId!)", "\(seasonNumber!)"), type: Season.self, onSuccess: { [weak self] value in
            self?.episodes = value.episodes
        }, onError: { error in
            print("error: \(error)")
        })
    }
}
