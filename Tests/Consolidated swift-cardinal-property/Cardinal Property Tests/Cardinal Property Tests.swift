import struct Cardinal.Cardinal
import Addition
import Subtraction
import struct Property.Property
import Cardinal
import Property
import Testing

@Suite
struct `Cardinal properties use canonical arithmetic operations` {
    @Test
    func `Saturating addition returns the sum`() {
        #expect(Cardinal(2).add.saturating(Cardinal(3)).rawValue == 5)
    }

    @Test
    func `Saturating addition clamps overflow to max`() {
        #expect(Cardinal(UInt.max).add.saturating(Cardinal(1)).rawValue == UInt.max)
    }

    @Test
    func `Exact addition returns the sum`() throws {
        #expect(try Cardinal(2).add.exact(Cardinal(3)).rawValue == 5)
    }

    @Test
    func `Exact addition reports overflow`() {
        #expect(throws: Cardinal.Error.overflow) {
            try Cardinal(UInt.max).add.exact(Cardinal(1))
        }
    }

    @Test
    func `Saturating subtraction returns the difference`() {
        #expect(Cardinal(5).subtract.saturating(Cardinal(3)).rawValue == 2)
    }

    @Test
    func `Saturating subtraction clamps underflow to zero`() {
        #expect(Cardinal(2).subtract.saturating(Cardinal(3)).rawValue == 0)
    }

    @Test
    func `Exact subtraction returns the difference`() throws {
        #expect(try Cardinal(5).subtract.exact(Cardinal(3)).rawValue == 2)
    }

    @Test
    func `Exact subtraction reports underflow`() {
        #expect(throws: Cardinal.Error.underflow) {
            try Cardinal(2).subtract.exact(Cardinal(3))
        }
    }

    @Test
    func `The addition tag selects the canonical operation`() throws {
        let tagged: Property<Cardinal.Addition, Cardinal> = Cardinal(2).add
        let canonical: Property<Addition, Cardinal> = tagged
        #expect(try canonical.exact(Cardinal(3)) == Cardinal(5))
    }

    @Test
    func `The subtraction tag selects the canonical operation`() throws {
        let tagged: Property<Cardinal.Subtraction, Cardinal> = Cardinal(5).subtract
        let canonical: Property<Subtraction, Cardinal> = tagged
        #expect(try canonical.exact(Cardinal(3)) == Cardinal(2))
    }
}
