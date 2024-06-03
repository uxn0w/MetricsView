//
//  CPUMetricLabel.swift
//
//
//  Created by Damian on 27.05.2024.
//

import Foundation

final class CPUMetricLabel: MetricLabel<CPUMetricProvider> {

    public convenience init() {
        self.init(frame: .zero)
        self.provider.onReceiveUsedCPU = { [weak self] value in
            self?.didReceiveUsedCPU(value)
        }
    }

    public func didReceiveUsedCPU(_ cpuValue: Double) {
        DispatchQueue.main.async {
            self.text = Int(cpuValue.rounded()).description + "%"
        }
    }
}
