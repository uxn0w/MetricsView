//
//  MetricLabel.swift
//  
//
//  Created by Damian on 29.05.2024.
//

import UIKit

open class MetricLabel<Provider: MetricProvider>: UILabel {
    
    let provider: Provider = Provider.init()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = .systemFont(ofSize: 10)
        self.textColor = .label
        self.textAlignment = .right

    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.provider.stop()
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview != nil else { return }
        self.provider.start()
    }
}

open class BaseMetricView<Provider: MetricProvider>: UIView {
    
    let provider: Provider = Provider.init()
    
    deinit {
        self.provider.stop()
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview != nil else { return }
        self.provider.start()
    }
}
