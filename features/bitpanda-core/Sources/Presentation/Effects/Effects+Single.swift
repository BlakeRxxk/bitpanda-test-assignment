import Foundation

extension Effects {
    public struct Single<Element>: Effect where Element: Sendable {

        // MARK: Lifecycle

        public init(
            priority: TaskPriority? = nil,
            operation: @Sendable @escaping () async -> Element) {
            self.priority = priority
            self.operation = operation
        }

        // MARK: Public

        public var values: AsyncStream<Element> {
            AsyncStream { continuation in
                Task(priority: priority) {
                    let result = await operation()
                    continuation.yield(result)
                    continuation.finish()
                }
            }
        }

        // MARK: Private

        private let priority: TaskPriority?
        private let operation: @Sendable () async -> Element
    }
}
