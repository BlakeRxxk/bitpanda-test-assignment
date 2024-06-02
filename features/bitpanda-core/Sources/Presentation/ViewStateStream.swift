import Foundation

// MARK: - ViewStateStream

@MainActor
@dynamicMemberLookup
public final class ViewStateStream<State>: AsyncSequence where State: Sendable & Equatable {

    // MARK: Lifecycle

    public init(_ upstream: AsyncStream<Element>) {
        self.upstream = upstream
    }

    deinit {
        continuations.forEach { $0.finish() }
    }

    // MARK: Public

    public typealias Element = State

    public struct Iterator: AsyncIteratorProtocol {
        public typealias Element = State

        @usableFromInline
        var iterator: AsyncStream<Element>.Iterator

        @usableFromInline
        init(_ iterator: AsyncStream<Element>.Iterator) {
            self.iterator = iterator
        }

        @inlinable
        public mutating func next() async -> Element? {
            await iterator.next()
        }
    }

    @inlinable
    public nonisolated func makeAsyncIterator() -> Iterator {
        Iterator(upstream.makeAsyncIterator())
    }

    public subscript<Property>(dynamicMember keyPath: KeyPath<State, Property>)
        -> AsyncMapSequence<AsyncStream<State>, Property> {
        let (stream, continuation) = AsyncStream<Element>.makeStream()
        continuations.append(continuation)
        if let last {
            continuation.yield(last)
        }
        return stream.map { $0[keyPath: keyPath] }
    }

    // MARK: Internal

    @usableFromInline
    let upstream: AsyncStream<Element>

    func send(_ element: Element) {
        last = element
        for continuation in continuations {
            continuation.yield(element)
        }
    }

    // MARK: Private

    private var continuations: [AsyncStream<Element>.Continuation] = []
    private var last: Element?

}

// MARK: Sendable

extension ViewStateStream: Sendable where State: Sendable { }
