//
//  SectionCellVM.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 28/08/22.
//

import Foundation

struct SectionCellVM {
    enum SectionCellType {
        case movie
        case tv
    }
    
    var type: SectionCellType
    var title: String
    var movies: [Movie]?
    var tvSeries: [TVSeries]?
}
