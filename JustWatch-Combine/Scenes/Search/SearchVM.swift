//
//  SearchVM.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 01/09/22.
//

import Foundation
import Combine

class SearchVM: ObservableObject {
    enum SearchType: Int {
        case movie = 0
        case tv = 1
    }
    
    enum LoadingState {
        case loading
        case fetched
        case noData
    }
    
    @Published private(set) var movieResult: [Movie] = []
    @Published private(set) var tvResult: [TVSeries] = []
    @Published private(set) var loadingState: LoadingState = .noData
    @Published private(set) var searchType: SearchType = .movie
    
    private var bindings = Set<AnyCancellable>()
    
    init() {
        observeSearchType()
    }
    
    func setSearchType(_ type: SearchType) {
        searchType = type
    }
    
    func getSearchResult(query: String) async {
        await searchType == .movie ? getMovies(query: query) : getTVSeries(query: query)
    }
    
    private func observeSearchType() {
        $searchType.sink { [weak self] value in
            self?.movieResult.removeAll()
            self?.tvResult.removeAll()
            
            self?.loadingState = .noData
        }.store(in: &bindings)
    }
    
    private func getMovies(query: String) async {
        loadingState = .loading
        await Webservice.current.request(endpoint: Config.URL_SEARCH_GET_MOVIES(query, "1"), type: MovieList.self, onSuccess: { [weak self] value in
            if let result = value.results {
                guard !result.isEmpty else {
                    self?.loadingState = .noData
                    return
                }
                self?.movieResult = result
            }
            self?.loadingState = .fetched
        }, onError: { [weak self] error in
            self?.loadingState = .noData
            print("error: \(error)")
        })
    }
    
    private func getTVSeries(query: String) async {
        loadingState = .loading
        await Webservice.current.request(endpoint: Config.URL_SEARCH_GET_TV_SHOWS(query, "1"), type: TVSeriesList.self, onSuccess: { [weak self] value in
            if let result = value.results {
                guard !result.isEmpty else {
                    self?.loadingState = .noData
                    return
                }
                self?.tvResult = result
            }
            self?.loadingState = .fetched
        }, onError: { [weak self] error in
            self?.loadingState = .noData
            print("error: \(error)")
        })
    }
    
}
