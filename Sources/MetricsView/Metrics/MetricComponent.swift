//
//  MetricComponent.swift
//
//
//  Created by Damian on 26.05.2024.
//

import UIKit

public struct MetricComponent {

    let title: String
    let component: UIView

    public static var fps: MetricComponent {
        .init(title: "FPS:", component: FPSMetricLabel())
    }

    public static var hitches: MetricComponent {
        .init(title: "Hitches:", component: HitchesCounterMetricLabel())
    }

    public static var memory: MetricComponent {
        .init(title: "Memory:", component: MemoryMetricLabel())
    }

    public static var cpu: MetricComponent {
        .init(title: "CPU: ", component: CPUMetricLabel())
    }
}
