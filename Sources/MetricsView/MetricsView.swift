//
//  MetricsView.swift
//
//  Created by Damian on 26.05.2024.
//

import UIKit

open class MetricsView: DraggableView {

    // MARK: Components
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()

    public var backgroundView: UIView = {
        let view = UIView()
        view.alpha = 0.3
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 8
        return view
    }() {
        didSet {
            self.setupComponents()
        }
    }

    private var screenSizeValueLabel = MetricLabel()

    // MARK: Properties
    var metrics = [MetricComponent]() {
        didSet {
            self.setupComponents()
        }
    }

    // MARK: - Initialization
    convenience init(metrics: [MetricComponent]) {
        self.init(frame: .zero)
        self.metrics = metrics
    }

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: 100, width: 200, height: 100))
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup methods
    private func setupComponents() {
        self.subviews.forEach({ $0.removeFromSuperview() })
        self.contentStackView.removeAllArrangedSubviews()
        self.setupBackgroundView()
        self.setupScreenSizeLabel()
        self.setupContentView()

        self.screenSizeValueLabel.text = "iOS \(UIDevice.current.systemVersion): [\(UIScreen.main.bounds.width)x\(UIScreen.main.bounds.height)]"
        self.contentStackView.frame.size.height = 0

        self.metrics.forEach({ metric in
            let titleStackView = makeTitleValueStackView(title: metric.title, valueView: metric.component)
            self.contentStackView.addArrangedSubview(titleStackView)
            self.contentStackView.frame.size.height += titleStackView.frame.size.height
        })
        self.setNeedsLayout()
    }

    private func setupScreenSizeLabel() {
        self.addSubview(screenSizeValueLabel)
    }

    private func setupBackgroundView() {
        self.addSubview(backgroundView)
        self.backgroundView.frame = self.bounds
    }

    private func setupContentView() {
        self.addSubview(contentStackView)
        self.contentStackView.frame = .init(
            x: 8, y: screenSizeValueLabel.frame.maxY + 8,
            width: screenSizeValueLabel.frame.width, height: contentStackView.frame.size.height
        )
    }

    // MARK: - Lifecycle methods
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview != nil && backgroundView.superview == nil else { return }
        self.setupComponents()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        self.screenSizeValueLabel.frame = .init(
            origin: .init(x: 8, y: 8),
            size: .init(width: self.frame.width - 16, height: 12)
        )
        self.contentStackView.frame = .init(
            origin: .init(x: 8, y: screenSizeValueLabel.frame.maxY + 8),
            size: .init(
                width: screenSizeValueLabel.frame.width,
                height: contentStackView.frame.size.height
            )
        )
        self.frame.size.height = contentStackView.frame.maxY + 8
        self.backgroundView.frame = self.bounds
    }

    // MARK: - Components factory
    private func makeTitleValueStackView(title: String, valueView: UIView) -> UIView {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 10)
        titleLabel.textColor = .label
        titleLabel.text = title
        let stackView = UIStackView(arrangedSubviews: [titleLabel, valueView])
        stackView.frame.size.height = 12
        return stackView
    }
}
