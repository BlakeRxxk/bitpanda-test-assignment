import Foundation

// MARK: - AnyEffect

public struct AnyEffect<Element>: Effect where Element: Sendable {
    public var values: AsyncStream<Element> { base.values }

    private var base: any Effect<Element>

    public init<Base>(_ base: Base) where Base: Effect, Base.Element == Element {
        self.base = base
    }
}

extension AnyEffect {
    @inlinable
    public static var none: AnyEffect<Element> {
        Effects.Empty().any
    }

    @inlinable
    public static func just(_ element: Element) -> AnyEffect<Element> {
        Effects.Just(element).any
    }

    @inlinable
    public static func single(
        priority: TaskPriority? = nil,
        operation: @Sendable @escaping () async -> Element) -> AnyEffect<Element> {
        Effects.Single(priority: priority, operation: operation).any
    }

    @inlinable
    public static func sequence(
        priority: TaskPriority? = nil,
        operation: @Sendable @escaping ((Element) -> Void) async -> Void) -> AnyEffect<Element> {
        Effects.Sequence(priority: priority, operation: operation).any
    }

    @inlinable
    public static func concat(
        priority: TaskPriority? = nil,
        _ effects: AnyEffect<Element>...) -> AnyEffect<Element> {
        Effects.Concat(priority: priority, effects).any
    }

    @inlinable
    public static func merge(priority: TaskPriority? = nil, _ effects: AnyEffect<Element>...) -> AnyEffect<Element> {
        Effects.Merge(priority: priority, effects).any
    }
}
