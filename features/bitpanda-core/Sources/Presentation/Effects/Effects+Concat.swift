import Foundation

extension Effects {
    public struct Concat<Element>: Effect where Element: Sendable {

        // MARK: Lifecycle

        public init(
            priority: TaskPriority? = nil,
            _ effects: [AnyEffect<Element>]) {
            self.priority = priority
            self.effects = effects
        }

        // MARK: Public

        public var values: AsyncStream<Element> {
            AsyncStream { continuation in
                Task(priority: priority) {
                    for effect in effects {
                        for await value in effect.values {
                            continuation.yield(value)
                        }
                    }
                    continuation.finish()
                }
            }
        }

        // MARK: Private

        private let priority: TaskPriority?
        private let effects: [AnyEffect<Element>]
    }
}
