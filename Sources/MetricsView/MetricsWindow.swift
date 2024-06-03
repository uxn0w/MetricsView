//
//  MetricsWindow.swift
//  ACUICalendarDemo
//
//  Created by Damian on 26.05.2024.
//

import UIKit
import Foundation

open class MetricsWindow: UIWindow {

    public private(set) var metricsView = MetricsView()

    public var metrics: [MetricComponent] {
        get { metricsView.metrics }
        set { metricsView.metrics = newValue }
    }

    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        if !(view is MetricsView) {
            self.bringSubviewToFront(metricsView)
        }
    }

    open override func makeKeyAndVisible() {
        super.makeKeyAndVisible()
        if metricsView.superview == nil {
            self.addSubview(metricsView)
        }
    }
}
