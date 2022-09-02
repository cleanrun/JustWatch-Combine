//
//  SearchResultCellVM.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 01/09/22.
//

import Foundation
import UIKit

struct SearchResultCellVM {
    enum SearchResultType {
        case movie
        case tv
    }
    
    var type: SearchResultType
    var movie: Movie?
    var tvSeries: TVSeries?
    
    init(movie: Movie) {
        self.type = .movie
        self.movie = movie
    }
    
    init(tvSeries: TVSeries) {
        self.type = .tv
        self.tvSeries = tvSeries
    }
    
    func getPosterImage() async -> UIImage? {
        let path = (type == .movie ? movie?.posterPath ?? "" : tvSeries?.posterPath ?? "")
        if let data = await Webservice.current.requestImage(path: path) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
}
