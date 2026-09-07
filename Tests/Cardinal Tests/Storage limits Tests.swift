import Cardinal
import Testing

@Suite(.timeLimit(.minutes(1)))
struct `Storage counts must be representable before use` {
    @Test(arguments: [
        "array-repeating", "contiguous-repeating", "array-capacity", "contiguous-capacity",
        "string", "reserve", "remove-first", "remove-last", "prefix", "suffix", "drop-first", "drop-last",
        "set-reserve", "set-capacity", "dictionary-reserve", "dictionary-capacity",
        "span-count", "span-first", "span-last", "span-drop-first", "span-drop-last",
        "mutable-span-count", "mutable-span-first", "mutable-span-last", "mutable-span-drop-first", "mutable-span-drop-last",
        "raw-span", "mutable-raw-span", "buffer-count", "mutable-buffer-count", "buffer-allocation",
        "raw-buffer-count", "mutable-raw-buffer-count", "raw-allocation-bytes", "raw-allocation-alignment",
        "initialize", "move-initialize", "output-count", "output-remove", "output-append",
    ], [UInt(Int.max) + 1, UInt.max])
    func `large counts fail at the exact conversion boundary`(operation: String, raw: UInt) async throws {
        let result = try await #require(
            processExitsWith: .failure,
            observing: [\.standardErrorContent]
        ) { [operation = operation as String, raw = raw as UInt] in
            perform(operation, count: Cardinal(raw))
        }
        #if DEBUG
        let diagnostic = String(decoding: result.standardErrorContent, as: UTF8.self)
        #expect(diagnostic.contains("not representable as Int"), "\(diagnostic)")
        #else
        _ = result
        #endif
    }

    @Test(arguments: ["array-return", "array-throw", "contiguous-return", "contiguous-throw"], [UInt(3), UInt(Int.max) + 1, UInt.max])
    func `initialized counts are checked on return and throw`(operation: String, raw: UInt) async throws {
        let result = try await #require(
            processExitsWith: .failure,
            observing: [\.standardErrorContent]
        ) { [operation = operation as String, raw = raw as UInt] in
            do {
                if operation.hasPrefix("array") {
                    let _: [Int] = try unsafe Array(unsafeUninitializedCapacity: Cardinal(2)) {
                        (_, initialized) throws(InitializerFailure) in
                        initialized = Cardinal(raw)
                        if operation.hasSuffix("throw") { throw .element }
                    }
                } else {
                    let _: ContiguousArray<Int> = try unsafe ContiguousArray(unsafeUninitializedCapacity: Cardinal(2)) {
                        (_, initialized) throws(InitializerFailure) in
                        initialized = Cardinal(raw)
                        if operation.hasSuffix("throw") { throw .element }
                    }
                }
            } catch {}
        }
        #if DEBUG
        let diagnostic = String(decoding: result.standardErrorContent, as: UTF8.self)
        let expected = raw > UInt(Int.max) ? "not representable as Int" : "Initialized count exceeds capacity"
        #expect(diagnostic.contains(expected), "\(diagnostic)")
        #else
        _ = result
        #endif
    }
}

private enum InitializerFailure: Swift.Error { case element }

private func perform(_ operation: String, count: Cardinal) {
    var values = [10, 20]
    switch operation {
    case "array-repeating": _ = Array(repeating: 1, count: count)
    case "contiguous-repeating": _ = ContiguousArray(repeating: 1, count: count)
    case "array-capacity":
        let _: [Int] = unsafe Array(unsafeUninitializedCapacity: count) { _, _ in
            preconditionFailure("The initializer must not run")
        }
    case "contiguous-capacity":
        let _: ContiguousArray<Int> = unsafe ContiguousArray(unsafeUninitializedCapacity: count) { _, _ in
            preconditionFailure("The initializer must not run")
        }
    case "string": _ = String(repeating: "a", count: count)
    case "reserve": values.reserveCapacity(count)
    case "remove-first": values.removeFirst(count)
    case "remove-last": values.removeLast(count)
    case "prefix": _ = values.prefix(count)
    case "suffix": _ = values.suffix(count)
    case "drop-first": _ = values.dropFirst(count)
    case "drop-last": _ = values.dropLast(count)
    case "set-reserve":
        var set = Set([1])
        set.reserveCapacity(count)
    case "set-capacity": _ = Set<Int>(minimumCapacity: count)
    case "dictionary-reserve":
        var dictionary = [1: 2]
        dictionary.reserveCapacity(count)
    case "dictionary-capacity": _ = Dictionary<Int, Int>(minimumCapacity: count)
    default: performMemory(operation, count: count)
    }
}

