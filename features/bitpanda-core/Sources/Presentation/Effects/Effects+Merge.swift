import Foundation

extension Effects {
    public struct Merge<Element>: Effect where Element: Sendable {

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
                    if #available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *) {
                        await withDiscardingTaskGroup { group in
                            for effect in effects {
                                group.addTask {
                                    for await value in effect.values {
                                        continuation.yield(value)
                                    }
                                }
                            }
                        }
                        continuation.finish()
                    } else {
                        await withTaskGroup(of: Void.self) { group in
                            for effect in effects {
                                group.addTask {
                                    for await value in effect.values {
                                        continuation.yield(value)
                                    }
                                }
                            }
                        }
                        continuation.finish()
                    }
                }
            }
        }

        // MARK: Private

        private let priority: TaskPriority?
        private let effects: [AnyEffect<Element>]

    }
}
