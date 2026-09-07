import Cardinal
import Carrier
import Tagged
import Testing

private struct StorageDomain: ~Copyable, ~Escapable {}

private struct Count<Scope: ~Copyable & ~Escapable>: Carrier.`Protocol` {
    typealias Domain = Scope
    let underlying: Cardinal
    init(_ underlying: Cardinal) { self.underlying = underlying }
}

@Suite struct `Representable storage counts retain existing behavior` {
    @Test(arguments: [0 as UInt, 1, 3])
    func `repetition accepts bare tagged and custom counts`(raw: UInt) {
        let bare = Cardinal(raw)
        let tagged = Tagged<StorageDomain, Cardinal>(bare)
        let custom = Count<StorageDomain>(bare)
        #expect(Array(repeating: 7, count: tagged) == Array(repeating: 7, count: Int(raw)))
        #expect(ContiguousArray(repeating: 7, count: custom).count == Int(raw))
        #expect(String(repeating: "ab", count: bare) == String(repeating: "ab", count: Int(raw)))
    }

    @Test(arguments: [0 as UInt, 1, 3, UInt(Int.max)])
    func `collection slicing preserves representable oversized counts`(raw: UInt) {
        let values = [10, 20, 30]
        let count = Count<StorageDomain>(Cardinal(raw))
        #expect(Array(values.prefix(count)) == Array(values.prefix(Int(raw))))
        #expect(Array(values.suffix(count)) == Array(values.suffix(Int(raw))))
        #expect(Array(values.dropFirst(count)) == Array(values.dropFirst(Int(raw))))
        #expect(Array(values.dropLast(count)) == Array(values.dropLast(Int(raw))))
    }

    @Test
    func `reserve and removal preserve collection values`() {
        let two = Tagged<StorageDomain, Cardinal>(Cardinal(2))
        var values = [10, 20, 30, 40]
        values.reserveCapacity(two)
        values.removeFirst(two)
        values.removeLast(Cardinal(1))
        #expect(values == [30])
        var set = Set<Int>(minimumCapacity: two)
        set.insert(3)
        set.reserveCapacity(Cardinal(4))
        #expect(set == Set([3]))
        var dictionary = Dictionary<Int, Int>(minimumCapacity: two)
        dictionary[3] = 4
        dictionary.reserveCapacity(Cardinal(4))
        #expect(dictionary == [3: 4])
    }

    @Test(arguments: [0 as UInt, 1, 3])
    func `uninitialized factories retain count domains and initialized prefixes`(raw: UInt) {
        let count = Count<StorageDomain>(Cardinal(raw))
        let values: [Int] = unsafe Array(unsafeUninitializedCapacity: count) { buffer, initialized in
            #expect(initialized.underlying == .zero)
            #expect(buffer.count == Int(raw))
            for i in 0..<Int(raw) {
                unsafe buffer.baseAddress!.advanced(by: i).initialize(to: i + 10)
            }
            initialized = Count(Cardinal(raw))
        }
        #expect(values == (0..<Int(raw)).map { $0 + 10 })

        let contiguous: ContiguousArray<Int> = unsafe ContiguousArray(
            unsafeUninitializedCapacity: Tagged<StorageDomain, Cardinal>(Cardinal(3))
        ) { buffer, initialized in
            unsafe buffer.baseAddress!.initialize(to: 99)
            initialized = Tagged<StorageDomain, Cardinal>(Cardinal(1))
        }
        #expect(Array(contiguous) == [99])
    }

    @Test
    func `buffers spans and raw storage accept empty and valid counts`() {
        let zero = Cardinal.zero
        let empty = unsafe UnsafeBufferPointer<Int>(start: nil, count: zero)
        let emptyMutable = unsafe UnsafeMutableBufferPointer<Int>(start: nil, count: zero)
        let emptyRaw = unsafe UnsafeRawBufferPointer(start: nil, count: zero)
        let emptyMutableRaw = unsafe UnsafeMutableRawBufferPointer(start: nil, count: zero)
        #expect(empty.count == 0)
        #expect(emptyMutable.count == 0)
        #expect(emptyRaw.count == 0)
        #expect(emptyMutableRaw.count == 0)

        var values: [UInt8] = [10, 20, 30]
        values.withUnsafeMutableBufferPointer { buffer in
            let pointer = buffer.baseAddress!
            let rawPointer = UnsafeMutableRawPointer(pointer)
            let count = Count<StorageDomain>(Cardinal(3))
            let immutable = unsafe UnsafeBufferPointer(start: UnsafePointer(pointer), count: count)
            let mutable = unsafe UnsafeMutableBufferPointer(start: pointer, count: count)
            let raw = unsafe UnsafeRawBufferPointer(start: UnsafeRawPointer(rawPointer), count: count)
            let mutableRaw = unsafe UnsafeMutableRawBufferPointer(start: rawPointer, count: count)
            #expect(unsafe immutable[2] == 30)
            unsafe mutable[1] = 21
            #expect(unsafe raw[1] == 21)
            unsafe mutableRaw[0] = 11
            let span = unsafe RawSpan(_unsafeStart: UnsafeRawPointer(rawPointer), byteCount: count)
            let mutableSpan = unsafe MutableRawSpan(_unsafeStart: rawPointer, byteCount: count)
            #expect(span.byteCount == 3)
            #expect(mutableSpan.byteCount == 3)
        }
        #expect(values == [11, 21, 30])
    }

