//
//  MultiStageComponentizedBuilder.swift
//  BitPandaCore
//

import Foundation

// MARK: - MultiStageComponentizedBuilder

/// The base class of a builder that involves multiple stages of building
/// a RIB. Witin the same pass, accesses to the component property shares
/// the same instance. Once `finalStageBuild` is invoked, a new instance
/// is returned from the component property, representing a new pass of
/// the multi-stage building process.
///
/// - SeeAlso: SimpleMultiStageComponentizedBuilder
open class MultiStageComponentizedBuilder<Component, Router, DynamicBuildDependency>: Buildable {

    // MARK: Lifecycle

    /// Initializer.
    ///
    /// - parameter componentBuilder: The closure to instantiate a new
    /// instance of the DI component that should be paired with this RIB.
    public init(componentBuilder: @escaping () -> Component) {
        self.componentBuilder = componentBuilder
    }

    // MARK: Open

    /// Abstract method that must be overriden to implement the RIB building
    /// logic using the given component and dynamic dependency, as the last
    /// building stage.
    ///
    /// - note: This method should never be invoked directly. Instead
    /// consumers of this builder should invoke `finalStageBuild(with dynamicDependency:)`.
    /// - parameter component: The corresponding DI component to use.
    /// - parameter dynamicDependency: The given dynamic dependency.
    /// - returns: The router of the RIB.
    open func finalStageBuild(with _: Component, _: DynamicBuildDependency) -> Router {
        fatalError("This method should be overridden by the subclass.")
    }

    // MARK: Public

    // Builder should not directly retain an instance of the component.
    // That would make the component's lifecycle longer than the built
    // RIB. Instead, whenever a new instance of the RIB is built, a new
    // instance of the DI component should also be instantiated.

    /// The DI component used for the current iteration of the multi-
    /// stage build process. Once `finalStageBuild` method is invoked,
    /// this property returns a separate new instance representing a
    /// new pass of the multi-stage building process.
    public var componentForCurrentBuildPass: Component {
        if let currentPassComponent = currentPassComponent {
            return currentPassComponent
        } else {
            let currentPassComponent = componentBuilder()

            // Ensure each invocation of componentBuilder produces a new
            // component instance.
            let newComponent = currentPassComponent as AnyObject
            if lastComponent === newComponent {
                assertionFailure("\(self) componentBuilder should produce new instances of component when build is invoked.")
            }
            lastComponent = newComponent

            self.currentPassComponent = currentPassComponent
            return currentPassComponent
        }
    }

    /// Build a new instance of the RIB with the given dynamic dependency
    /// as the last stage of this mult-stage building process.
    ///
    /// - note: Subsequent access to the `component` property after this
    /// method is returned will result in a separate new instance of the
    /// component, representing a new pass of the multi-stage building
    /// process.
    /// - parameter dynamicDependency: The dynamic dependency to use.
    /// - returns: The router of the RIB.
    public final func finalStageBuild(withDynamicDependency dynamicDependency: DynamicBuildDependency) -> Router {
        let router = finalStageBuild(with: componentForCurrentBuildPass, dynamicDependency)
        defer {
            currentPassComponent = nil
        }
        return router
    }

    // MARK: Private

    private let componentBuilder: () -> Component
    private var currentPassComponent: Component?
    private weak var lastComponent: AnyObject?
}

// MARK: - SimpleMultiStageComponentizedBuilder

/// A convenient base multi-stage builder class that does not require any
/// build dynamic dependencies.
///
/// - note: If the build method requires dynamic dependency, please
/// refer to `MultiStageComponentizedBuilder`.
///
/// - SeeAlso: MultiStageComponentizedBuilder
open class SimpleMultiStageComponentizedBuilder<Component, Router>: MultiStageComponentizedBuilder<Component, Router, ()> {

    // MARK: Lifecycle

    /// Initializer.
    ///
    /// - parameter componentBuilder: The closure to instantiate a new
    /// instance of the DI component that should be paired with this RIB.
    public override init(componentBuilder: @escaping () -> Component) {
        super.init(componentBuilder: componentBuilder)
    }

    // MARK: Open

    /// Abstract method that must be overriden to implement the RIB building
    /// logic using the given component.
    ///
    /// - note: This method should never be invoked directly. Instead
    /// consumers of this builder should invoke `finalStageBuild()`.
    /// - parameter component: The corresponding DI component to use.
    /// - returns: The router of the RIB.
    open func finalStageBuild(with _: Component) -> Router {
        fatalError("This method should be overridden by the subclass.")
    }

    // MARK: Public

    /// This method should not be directly invoked.
    public final override func finalStageBuild(with component: Component, _: ()) -> Router {
        finalStageBuild(with: component)
    }

    /// Build a new instance of the RIB as the last stage of this mult-
    /// stage building process.
    ///
    /// - note: Subsequent access to the `component` property after this
    /// method is returned will result in a separate new instance of the
    /// component, representing a new pass of the multi-stage building
    /// process.
    /// - returns: The router of the RIB.
    public final func finalStageBuild() -> Router {
        finalStageBuild(withDynamicDependency: ())
    }
}
