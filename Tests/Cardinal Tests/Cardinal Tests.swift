import Testing

@testable import Cardinal
import Cardinal_Standard_Library_Integration

extension Cardinal {
    @Suite
    struct Test {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
        @Suite struct Integration {}
        @Suite(.serialized) struct Performance {}
    }
}

extension Cardinal.Test.Unit {

    @Test
    func `construction from UInt`() {
        let count: Cardinal = 42
        #expect(count == 42)
    }

    @Test
    func `construction from int success`() {
        let count: Cardinal = 42
        #expect(count == 42)
    }

    @Test
    func `construction succeeds for non-negative`() throws(Cardinal.Error) {
        let result = Cardinal(42)
        #expect(result == 42)
    }

    @Test
    func `max constant`() {
        #expect(Cardinal.max.rawValue == UInt.max)
    }

    @Test
    func `addition operator`() {
        let a: Cardinal = 5
        let b: Cardinal = 3
        #expect((a + b) == 8)
    }

    @Test
    func comparison() {
        let a: Cardinal = 3
        let b: Cardinal = 5
        #expect(a < b)
        #expect(a <= b)
        #expect(b > a)
        #expect(b >= a)
        #expect(a == a)
    }
}

extension Cardinal.Test.`Edge Case` {

    @Test
    func `construction from int fails for negative`() {
        #expect(throws: Cardinal.Error.negativeSource(-1)) {
            try Cardinal(Int(-1))
        }
    }

    @Test
    func `int conversion throws on overflow`() {
        let count = Cardinal(UInt.max)
        #expect(throws: Cardinal.Error.overflow) {
            try Int(count)
        }
    }
}

extension Cardinal.Test.Integration {

    @Test
    func `description matches UInt`() {
        let count: Cardinal = 42
        #expect(count.description == "42")
    }

    @Test
    func `int conversion success`() throws(Cardinal.Error) {
        let count: Cardinal = 42
        let value = try Int(count)
        #expect(value == 42)
    }

    @Test
    func `int bit pattern conversion preserves bits`() {
        let count = Cardinal(UInt.max)
        let value = Int(bitPattern: count)
        #expect(value == -1)
    }

    @Test
    func `int clamping conversion at max`() {
        let count = Cardinal(UInt.max)
        let value = Int(clamping: count)
        #expect(value == Int.max)
    }
}