    @Test
    func `typed allocation preserves capacity and alignment`() {
        let buffer = unsafe UnsafeMutableBufferPointer<Int>.allocate(capacity: Cardinal(2))
        #expect(buffer.count == 2)
        unsafe buffer.deallocate()
        let raw = unsafe UnsafeMutableRawBufferPointer.allocate(byteCount: Cardinal(16), alignment: Cardinal(8))
        #expect(raw.count == 16)
        let address = UInt(bitPattern: raw.baseAddress!)
        #expect(address % 8 == 0)
        unsafe raw.deallocate()
    }

    @Test
    func `span extraction preserves bounds and mutable views`() {
        var values = [10, 20, 30]
        values.withUnsafeMutableBufferPointer { buffer in
            let pointer = buffer.baseAddress!
            let span = unsafe Span(_unsafeStart: UnsafePointer(pointer), count: Cardinal(3))
            #expect(span.extracting(first: Cardinal(2)).count == 2)
            #expect(span.extracting(last: Cardinal(2))[0] == 20)
            #expect(span.extracting(droppingFirst: Cardinal(2))[0] == 30)
            #expect(span.extracting(droppingLast: Cardinal(2))[0] == 10)
            #expect(span.extracting(first: Cardinal(UInt(Int.max))).count == 3)
            #expect(span.extracting(droppingLast: Cardinal(UInt(Int.max))).count == 0)

            var mutable = unsafe MutableSpan(_unsafeStart: pointer, count: Cardinal(3))
            do {
                var first = mutable.extracting(first: Cardinal(1))
                first[0] = 11
            }
            do {
                var last = mutable.extracting(last: Cardinal(1))
                last[0] = 31
            }
            do {
                var tail = mutable.extracting(droppingFirst: Cardinal(1))
                tail[0] = 21
            }
            do {
                let prefix = mutable.extracting(droppingLast: Cardinal(1))
                #expect(prefix.count == 2)
            }
        }
        #expect(values == [11, 21, 31])
    }

    @Test
    func `output spans append remove and finalize typed counts`() {
        let buffer = unsafe UnsafeMutableBufferPointer<Int>.allocate(capacity: Cardinal(3))
        var output = unsafe OutputSpan(buffer: buffer, initializedCount: Cardinal.zero)
        output.append(repeating: 7, count: Cardinal(2))
        output.removeLast(Count<StorageDomain>(Cardinal(1)))
        output.append(repeating: 9, count: Tagged<StorageDomain, Cardinal>(Cardinal(1)))
        let initialized = unsafe output.finalize(for: buffer)
        #expect(initialized == 2)
        #expect(unsafe buffer[0] == 7)
        #expect(unsafe buffer[1] == 9)
        unsafe buffer.baseAddress!.deinitialize(count: initialized)
        unsafe buffer.deallocate()
    }

    @Test
    func `explicit conversion and full width arithmetic remain available`() throws {
        let maximum = Cardinal(UInt.max)
        let tagged = Tagged<StorageDomain, Cardinal>(maximum)
        #expect(Int(bitPattern: maximum) == -1)
        #expect(Int(bitPattern: tagged) == -1)
        #expect(Int(bitPattern: Count<StorageDomain>(maximum)) == -1)
        #expect(Int(clamping: maximum) == Int.max)
        #expect(Int(clamping: tagged) == Int.max)
        #expect(throws: Cardinal.Error.overflow) { try Int(maximum) }
        #expect(try maximum.add.exact(.zero) == maximum)
        #expect(try maximum.subtract.exact(.one).rawValue == UInt.max - 1)
    }
}
