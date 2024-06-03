//
//  UIStackView+removeAllArrangedSubviews.swift
//
//
//  Created by Damian on 29.05.2024.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
