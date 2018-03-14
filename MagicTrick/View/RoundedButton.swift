//
//  RoundedButton.swift
//  MagicTrick
//
//  Created by Roman Roibu on 14.03.18.
//  Copyright © 2018 Roman Roibu. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    convenience init(title: String, target: Any, action: Selector) {
        self.init(type: .roundedRect)
        self.setTitle(title, for: .normal)
        self.addTarget(target, action: action, for: .touchUpInside)

        self.contentHorizontalAlignment = .center
        self.backgroundColor = UIColor(white: 0.3, alpha: 0.8)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
}
