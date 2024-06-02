import Foundation

extension Effects {
    public struct Empty<Element>: Effect where Element: Sendable {

        public init() { }

        public var values: AsyncStream<Element> {
            AsyncStream { continuation in
                continuation.finish()
            }
        }
    }
}
