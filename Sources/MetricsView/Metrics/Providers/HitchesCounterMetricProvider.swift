//
//  HitchesCounterMetricProvider.swift
//
//
//  Created by Damian on 26.05.2024.
//

import UIKit

public final class HitchesCounterMetricProvider: MetricProvider {
    
    public var onReceiveHitchCounter: ((Int) -> Void)? = nil
    
    public private(set) var hitchesCounter = 0
    private var previouseTimestamp: CFTimeInterval?
    private lazy var normalRate = ((1.0 / Double(UIScreen.main.maximumFramesPerSecond)) * 1000).rounded()
    private lazy var displayLink = CADisplayLink(target: self, selector: #selector(processDisplayLink))

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
        guard let previouseTimestamp else {
            self.previouseTimestamp = link.timestamp
            return
        }
        let currentRate = ((link.timestamp - previouseTimestamp) * 1000).rounded()

        if currentRate > normalRate {
            self.hitchesCounter += 1
            self.onReceiveHitchCounter?(hitchesCounter)
        }
        self.previouseTimestamp = link.timestamp
    }
}
