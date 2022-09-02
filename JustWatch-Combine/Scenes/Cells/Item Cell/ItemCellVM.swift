//
//  ItemCellVM.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 28/08/22.
//

import UIKit

struct ItemCellVM {
    var imagePath: String
    var title: String
    
    func getImageFromData() async -> UIImage? {
        if let data = await Webservice.current.requestImage(path: imagePath) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
}
