import Foundation

// MARK: - Effect

public protocol Effect<Element>: Sendable {
    associatedtype Element: Sendable
    var values: AsyncStream<Element> { get }
}

extension Effect {
    public var any: AnyEffect<Element> {
        AnyEffect(self)
    }
}
