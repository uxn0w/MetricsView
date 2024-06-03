//
//  FixedStackView.swift
//  
//
//  Created by Damian on 03.06.2024.
//

import UIKit

class FixedStackView: UIStackView {
    
    var stackSize = 6
    
    convenience init(stackSize: Int = 6) {
        self.init(frame: .zero)
        self.stackSize = stackSize
    }
    
    override func addArrangedSubview(_ view: UIView) {
        if arrangedSubviews.count >= stackSize {
            let view = arrangedSubviews[0]
            self.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        super.addArrangedSubview(view)
        var alpha = (100.0 / Double(stackSize)) / 100
        for view in arrangedSubviews {
            view.alpha = alpha
            alpha += alpha
        }
    }
}
