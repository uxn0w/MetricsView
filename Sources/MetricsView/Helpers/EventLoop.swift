//
//  EventLoop.swift
//
//
//  Created by Damian on 29.05.2024.
//

import Foundation

public class EventLoop {

    private var timer : DispatchSourceTimer?
    private var queue = DispatchQueue(label: "reactor.queue", qos: .background, attributes: .concurrent)

    public var eventHandler: (() -> Void)?
    public var repeatingInterval: Double

    init(repeatingInterval: Double = 10) {
        self.repeatingInterval = repeatingInterval
    }

    public func start() {
        guard timer == nil else { return }
        self.timer = DispatchSource.makeTimerSource(queue: queue)
        self.timer?.schedule(deadline: .now(), repeating: repeatingInterval)
        self.timer?.setEventHandler { [weak self] in
            self?.eventHandler?()
        }
        self.timer?.resume()
    }

    public func stop() {
        self.timer?.cancel()
        self.timer = nil
    }
}
