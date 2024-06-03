//
//  DraggableView.swift
//
//
//  Created by Damian on 26.05.2024.
//

import UIKit

open class DraggableView: UIView {

    private var recognizer: UIPanGestureRecognizer?
    
    func setupRecognizer() {
        guard recognizer == nil else { return }
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureRecognizer(_:)))
        self.recognizer = recognizer
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(recognizer)
    }

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setupRecognizer()
    }
    
    @objc private func gestureRecognizer(_ sender: UIPanGestureRecognizer){
        guard let superview else { return }
        superview.bringSubviewToFront(self)
        let translation = sender.translation(in: superview)
        self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: superview)
    }
}
