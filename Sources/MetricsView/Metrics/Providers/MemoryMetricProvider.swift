//
//  MemoryMetricProvider.swift
//
//
//  Created by Damian on 26.05.2024.
//

import Foundation

public final class MemoryMetricProvider: MetricProvider {
    
    public var onReceiveUsedMemory: ((Int) -> Void)? = nil

    private let loop = EventLoop(repeatingInterval: 5)

    public override func start() {
        super.start()
        self.loop.start()
        self.loop.eventHandler = { [weak self] in
            guard let self else { return }
            let memoryValue = self.getMemoryUsageValue()
            self.onReceiveUsedMemory?(memoryValue)
        }
    }

    public override func stop() {
        super.stop()
        self.loop.stop()
    }
    
    public func getMemoryUsageValue() -> Int {
        var taskInfo = task_vm_info_data_t()
        var count = mach_msg_type_number_t(MemoryLayout<task_vm_info>.size) / 4
        let result: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &count)
            }
        }
        var used: UInt64 = 0
        
        if result == KERN_SUCCESS {
            used = UInt64(taskInfo.phys_footprint)
        }
        return Int(used)
    }
}
