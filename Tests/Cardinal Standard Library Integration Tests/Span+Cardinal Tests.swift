import Testing

import Cardinal_Standard_Library_Integration

@Suite("Span+Cardinal / MutableSpan+Cardinal")
struct Tests {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension Tests.Unit {
    @Test
    func `Span typed-Cardinal init reads the underlying buffer`() {
        let values: [Int] = [10, 20, 30]
        values.withUnsafeBufferPointer { buffer in
            let span = unsafe Swift.Span(
                _unsafeStart: buffer.baseAddress!,
                count: Cardinal::Cardinal(3 as UInt)
            )
            #expect(span.count == 3)
            #expect(span[0] == 10)
            #expect(span[1] == 20)
            #expect(span[2] == 30)
        }
    }

    @Test
    func `MutableSpan typed-Cardinal init reads and mutates the underlying buffer`() {
        var values: [Int] = [1, 2, 3]
        values.withUnsafeMutableBufferPointer { buffer in
            var span = unsafe Swift.MutableSpan(
                _unsafeStart: buffer.baseAddress!,
                count: Cardinal::Cardinal(3 as UInt)
            )
            #expect(span.count == 3)
            span[0] = 99
        }
        #expect(values[0] == 99)
        #expect(values[1] == 2)
        #expect(values[2] == 3)
    }
}

extension Tests.`Edge Case` {
    @Test
    func `Span typed-Cardinal init with zero count is empty`() {
        let values: [Int] = [7]
        values.withUnsafeBufferPointer { buffer in
            let span = unsafe Swift.Span(
                _unsafeStart: buffer.baseAddress!,
                count: .zero
            )

            let count = span.count
            let isEmpty = span.isEmpty
            #expect(count == 0)
            #expect(isEmpty)
        }
    }

    @Test
    func `MutableSpan typed-Cardinal init with zero count is empty`() {
        var values: [Int] = [7]
        values.withUnsafeMutableBufferPointer { buffer in
            let span = unsafe Swift.MutableSpan(
                _unsafeStart: buffer.baseAddress!,
                count: .zero
            )

            let count = span.count
            let isEmpty = span.isEmpty
            #expect(count == 0)
            #expect(isEmpty)
        }
    }
}
