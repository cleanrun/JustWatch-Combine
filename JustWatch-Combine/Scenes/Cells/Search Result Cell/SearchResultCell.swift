//
//  SearchResultCell.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 01/09/22.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    static let CELL_HEIGHT: CGFloat = 80
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    private var viewModel: SearchResultCellVM!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
    }
    
    func setupContents(viewModel: SearchResultCellVM) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.type == .movie ? (viewModel.movie?.title ?? "") : (viewModel.tvSeries?.name ?? "")
        releaseDateLabel.text = "Released in: " + (viewModel.type == .movie ? (viewModel.movie?.releaseDate ?? "") : (viewModel.tvSeries?.firstAirDate ?? ""))
        
        Task { [unowned self] in
            if let image = await viewModel.getPosterImage() {
                DispatchQueue.main.async {
                    self.posterImage.image = image
                }
            } else {
                self.posterImage.image = UIImage(systemName: "film.circle")
            }
        }
    }
    
}
