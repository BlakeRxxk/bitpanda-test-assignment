//
//  Builder.swift
//  BitPandaCore
//

import Foundation

// MARK: - Buildable

/// The base builder protocol that all builders should conform to.
public protocol Buildable: AnyObject {}

// MARK: - Builder

/// Utility that instantiates a RIB and sets up its internal wirings.
open class Builder<DependencyType>: Buildable {

    // MARK: Lifecycle

    /// Initializer.
    ///
    /// - parameter dependency: The dependency used for this builder to build the RIB.
    public init(dependency: DependencyType) {
        self.dependency = dependency
    }

    // MARK: Public

    /// The dependency used for this builder to build the RIB.
    public let dependency: DependencyType

}
