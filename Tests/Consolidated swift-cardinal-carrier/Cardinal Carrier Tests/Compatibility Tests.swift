import Cardinal
import Carrier
import Testing

private enum Elements {}

private struct Count<Scope>: Carrier::Carrier.`Protocol`, Equatable {
    typealias Domain = Scope
    let underlying: Cardinal

    init(_ underlying: Cardinal) {
        self.underlying = underlying
    }
}

private struct Word<Value: FixedWidthInteger>: Carrier::Carrier.`Protocol` {
    let underlying: Value

    init(_ underlying: Value) {
        self.underlying = underlying
    }
}

private final class Deaths {
    var count = 0
}

private final class Element {
    let deaths: Deaths
    init(_ deaths: Deaths) { self.deaths = deaths }
    deinit { deaths.count += 1 }
}

private enum InitializerFailure: Swift.Error { case element }

@Suite struct `Cardinal carrier compatibility` {
    @Test
    func `custom carriers preserve counts and arithmetic domains`() throws(Cardinal.Error) {
        typealias Size = Count<Elements>
        var count = Size.zero
        count += .one
        #expect(count.cardinal == Cardinal(1))
        #expect(count.count == Cardinal(1))
        #expect(count + .one == Size(Cardinal(2)))
        let addition: Property::Property<Addition, Size> = count.add
        let subtraction: Property::Property<Subtraction, Size> = count.subtract
        #expect(try addition(.one) == Size(Cardinal(2)))
        #expect(try subtraction(.one) == .zero)
    }

    @Test
    func `custom carriers retain explicit integer conversion semantics`() {
        let large = Count<Elements>(Cardinal(UInt.max))
        #expect(Int(bitPattern: large) == -1)
        #expect(UInt32(Count<Elements>(Cardinal(UInt(UInt32.max)))) == UInt32.max)
    }

    @Test
    func `signed and unsigned carrier shifts retain their operand types`() {
        let count = Count<Elements>(Cardinal(1))
        var signed = Word(Int8(-4))
        var unsigned = Word(UInt8(4))
        #expect((signed >> count).underlying == -2)
        #expect((unsigned << count).underlying == 8)
        signed >>= count
        signed <<= count
        unsigned <<= count
        unsigned >>= count
        #expect(signed.underlying == -4)
        #expect(unsigned.underlying == 4)
    }

    @Test
    func `compatibility shifts reject a count equal to the integer width`() async {
        await #expect(processExitsWith: .failure) {
            var value = Word(UInt8(1))
            value <<= Count<Elements>(Cardinal(8))
            precondition(value.underlying == 0)
        }
    }

    @Test
    func `collections accept domain typed counts and oversized representable slices`() {
        let two = Count<Elements>(Cardinal(2))
        let large = Count<Elements>(Cardinal(UInt(Int.max)))
        var values = Array(repeating: 7, count: two)
        #expect(values == [7, 7])
        #expect(ContiguousArray(repeating: 7, count: two) == [7, 7])
        #expect(Array(values.prefix(large)) == values)
        #expect(values.dropFirst(large).isEmpty)
        values.reserveCapacity(two)
        values.removeFirst(Count<Elements>.one)
        values.removeLast(Count<Elements>.one)
        #expect(values.isEmpty)
        #expect(String(repeating: "a", count: two) == "aa")
    }

    @Test(arguments: [false, true])
    func `typed factories return exactly their initialized prefix`(contiguous: Bool) {
        let capacity = Count<Elements>(Cardinal(3))
        let initialize = { (buffer: inout UnsafeMutableBufferPointer<Int>, count: inout Count<Elements>) in
            unsafe buffer.baseAddress!.initialize(to: 23)
            count = .one
        }
        let values: [Int]
        if contiguous {
            values = unsafe Array(ContiguousArray(unsafeUninitializedCapacity: capacity, initializingWith: initialize))
        } else {
            values = unsafe Array(unsafeUninitializedCapacity: capacity, initializingWith: initialize)
        }
        #expect(values == [23])
    }

    @Test(arguments: [false, true])
    func `throwing typed factories destroy their initialized prefix`(contiguous: Bool) {
        let deaths = Deaths()
        let capacity = Count<Elements>(Cardinal(2))
        let initialize = { (buffer: inout UnsafeMutableBufferPointer<Element>, count: inout Count<Elements>) throws(InitializerFailure) in
            unsafe buffer.baseAddress!.initialize(to: Element(deaths))
            count = .one
            throw .element
        }
        #expect(throws: InitializerFailure.element) {
            if contiguous {
                let _ = try unsafe ContiguousArray(unsafeUninitializedCapacity: capacity, initializingWith: initialize)
            } else {
                let _ = try unsafe Array(unsafeUninitializedCapacity: capacity, initializingWith: initialize)
            }
        }
        #expect(deaths.count == 1)
    }
}
