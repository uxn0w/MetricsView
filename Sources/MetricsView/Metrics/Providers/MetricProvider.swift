//
//  MetricProvider.swift
//  
//
//  Created by Damian on 30.05.2024.
//

import UIKit
import Foundation

open class MetricProvider {
    
    let notificationCenter = NotificationCenter.default
    
    var applicationStateIsActive = true
    
    public required init() { }
    
    
    open func start() {
        self.stop()
        self.notificationCenter.addObserver(
            self,
            selector: #selector(appicationStateWillResignActive),
            name: UIApplication.willResignActiveNotification, object: nil
        )
        self.notificationCenter.addObserver(
            self,
            selector: #selector(appicationStateDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification, object: nil
        )
    }
    
    open func stop() { }
    
    @objc func appicationStateWillResignActive() {
        self.stop()
        self.applicationStateIsActive = false
    }
    
    @objc func appicationStateDidBecomeActive() {
        if !applicationStateIsActive {
            self.start()
            self.applicationStateIsActive.toggle()
        }
    }
}
