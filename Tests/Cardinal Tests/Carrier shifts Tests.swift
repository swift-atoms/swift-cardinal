import Cardinal
import Testing

private struct Word<Value: FixedWidthInteger>: Carrier::Carrier.`Protocol` {
    let underlying: Value

    init(_ underlying: Value) {
        self.underlying = underlying
    }
}

private struct Shift: Carrier::Carrier.`Protocol` {
    let underlying: Cardinal

    init(_ underlying: Cardinal) {
        self.underlying = underlying
    }
}

private enum Operation: String, CaseIterable, Sendable, Codable {
    case left, right, assignLeft, assignRight
}

@Suite(.timeLimit(.minutes(1)))
struct `Cardinal shifts preserve integer width boundaries` {
    @Test(arguments: Array(UInt(0)..<8))
    func `valid shifts match signed and unsigned integer operations`(amount: UInt) {
        let count = Shift(Cardinal(amount))
        for value: Int8 in [.min, -1, 0, 1, .max] {
            verify(value, count: count)
        }
        for value: UInt8 in [0, 1, 128, .max] {
            verify(value, count: count)
        }
    }

    @Test(arguments: Operation.allCases, [UInt(8), UInt(Int.max) + 1, UInt.max])
    private func `oversized shifts reject raw and carrier operands`(operation: Operation, amount: UInt) async throws {
        for carrier in [false, true] {
            for signed in [false, true] {
                let result = try await #require(
                    processExitsWith: .failure,
                    observing: [\.standardErrorContent]
                ) { [operation = operation as Operation, amount = amount as UInt,
                     carrier = carrier as Bool, signed = signed as Bool] in
                    let count = Shift(Cardinal(amount))
                    if signed {
                        _ = perform(Int8(-1), count: count, operation: operation, carrier: carrier)
                    } else {
                        _ = perform(UInt8.max, count: count, operation: operation, carrier: carrier)
                    }
                }
                #if DEBUG
                let diagnostic = String(decoding: result.standardErrorContent, as: UTF8.self)
                #expect(diagnostic.contains("Shift amount out of range"), "\(diagnostic)")
                #else
                _ = result
                #endif
            }
        }
    }
}

private func verify<Value: FixedWidthInteger>(_ value: Value, count: Shift) {
    let amount = count.underlying.rawValue
    for operation in Operation.allCases {
        let expected = switch operation {
        case .left, .assignLeft: value << amount
        case .right, .assignRight: value >> amount
        }
        #expect(perform(value, count: count, operation: operation, carrier: false) == expected)
        #expect(perform(value, count: count, operation: operation, carrier: true) == expected)
    }
}

private func perform<Value: FixedWidthInteger>(
    _ value: Value, count: Shift, operation: Operation, carrier: Bool
) -> Value {
    if carrier {
        var word = Word(value)
        switch operation {
        case .left: return (word << count).underlying
        case .right: return (word >> count).underlying
        case .assignLeft: word <<= count
        case .assignRight: word >>= count
        }
        return word.underlying
    }
    var raw = value
    switch operation {
    case .left: return raw << count
    case .right: return raw >> count
    case .assignLeft: raw <<= count
    case .assignRight: raw >>= count
    }
    return raw
}
