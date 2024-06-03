//
//  MemoryMetricLabel.swift
//  
//
//  Created by Damian on 28.05.2024.
//

import UIKit

final class MemoryMetricLabel: MetricLabel<MemoryMetricProvider> {

    private let physicalMemory = Int(ProcessInfo.processInfo.physicalMemory)
    
    public convenience init() {
        self.init(frame: .zero)
        self.provider.onReceiveUsedMemory = { [weak self] value in
            self?.didReceiveMemoryUsageValue(value)
        }
    }

    private func didReceiveMemoryUsageValue(_ value: Int) {
        let stringValue = self.makeMemoryUsageString(used: value, total: self.physicalMemory)
        DispatchQueue.main.async {
            self.text = stringValue
        }
    }

    private func makeMemoryUsageString(used: Int, total: Int) -> String {
        let bytesInMegabyte = 1024.0 * 1024.0
        let usedMemory = Double(used) / bytesInMegabyte
        let totalMemory = Double(total) / bytesInMegabyte
        return String(format: "%.1f of %.0f MB used", usedMemory, totalMemory)
    }
}
