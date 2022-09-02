//
//  UICollectionViewCell+Extension.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 02/09/22.
//

import UIKit

extension UICollectionViewCell {
    static var REUSE_IDENTIFIER: String {
        String(describing: self)
    }
}
