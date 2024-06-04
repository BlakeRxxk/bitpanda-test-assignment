//
//  LeakDetector.swift
//  BitPandaCore
//

import Combine
import UIKit
import OSLog

// MARK: - LeakDetectionStatus

/// Leak detection status.
public enum LeakDetectionStatus {

    /// Leak detection is in progress.
    case inProgress

    /// Leak detection has completed.
    case didComplete
}

// MARK: - LeakDefaultExpectationTime

/// The default time values used for leak detection expectations.
public enum LeakDefaultExpectationTime {

    /// The object deallocation time.
    public static let deallocation = 1.0

    /// The view disappear time.
    public static let viewDisappear = 5.0
}

// MARK: - LeakDetectionHandle

/// The handle for a scheduled leak detection.
public protocol LeakDetectionHandle {

    /// Cancel the scheduled detection.
    func cancel()
}

// MARK: - LeakDetector

/// An expectation based leak detector, that allows an object's owner to set an expectation that an owned object to be
/// deallocated within a time frame.
///
/// A `Router` that owns an `Interactor` might for example expect its `Interactor` be deallocated when the `Router`
/// itself is deallocated. If the interactor does not deallocate in time, a runtime assert is triggered, along with
/// critical logging.
public class LeakDetector {

    // MARK: Lifecycle

    private init() {}

    // MARK: Public

    /// The singleton instance.
    public static let instance = LeakDetector()

    /// The status of leak detection.
    ///
    /// The status changes between InProgress and DidComplete as units register for new detections, cancel existing
    /// detections, and existing detections complete.
    public var status: AnyPublisher<LeakDetectionStatus, Never> {
        expectationCount
            .map { $0 > 0 ? .inProgress : .didComplete }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    /// Sets up an expectation for the given object to be deallocated within the given time.
    ///
    /// - parameter object: The object to track for deallocation.
    /// - parameter inTime: The time the given object is expected to be deallocated within.
    /// - returns: The handle that can be used to cancel the expectation.
    @discardableResult
    public func expectDeallocate(
        object: AnyObject,
        inTime time: TimeInterval = LeakDefaultExpectationTime.deallocation)
        -> LeakDetectionHandle {
        expectationCount.send(expectationCount.value + 1)

        let objectDescription = String(describing: object)
        let objectId = String(ObjectIdentifier(object).hashValue) as NSString
        trackingObjects.setObject(object, forKey: objectId)

        let handle = LeakDetectionHandleImpl {
            self.expectationCount.send(self.expectationCount.value - 1)
        }

        Executor.execute(withDelay: time) {
            // Retain the handle so we can check for the cancelled status. Also cannot use the cancellable
            // concurrency API since the returned handle must be retained to ensure closure is executed.
            if !handle.cancelled {
                let didDeallocate = (self.trackingObjects.object(forKey: objectId) == nil)
                let message =
                    "<\(objectDescription): \(objectId)> has leaked. Objects are expected to be deallocated at this time: \(self.trackingObjects)"

                if self.disableLeakDetector {
                    if !didDeallocate {
                        self.logger.error("Leak detection is disabled. This should only be used for debugging purposes.")
                        self.logger.error("\(message)")
                    }
                } else {
                    assert(didDeallocate, message)
                }
            }

            self.expectationCount.send(self.expectationCount.value - 1)
        }

        return handle
    }

    /// Sets up an expectation for the given view controller to disappear within the given time.
    ///
    /// - parameter viewController: The `UIViewController` expected to disappear.
    /// - parameter inTime: The time the given view controller is expected to disappear.
    /// - returns: The handle that can be used to cancel the expectation.
    @discardableResult
    public func expectViewControllerDisappear(
        viewController: UIViewController,
        inTime time: TimeInterval = LeakDefaultExpectationTime.viewDisappear)
        -> LeakDetectionHandle {
        expectationCount.send(expectationCount.value + 1)

        let handle = LeakDetectionHandleImpl {
            self.expectationCount.send(self.expectationCount.value - 1)
        }

        Executor.execute(withDelay: time) { [weak viewController] in
            // Retain the handle so we can check for the cancelled status. Also cannot use the cancellable
            // concurrency API since the returned handle must be retained to ensure closure is executed.
            if let viewController = viewController, !handle.cancelled {
                let viewDidDisappear = (!viewController.isViewLoaded || viewController.view.window == nil)
                let message =
                    "\(viewController) appearance has leaked. Either its parent router who does not own a view controller was detached, but failed to dismiss the leaked view controller; or the view controller is reused and re-added to window, yet the router is not re-attached but re-created. Objects are expected to be deallocated at this time: \(self.trackingObjects)"

                if self.disableLeakDetector {
                    if !viewDidDisappear {
                        
                        self.logger.error("Leak detection is disabled. This should only be used for debugging purposes.")
                        self.logger.error("\(message)")
                    }
                } else {
                    assert(viewDidDisappear, message)
                }
            }

            self.expectationCount.send(self.expectationCount.value - 1)
        }

        return handle
    }

    // MARK: Internal
    // Test override for leak detectors.
    static var disableLeakDetectorOverride = false

    #if DEBUG
    /// Reset the state of Leak Detector, internal for UI test only.
    func reset() {
        trackingObjects.removeAllObjects()
        expectationCount.send(0)
    }
    #endif

    lazy var disableLeakDetector: Bool = {
        if let environmentValue = ProcessInfo().environment["DISABLE_LEAK_DETECTION"] {
            let lowercase = environmentValue.lowercased()
            return lowercase == "yes" || lowercase == "true"
        }
        return LeakDetector.disableLeakDetectorOverride
    }()

    // MARK: Private

    private let trackingObjects = NSMapTable<AnyObject, AnyObject>.strongToWeakObjects()
    private let expectationCount = CurrentValueSubject<Int, Never>(0)
    private let logger = Logger(subsystem: "leakDetector", category: "Leaks")
}

// MARK: - LeakDetectionHandleImpl

private class LeakDetectionHandleImpl: LeakDetectionHandle {

    // MARK: Lifecycle

    init(cancelClosure: (() -> Void)? = nil) {
        self.cancelClosure = cancelClosure
    }

    // MARK: Internal

    let cancelledSubject = CurrentValueSubject<Bool, Never>(false)
    let cancelClosure: (() -> Void)?

    var cancelled: Bool {
        cancelledSubject.value
    }

    func cancel() {
        cancelledSubject.send(true)
        cancelClosure?()
    }
}
