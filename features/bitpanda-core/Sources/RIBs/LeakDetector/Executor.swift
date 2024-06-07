//
//  Executor.swift
//  BitPandaCore
//

import Combine
import Dispatch
import Foundation

// MARK: - Executor

public enum Executor {

    /// Execute the given logic after the given delay assuming the given maximum frame duration.
    ///
    /// This allows excluding the time elapsed due to breakpoint pauses.
    ///
    /// - note: The logic closure is not guaranteed to be performed exactly after the given delay. It may be performed
    ///   later if the actual frame duration exceeds the given maximum frame duration.
    ///
    /// - parameter delay: The delay to perform the logic, excluding any potential elapsed time due to breakpoint
    ///   pauses.
    /// - parameter maxFrameDuration: The maximum duration a single frame should take. Defaults to 33ms.
    /// - parameter logic: The closure logic to perform.
    public static func execute(withDelay delay: TimeInterval, maxFrameDuration: Int = 33, logic: @escaping () -> Void) {
        let period = DispatchTimeInterval.milliseconds(maxFrameDuration / 3)
        let timeInterval = TimeInterval(dispatchTimeInterval: period) ?? 0
        var lastRunLoopTime = Date().timeIntervalSinceReferenceDate
        var properFrameTime = 0.0
        var didExecute = false
        _ = Timer
            .publish(every: timeInterval, on: .main, in: .tracking)
            .prefix(while: { _ in
                !didExecute
            })
            .sink(receiveValue: { _ in
                let currentTime = Date().timeIntervalSinceReferenceDate
                let trueElapsedTime = currentTime - lastRunLoopTime
                lastRunLoopTime = currentTime

                // If we did drop frame, we under-count the frame duration, which is fine. It
                // just means the logic is performed slightly later.
                let boundedElapsedTime = min(trueElapsedTime, Double(maxFrameDuration) / 1000)
                properFrameTime += boundedElapsedTime
                if properFrameTime > delay {
                    didExecute = true

                    logic()
                }
            })
    }
}

extension TimeInterval {

    init?(dispatchTimeInterval: DispatchTimeInterval) {
        switch dispatchTimeInterval {
        case .seconds(let value):
            self = Double(value)
        case .milliseconds(let value):
            self = Double(value) / 1_000
        case .microseconds(let value):
            self = Double(value) / 1_000_000
        case .nanoseconds(let value):
            self = Double(value) / 1_000_000_000
        case .never:
            return nil
        @unknown default:
            return nil
        }
    }

}
