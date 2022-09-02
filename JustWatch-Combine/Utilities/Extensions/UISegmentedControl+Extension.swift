//
//  UISegmentedControl+Extension.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 01/09/22.
//

import UIKit
import Combine

extension UISegmentedControl {
    var selectedIndexPublisher: AnyPublisher<Int, Never> {
        self.publisher(for: .valueChanged)
            .compactMap { ($0 as? UISegmentedControl)?.selectedSegmentIndex }
            .eraseToAnyPublisher()
    }
}
