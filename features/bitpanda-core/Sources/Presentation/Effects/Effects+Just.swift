import Foundation

extension Effects {
    public struct Just<Element>: Effect where Element: Sendable {
        private let element: Element

        public init(_ element: Element) {
            self.element = element
        }

        public var values: AsyncStream<Element> {
            AsyncStream { continuation in
                continuation.yield(element)
                continuation.finish()
            }
        }
    }
}