private func performMemory(_ operation: String, count: Cardinal) {
    if operation == "buffer-allocation" {
        let buffer = unsafe UnsafeMutableBufferPointer<Int>.allocate(capacity: count)
        unsafe buffer.deallocate()
        return
    }
    if operation == "raw-allocation-bytes" || operation == "raw-allocation-alignment" {
        let buffer = unsafe UnsafeMutableRawBufferPointer.allocate(
            byteCount: operation == "raw-allocation-bytes" ? count : Cardinal(1),
            alignment: operation == "raw-allocation-alignment" ? count : Cardinal(1)
        )
        unsafe buffer.deallocate()
        return
    }
    let source = UnsafeMutablePointer<Int>.allocate(capacity: 2)
    unsafe source.initialize(repeating: 10, count: 2)
    switch operation {
    case "initialize", "move-initialize":
        let target = UnsafeMutablePointer<Int>.allocate(capacity: 2)
        if operation == "initialize" {
            unsafe target.initialize(from: UnsafePointer(source), count: count)
        } else {
            unsafe target.moveInitialize(from: source, count: count)
        }
    case "buffer-count":
        let buffer = unsafe UnsafeBufferPointer(start: UnsafePointer(source), count: count)
        precondition(buffer.count >= 0)
    case "mutable-buffer-count":
        let buffer = unsafe UnsafeMutableBufferPointer(start: source, count: count)
        precondition(buffer.count >= 0)
    case "raw-buffer-count":
        let buffer = unsafe UnsafeRawBufferPointer(start: UnsafeRawPointer(source), count: count)
        precondition(buffer.count >= 0)
    case "mutable-raw-buffer-count":
        let buffer = unsafe UnsafeMutableRawBufferPointer(start: UnsafeMutableRawPointer(source), count: count)
        precondition(buffer.count >= 0)
    case "raw-span":
        let span = unsafe RawSpan(_unsafeStart: UnsafeRawPointer(source), byteCount: count)
        precondition(span.byteCount >= 0)
    case "mutable-raw-span":
        let span = unsafe MutableRawSpan(_unsafeStart: UnsafeMutableRawPointer(source), byteCount: count)
        precondition(span.byteCount >= 0)
    case "output-count", "output-remove", "output-append":
        let buffer = unsafe UnsafeMutableBufferPointer(start: source, count: 2)
        var output = unsafe OutputSpan(buffer: buffer, initializedCount: operation == "output-count" ? count : Cardinal(2))
        if operation == "output-remove" { output.removeLast(count) }
        if operation == "output-append" { output.append(repeating: 20, count: count) }
        _ = unsafe output.finalize(for: buffer)
    default:
        if operation.hasPrefix("mutable-span") {
            var span = unsafe MutableSpan(_unsafeStart: source, count: operation == "mutable-span-count" ? count : Cardinal(2))
            switch operation {
            case "mutable-span-first": _ = span.extracting(first: count)
            case "mutable-span-last": _ = span.extracting(last: count)
            case "mutable-span-drop-first": _ = span.extracting(droppingFirst: count)
            case "mutable-span-drop-last": _ = span.extracting(droppingLast: count)
            default: break
            }
        } else {
            let span = unsafe Span(_unsafeStart: UnsafePointer(source), count: operation == "span-count" ? count : Cardinal(2))
            switch operation {
            case "span-first": _ = span.extracting(first: count)
            case "span-last": _ = span.extracting(last: count)
            case "span-drop-first": _ = span.extracting(droppingFirst: count)
            case "span-drop-last": _ = span.extracting(droppingLast: count)
            default: break
            }
        }
    }
}
