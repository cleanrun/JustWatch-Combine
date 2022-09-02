//
//  ItemCell.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 28/08/22.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    static let CELL_WIDTH: CGFloat = 150
    static let CELL_HEIGHT: CGFloat = 180
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.applyBorder(color: .lightGray, width: 2)
    }
    
    func setupContents(with viewModel: ItemCellVM) {
        DispatchQueue.main.async {
            Task {
                self.posterImage.image = await viewModel.getImageFromData()
            }
        }
        
        titleLabel.text = viewModel.title
    }

}
