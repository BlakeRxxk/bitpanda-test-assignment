import Foundation

extension Effects {
    public struct Sequence<Element>: Effect where Element: Sendable {

        // MARK: Lifecycle

        public init(
            priority: TaskPriority? = nil,
            operation: @Sendable @escaping ((Element) -> Void) async -> Void) {
            self.priority = priority
            self.operation = operation
        }

        // MARK: Public

        public var values: AsyncStream<Element> {
            AsyncStream { continuation in
                Task(priority: priority) {
                    await operation { element in
                        continuation.yield(element)
                    }
                    continuation.finish()
                }
            }
        }

        // MARK: Private

        private let priority: TaskPriority?
        private let operation: @Sendable ((Element) -> Void) async -> Void
    }
}
