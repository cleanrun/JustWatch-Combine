//
//  AdditionalListCell.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 02/09/22.
//

import UIKit

class AdditionalListCell: UITableViewCell {
    
    static let CELL_HEIGHT: CGFloat = 80

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    private var viewModel: AdditionalListCellVM!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        logoImage.image = nil
    }
    
    func setupContents(viewModel: AdditionalListCellVM) {
        self.viewModel = viewModel
        
        logoImage.isHidden = viewModel.type == .episode
        titleLabel.text = viewModel.getTitle()
        subtitleLabel.text = viewModel.getSubtitle()
        
        Task {
            logoImage.image = await viewModel.getLogoOrPosterImage()
        }
    }
    
}
