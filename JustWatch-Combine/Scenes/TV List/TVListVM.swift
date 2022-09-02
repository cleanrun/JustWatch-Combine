//
//  TVListVM.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 28/08/22.
//

import Foundation
import Combine

final class TVListVM: ObservableObject {
    
    enum Section: Hashable {
        case popular
        case onTheAir
        case topRated
    }
    
    // MARK: - Published properties
    @Published private(set) var popular: [TVSeriesList] = []
    @Published private(set) var onTheAir: [TVSeriesList] = []
    @Published private(set) var topRated: [TVSeriesList] = []
    
    @Published private(set) var isFetchingData: Bool = false
    
    init() {}
    
    // MARK: - API Calls
    private func fetchPopular() async {
        await Webservice.current.request(endpoint: Config.URL_TV_GET_POPULAR("1"), type: TVSeriesList.self, onSuccess: { [weak self] value in
            self?.popular.removeAll()
            self?.popular.append(value)
        }, onError: { error in
            print("error: \(error)")
        })
    }
    
    private func fetchOnTheAir() async {
        await Webservice.current.request(endpoint: Config.URL_TV_GET_ON_THE_AIR("1"), type: TVSeriesList.self, onSuccess: { [weak self] value in
            self?.onTheAir.removeAll()
            self?.onTheAir.append(value)
        }, onError: { error in
            print("error: \(error)")
        })
    }
    
    private func fetchTopRated() async {
        await Webservice.current.request(endpoint: Config.URL_TV_GET_TOP_RATED("1"), type: TVSeriesList.self, onSuccess: { [weak self] value in
            self?.topRated.removeAll()
            self?.topRated.append(value)
        }, onError: { error in
            print("error: \(error)")
        })
    }
    
    func fetchData() async {
        isFetchingData = true
        await fetchPopular()
        await fetchOnTheAir()
        await fetchTopRated()
        isFetchingData = false
    }
}
