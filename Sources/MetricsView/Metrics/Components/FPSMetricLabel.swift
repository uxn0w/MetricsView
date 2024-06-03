//
//  FPSMetricLabel.swift
//
//
//  Created by Damian on 26.05.2024.
//

import Foundation
import UIKit

final class FPSMetricLabel: MetricLabel<FPSMetricProvider> {
        
    public convenience init() {
        self.init(frame: .zero)
        self.provider.onReceiveFPS = { [weak self] rate in
            self?.didReceiveFPS(rate: rate)
        }
    }
    
    var maxRate: Int {
        Int(provider.normalRate)
    }
    
    lazy var minRate: Int = maxRate
    
    public func didReceiveFPS(rate: Int) {
        if rate < minRate {
            minRate = rate
        }
        self.text = "\(minRate)/\(rate)/\(maxRate)"
    }
}

