//
//  MovieDetailVM.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 31/08/22.
//

import UIKit
import Combine

class MovieDetailVM: ObservableObject {
    
    private var movieId: Int!
    
    @Published private(set) var movie: Movie?
    @Published private(set) var backdropImage: UIImage?
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func getMovie() async {
        await Webservice.current.request(endpoint: Config.URL_MOVIES_GET_DETAILS("\(movieId ?? 0)"), type: Movie.self, onSuccess: { [weak self] movie in
            self?.movie = movie
        }, onError: { error in
            print("error: \(error)")
        })
        
        await getBackdropImage()
    }
    
    private func getBackdropImage() async {
        if let data = await Webservice.current.requestImage(path: movie?.backdropPath ?? "") {
            backdropImage = UIImage(data: data)
        } else {
            backdropImage = nil
        }
    }
}
