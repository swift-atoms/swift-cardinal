import Cardinal
import Testing

private final class Deaths {
    var count = 0
}

private final class Element {
    let deaths: Deaths
    init(_ deaths: Deaths) { self.deaths = deaths }
    deinit { deaths.count += 1 }
}

private enum ElementFailure: Swift.Error { case element }

@Suite(.timeLimit(.minutes(1)))
struct `Count adapters preserve storage and ownership boundaries` {
    @Test
    func `reserve capacity cannot reinterpret a positive count`() async {
        await #expect(processExitsWith: .failure) {
            var collection = RecordingCollection()
            collection.reserveCapacity(Cardinal(UInt.max))
            precondition(collection.requestedCapacity == -1)
        }
    }

    @Test
    func `throwing array initialization destroys the initialized prefix`() async {
        await #expect(processExitsWith: .success) {
            let deaths = Deaths()
            func build() throws(ElementFailure) -> [Element] {
                try unsafe Array(unsafeUninitializedCapacity: Cardinal(2)) {
                    (buffer, count) throws(ElementFailure) in
                    unsafe buffer.baseAddress!.initialize(to: Element(deaths))
                    count = Cardinal(1)
                    throw .element
                }
            }
            do {
                _ = try build()
                preconditionFailure("The element initializer must throw")
            } catch {
                precondition(deaths.count == 1)
            }
        }
    }

    @Test
    func `throwing contiguous initialization destroys the initialized prefix`() async {
        await #expect(processExitsWith: .success) {
            let deaths = Deaths()
            func build() throws(ElementFailure) -> ContiguousArray<Element> {
                try unsafe ContiguousArray(unsafeUninitializedCapacity: Cardinal(2)) {
                    (buffer, count) throws(ElementFailure) in
                    unsafe buffer.baseAddress!.initialize(to: Element(deaths))
                    count = Cardinal(1)
                    throw .element
                }
            }
            do {
                _ = try build()
                preconditionFailure("The element initializer must throw")
            } catch {
                precondition(deaths.count == 1)
            }
        }
    }
}

private struct RecordingCollection: RangeReplaceableCollection {
    var values: [Int] = []
    var requestedCapacity: Int?
    var startIndex: Int { values.startIndex }
    var endIndex: Int { values.endIndex }
    func index(after i: Int) -> Int { i + 1 }
    subscript(i: Int) -> Int { values[i] }
    mutating func reserveCapacity(_ capacity: Int) { requestedCapacity = capacity }
    mutating func replaceSubrange<C: Collection>(
        _ subrange: Range<Int>, with newElements: C
    ) where C.Element == Int {
        values.replaceSubrange(subrange, with: newElements)
    }
}
