//
//  Component.swift
//  BitPandaCore
//

import Foundation

// MARK: - Component

/// The base class for all components.
///
/// A component defines private properties a RIB provides to its internal `Router`, `Interactor`, `Presenter` and
/// view units, as well as public properties to its child RIBs.
///
/// A component subclass implementation should conform to child 'Dependency' protocols, defined by all of its immediate
/// children.

// swiftlint:disable identifier_name
open class Component<DependencyType>: Dependency {

    // MARK: Lifecycle

    /// Initializer.
    ///
    /// - parameter dependency: The dependency of this `Component`, usually provided by the parent `Component`.
    public init(dependency: DependencyType) {
        self.dependency = dependency
    }

    // MARK: Public

    /// The dependency of this `Component`.
    public let dependency: DependencyType

    /// Used to create a shared dependency in your `Component` sub-class. Shared dependencies are retained and reused
    /// by the component. Each dependent asking for this dependency will receive the same instance while the component
    /// is alive.
    ///
    /// - note: Any shared dependency's constructor may not switch threads as this might cause a deadlock.
    ///
    /// - parameter factory: The closure to construct the dependency.
    /// - returns: The instance.
    public final func shared<T>(__function: String = #function, _ factory: () -> T) -> T {
        lock.lock()
        defer {
            lock.unlock()
        }

        // Additional nil coalescing is needed to mitigate a Swift bug appearing in Xcode 10.
        // see https://bugs.swift.org/browse/SR-8704.
        // Without this measure, calling `shared` from a function that returns an optional type
        // will always pass the check below and return nil if the instance is not initialized.
        if let instance = (sharedInstances[__function] as? T?) ?? nil {
            return instance
        }

        let instance = factory()
        sharedInstances[__function] = instance

        return instance
    }

    // MARK: Private

    private var sharedInstances = [String: Any]()
    private let lock = NSRecursiveLock()
}

// MARK: - EmptyComponent

open class EmptyComponent: EmptyDependency {
    public init() {}
}
