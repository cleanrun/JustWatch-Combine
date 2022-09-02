//
//  UITableViewCell_Extension.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 02/09/22.
//

import UIKit

extension UITableViewCell {
    static var REUSE_IDENTIFIER: String {
        String(describing: self)
    }
}
