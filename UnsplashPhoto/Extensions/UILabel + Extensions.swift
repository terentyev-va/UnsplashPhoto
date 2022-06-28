//
//  UILabel + Extensions.swift
//  UnsplashPhoto
//
//  Created by Вячеслав Терентьев on 28.06.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String = "") {
        self.init()
        self.text = text
        self.textColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
