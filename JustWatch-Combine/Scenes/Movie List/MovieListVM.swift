//
//  MovieListVM.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 28/08/22.
//

import Foundation
import Combine

final class MovieListVM: ObservableObject {
    
    enum Section: Hashable {
        case popular
        case nowPlaying
        case upcoming
    }
    
    // MARK: - Published properties
    @Published private(set) var popular: [MovieList] = []
    @Published private(set) var nowPlaying: [MovieList] = []
    @Published private(set) var upcoming: [MovieList] = []
    
    @Published private(set) var isFetchingData: Bool = false
    
    //private var bindings = Set<AnyCancellable>()
    
    init() {}
    
    // MARK: - API Calls
    private func fetchPopular() async {
        await Webservice.current.request(endpoint: Config.URL_MOVIES_GET_POPULAR("1"), type: MovieList.self, onSuccess: { [weak self] value in
            self?.popular.removeAll()
            self?.popular.append(value)
        }, onError: { error in
            print("error: \(error)")
        })
    }
    
    private func fetchNowPlaying() async {
        await Webservice.current.request(endpoint: Config.URL_MOVIES_GET_NOW_PLAYING("1"), type: MovieList.self, onSuccess: { [weak self] value in
            self?.nowPlaying.removeAll()
            self?.nowPlaying.append(value)
        }, onError: { error in
            print("error: \(error)")
        })
    }
    
    private func fetchUpcoming() async {
        await Webservice.current.request(endpoint: Config.URL_MOVIES_GET_UPCOMING("1"), type: MovieList.self, onSuccess: { [weak self] value in
            self?.upcoming.removeAll()
            self?.upcoming.append(value)
        }, onError: { error in
            print("error: \(error)")
        })
    }
    
    func fetchData() async {
        isFetchingData = true
        await fetchPopular()
        await fetchNowPlaying()
        await fetchUpcoming()
        isFetchingData = false
    }
}
