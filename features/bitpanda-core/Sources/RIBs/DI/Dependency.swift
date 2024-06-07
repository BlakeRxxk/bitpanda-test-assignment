//
//  Dependency.swift
//  BitPandaCore
//

import Foundation

// MARK: - Dependency

/// The base dependency protocol.
///
/// Subclasses should define a set of properties that are required by the module from the DI graph. A dependency is
/// typically provided and satisfied by its immediate parent module.
public protocol Dependency: AnyObject {}

// MARK: - EmptyDependency

/// The special empty dependency.
public protocol EmptyDependency: Dependency {}
