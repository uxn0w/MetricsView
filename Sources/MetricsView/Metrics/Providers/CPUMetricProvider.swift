//
//  CPUMetricProvider.swift
//  
//
//  Created by Damian on 27.05.2024.
//

import Foundation

public final class CPUMetricProvider: MetricProvider {
    
    public var onReceiveUsedCPU: ((Double) -> Void)?
    
    private let loop = EventLoop(repeatingInterval: 2)
    
    public override func start() {
        super.start()
        self.loop.start()
        self.loop.eventHandler = { [weak self] in
            guard let self else { return }
            let value = self.getCpuUsageValue()
            self.onReceiveUsedCPU?(value)
        }
    }
    
    public override func stop() {
        self.loop.stop()
    }
    
    public func getCpuUsageValue() -> Double {
        var totalUsageOfCPU: Double = 0.0
        var threadsList: thread_act_array_t?
        var threadsCount = mach_msg_type_number_t(0)
        let threadsResult = withUnsafeMutablePointer(to: &threadsList) {
            return $0.withMemoryRebound(to: thread_act_array_t?.self, capacity: 1) {
                task_threads(mach_task_self_, $0, &threadsCount)
            }
        }
        if threadsResult == KERN_SUCCESS, let threadsList = threadsList {
            for index in 0..<threadsCount {
                var threadInfo = thread_basic_info()
                var threadInfoCount = mach_msg_type_number_t(THREAD_INFO_MAX)
                let infoResult = withUnsafeMutablePointer(to: &threadInfo) {
                    $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                        thread_info(
                            threadsList[Int(index)],
                            thread_flavor_t(THREAD_BASIC_INFO),
                            $0,
                            &threadInfoCount
                        )
                    }
                }
                guard infoResult == KERN_SUCCESS else { break }
                
                let threadBasicInfo = threadInfo as thread_basic_info
                if threadBasicInfo.flags & TH_FLAGS_IDLE == 0 {
                    totalUsageOfCPU = (
                        totalUsageOfCPU + (
                            Double(threadBasicInfo.cpu_usage) / Double(TH_USAGE_SCALE) * 100.0
                        )
                    )
                }
            }
        }
        vm_deallocate(
            mach_task_self_,
            vm_address_t(UInt(bitPattern: threadsList)),
            vm_size_t(Int(threadsCount) * MemoryLayout<thread_t>.stride)
        )
        return totalUsageOfCPU
    }
}
