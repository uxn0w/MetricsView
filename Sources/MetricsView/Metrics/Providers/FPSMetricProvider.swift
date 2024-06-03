//
//  FPSMetricProvider.swift
//  
//
//  Created by Damian on 26.05.2024.
//

import UIKit

public final class FPSMetricProvider: MetricProvider {

    private lazy var displayLink = CADisplayLink(target: self, selector: #selector(processDisplayLink))
    
    private var previousRate = 0.0
    public lazy var normalRate = Double(UIScreen.main.maximumFramesPerSecond)
    private var previousTimestamp: CFTimeInterval?
    
    public var onReceiveFPS: ((Int) -> Void)? = nil

    public override func start() {
        super.start()
        self.displayLink = CADisplayLink(target: self, selector: #selector(processDisplayLink))
        self.displayLink.add(to: .main, forMode: .common)
    }
    
    public override func stop() {
        self.displayLink.invalidate()
    }
    
    @objc private
    func processDisplayLink(_ link: CADisplayLink) {
        guard let previousTimestamp else {
            self.previousTimestamp = link.timestamp
            return
        }
        let currentRate = (1 / (link.timestamp - previousTimestamp)).rounded()
        if previousRate != currentRate && currentRate <= normalRate {
            self.previousRate = currentRate
            self.onReceiveFPS?(Int(currentRate))
        }
        self.previousTimestamp = link.timestamp
    }
}
