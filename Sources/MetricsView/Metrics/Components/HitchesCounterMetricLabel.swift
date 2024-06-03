//
// HitchesCounterMetricLabel.swift
//
//
//  Created by Damian on 26.05.2024.
//

import UIKit

final class HitchesCounterMetricLabel: MetricLabel<HitchesCounterMetricProvider> {

    public convenience init() {
        self.init(frame: .zero)
        self.text = "0"
        self.provider.onReceiveHitchCounter = { [weak self] counter in
            self?.didReceiveHitchCounter(counter)
        }
    }

    func didReceiveHitchCounter(_ counter: Int) {
        self.text = counter.description
    }
}
