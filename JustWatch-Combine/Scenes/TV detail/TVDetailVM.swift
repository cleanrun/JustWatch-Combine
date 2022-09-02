//
//  TVDetailVM.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 02/09/22.
//

import UIKit
import Combine

class TVDetailVM: ObservableObject {
    
    private var tvId: Int!
    
    @Published private(set) var tvSeries: TVSeries?
    @Published private(set) var backdropImage: UIImage?
    
    init(tvId: Int) {
        self.tvId = tvId
    }
    
    func getMovie() async {
        await Webservice.current.request(endpoint: Config.URL_TV_GET_DETAILS("\(tvId ?? 0)"), type: TVSeries.self, onSuccess: { [weak self] tvSeries in
            self?.tvSeries = tvSeries
        }, onError: { error in
            print("error: \(error)")
        })
        
        await getBackdropImage()
    }
    
    private func getBackdropImage() async {
        if let data = await Webservice.current.requestImage(path: tvSeries?.backdropPath ?? "") {
            backdropImage = UIImage(data: data)
        } else {
            backdropImage = nil
        }
    }
}
